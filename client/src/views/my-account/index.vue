<template>
  <div>
    <SectionHeader/>
    <main class="main">
      <div class="content">
        <div class="container">
          <div class="container" style="min-height: calc(100vh - 300px);">
            <div class="table-responsive">
              <h1 class="pt-5">Hi, {{ user?.firstname }}</h1>
              <h3>Manage Booking</h3>
              <table class="table mt-4 bg-dark text-white">
                <thead>
                  <tr>
                    <th class="py-2">No</th>
                    <th class="py-2">Event</th>
                    <th class="py-2">No. Pax</th>
                    <th class="py-2">Date</th>
                    <th class="py-2">Start Time</th>
                    <th class="py-2">End Time</th>
                    <th class="py-2">Added Fee</th>
                    <th class="py-2">Grand Total</th>
                    <th class="py-2">Status</th>
                    <th class="py-2" style="width: 100px;">Payment</th>
                    <th class="py-2" style="width: 100px;">Details</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(booking, bi) in bookings" :key="bi">
                    <td>{{ bi + 1 }}</td>
                    <td>{{ booking?.event?.name }}</td>
                    <td>{{ booking?.header?.event_pax }}pax</td>
                    <td>{{ booking?.header?.event_date }}</td>
                    <td>{{ booking?.header?.event_start_time }}</td>
                    <td>{{ booking?.header?.event_end_time }}</td>
                    <td>{{ toCurrencyFormat(booking?.header?.add_fee_amount) }}</td>
                    <td>{{ toCurrencyFormat(parseFloat(booking?.header?.total_price) + parseFloat(booking?.header?.add_fee_amount)) }}</td>
                    <td>{{ booking?.status?.value }}</td>
                    <td><button class="btn btn-success btn-sm" @click="openPayment(booking)" >Payment</button></td>
                    <td><button class="btn btn-primary btn-sm" @click="openBooking(booking)" >Details</button></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
      <SectionFooter/>
      <ModalBooking 
        :open="modal.booking.open"
        :booking="modal.booking.booking"
        @closed="()=>{ modal.booking.open = false; }"
        @refresh="fetchMyBooking()"
      />
      <ModalPayment 
        :open="modal.payment.open"
        :booking="modal.payment.booking"
        @closed="()=>{ modal.payment.open = false; }"
        @refresh="fetchMyBooking()"
      />
    </main>
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from "@/assets/ts/localStorage.ts";
  import { toCurrency } from "@/assets/ts/formatter.ts";
  import { variable } from '@/var';
  import SectionHeader from "@/components/SectionHeader.vue";
  import SectionFooter from "@/components/SectionFooter.vue";
  import ModalBooking from "./components/ModalBooking.vue";
  import ModalPayment from "./components/ModalPayment.vue";
  import $ from 'jquery';
  import axios from 'axios';
  import Swal from 'sweetalert2';

  export default defineComponent({
    name: "MyAccountPage",
    components: { ModalPayment, ModalBooking, SectionFooter, SectionHeader },
    data() {
      return {
        loading: false,
        user: {} as any,
        bookings: {} as any,
        modal: {
          booking: {
            open: false,
            booking: {} as any
          },
          payment: {
            open: false,
            booking: {} as any
          }
        }
      }
    },
    methods: {
      toCurrencyFormat(amount: number) {
        if(isNaN(amount)) {
          return toCurrency(0);
        }
        else {
          return toCurrency(amount);
        }
      },
      openPayment(booking: any) {
        this.modal.payment.open     = true;
        this.modal.payment.booking  = booking;
      },
      openBooking(booking: any) {
        this.modal.booking.open     = true;
        this.modal.booking.booking  = booking;
      },
      async fetchMyBooking() {
        await axios.get( variable()['api_main'] + "booking/fetchByUser/" + this.user?.dataid ).then( async (response) => {
          this.bookings = response.data;
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (user) => {
        this.user = user;
        if(user) {
          await this.fetchMyBooking().then( async () => {
            console.log("My Account:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    }
  });

</script>