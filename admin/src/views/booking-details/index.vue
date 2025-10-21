<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Booking /</span> Masterlist</h4>
            <div class="card">
              <h5 class="card-header">Manage Booking</h5>
              <div class="table-responsive text-nowrap">
                <table class="table">
                  <thead>
                    <tr>
                      <th>No.</th>
                      <th>Name</th>
                      <th>Contact</th>
                      <th>Event</th>
                      <th>Date</th>
                      <th>Check In</th>
                      <th>Check Out</th>
                      <th>Status</th>
                      <th style="width: 100px;">View</th>
                      <th style="width: 100px;">Activity</th>
                      <th style="width: 100px;">Contract</th>
                      <th style="width: 100px;">Delete</th>
                    </tr>
                  </thead>
                  <tbody class="table-border-bottom-0">
                    <tr v-for="(booking, bi) in bookings" :key="bi">
                      <td>{{ bi + 1 }}</td>
                      <td>{{ booking?.header?.first_name + ' ' + booking?.header?.last_name }}</td>
                      <td>{{ booking?.header?.phone }}</td>
                      <td>{{ booking?.event?.name }}</td>
                      <td>{{ booking?.header?.event_date }}</td>
                      <td>{{ booking?.header?.event_start_time }}</td>
                      <td>{{ booking?.header?.event_end_time }}</td>
                      <td>{{ booking?.status?.value }}</td>
                      <td><button class="btn btn-primary btn-sm" @click="onViewModal(booking)" >View</button></td>
                      <td><button class="btn btn-primary btn-sm" @click="onActivity(booking)">Activity</button></td>
                      <td><button class="btn btn-primary btn-sm" @click="onContract(booking)">Contract</button></td>
                      <td><button class="btn btn-danger btn-sm" @click="onDelete(booking)">Delete</button></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <ModalBookingView :open="modal.view.open" :booking="modal.view.booking" @closed="()=>{ modal.view.open = false; }" @refresh="fetchBooking()" />
    <ModalBookingActivity :open="modal.activity.open" :booking="modal.activity.booking" @closed="()=>{ modal.activity.open = false; }" @refresh="fetchBooking()" />
    <ModalContractEditor :open="modal.contract_editor.open" :booking="modal.contract_editor.booking" @closed="()=>{ modal.contract_editor.open = false; }" @refresh="fetchBooking()" />
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { variable } from '@/var';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import ModalBookingView from "@/components/ModalBookingView.vue";
  import ModalBookingActivity from "@/components/ModalBookingActivity.vue";
  import ModalContractEditor from "@/components/ModalContractEditor.vue";
  import axios from 'axios';
  import Swal from 'sweetalert2';

  export default defineComponent({
    components: { ModalContractEditor, ModalBookingActivity, ModalBookingView, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        bookings: {} as any,
        modal: {
          view: {
            open: false,
            booking: {} as Object
          },
          activity: {
            open: false,
            booking: {} as Object
          },
          contract_editor: {
            open: false,
            booking: {} as Object
          }
        }
      }
    },
    methods: {
      async fetchBooking() {
        await axios.get( variable()['api_main'] + "booking/fetchAll" ).then( async (bookings) => {
          this.bookings = bookings.data;
        });
      },
      async onViewModal(booking: object) {
        this.modal.view.booking   = booking;
        this.modal.view.open      = true;
      },
      async onActivity(booking: any) {
        this.modal.activity.booking   = booking;
        this.modal.activity.open      = true;
      },
      async onContract(booking: any) {
        this.modal.contract_editor.booking   = booking;
        this.modal.contract_editor.open      = true;
      },
      async onDelete(booking: any) {
        if(this.admin?.role == 1) {
          Swal.fire({
            title: "Confirmation",
            text: "Delete booking of " + booking?.header?.first_name + "?",
            showCancelButton: true,
            confirmButtonText: "Delete",
            icon: "question"
          }).then( async (result) => {
            if (result.isConfirmed) {
              await axios.get( variable()['api_main'] + "booking/delete?booking_dataid=" + booking?.header?.dataid ).then( async (response) => {
                if(response.data?.success) {
                  Swal.fire({
                    title: 'Deleted',
                    text: response.data?.message,
                    icon: 'success'
                  }).then( async () => {
                    await this.fetchBooking();
                  });
                }
                else {
                  Swal.fire({
                    title: 'Warning',
                    text: response.data?.message,
                    icon: 'warning'
                  });
                }
              });
            }
          });
        }
        else {
          Swal.fire({
            title: 'Action denied',
            text: 'Only administrator level has permission to delete a booking',
            icon: 'error'
          });
        }
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchBooking().then( async () => {
            console.log("Booking Details:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>