<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="d-flex justify-content-between align-items-center py-3">
              <h4 class="fw-bold">Manage Events</h4>
              <div class="d-flex">
                <button class="btn btn-primary" @click="()=>{ modal.add.open = true; }">Add Event</button>
              </div>
            </div>
            <div class="card">
              <h5 class="card-header">Manage Events</h5>
              <div class="table-responsive text-nowrap">
                <table class="table">
                  <thead>
                    <tr>
                      <th>No.</th>
                      <th>Event</th>
                      <th>Price/pax</th>
                      <th>Min. Occ.</th>
                      <th>Max. Occ.</th>
                      <th style="width: 100px;">View</th>
                      <th style="width: 100px;">Update</th>
                      <th style="width: 100px;">Delete</th>
                    </tr>
                  </thead>
                  <tbody class="table-border-bottom-0">
                    <tr v-for="(event, ei) in events" :key="ei">
                      <td>{{ ei + 1 }}</td>
                      <td>{{ event?.name }}</td>
                      <td>{{ toCurrencyFormat(event?.price) }}</td>
                      <td>{{ event?.min_occupancy }}</td>
                      <td>{{ event?.max_occupancy }}</td>
                      <td><button class="btn btn-primary btn-sm" @click="onModalView(event)" >View</button></td>
                      <td><button class="btn btn-primary btn-sm" @click="onModalUpdate(event)">Update</button></td>
                      <td><button class="btn btn-danger btn-sm" @click="onModalDelete(event)">Delete</button></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <ModalEventView :open="modal.view.open" :event="modal.view.event" @closed="()=>{ modal.view.open = false; }" @refresh="fetchEvents()" />
    <ModalEventUpdate :open="modal.update.open" :event="modal.update.event" @closed="()=>{ modal.update.open = false; }" @refresh="fetchEvents()" />
    <ModalEventAdd :open="modal.add.open" @closed="()=>{ modal.add.open = false; }" @refresh="fetchEvents()" />
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { variable } from '@/var';
  import { toCurrency } from '@/assets/ts/formatter';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import ModalEventView from "./components/ModalEventView.vue";
  import ModalEventUpdate from "./components/ModalEventUpdate.vue";
  import ModalEventAdd from "./components/ModalEventAdd.vue";
  import axios from 'axios';
  import Swal from 'sweetalert2';

  export default defineComponent({
    components: { ModalEventAdd, ModalEventUpdate, ModalEventView, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        events: {} as any,
        modal: {
          view: {
            open: false,
            event: {} as any
          },
          update: {
            open: false,
            event: {} as any
          },
          add: {
            open: false
          }
        },
      }
    },
    methods: {
      toCurrencyFormat(amount: number) {
        return toCurrency(amount);
      },
      onModalView(event: any) {
        this.modal.view.event = event;
        this.modal.view.open  = true;
      },
      onModalUpdate(event: any) {
        this.modal.update.event = event;
        this.modal.update.open  = true;
      },
      onModalDelete(event: any) {
        if(this.admin?.role == 1) {
          Swal.fire({
            title: "Confirmation",
            text: "Delete " + event?.name + "?",
            showCancelButton: true,
            confirmButtonText: "Delete",
            icon: "question"
          }).then( async (result) => {
            if (result.isConfirmed) {
              await axios.get( variable()['api_main'] + "events/delete?dataid=" + event?.dataid ).then( async (response) => {
                if(response.data?.success) {
                  Swal.fire({
                    title: 'Success',
                    text: response.data?.message,
                    icon: 'success'
                  }).then( async () => {
                    await this.fetchEvents();
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
            text: 'Only administrator level has permission to delete',
            icon: 'error'
          });
        }
      },
      async fetchEvents() {
        await axios.get( variable()['api_main'] + "events/fetchAll").then( async (response) => {
          this.events = response.data;
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchEvents().then( async () => {
            console.log("Events:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>