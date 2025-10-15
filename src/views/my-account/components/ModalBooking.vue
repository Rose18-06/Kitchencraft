<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Booking Details</h5>
        </div>
        <div class="modal-body bg-light-gray" style="max-height: calc(100vh - 300px);overflow: auto;">
          <div v-show="booking?.status?.key == 4 ? true : false " class="alert alert-danger">
            <p class="text-center fs-3 p-0 m-0"><strong>CANCELLED</strong></p>
            <p class="text-center p-0 m-0">This booking has been cancelled by customer</p>
          </div>
          <h5>Event Details</h5>
          <div class="card">
            <div class="card-body">
              <table class="table-borderless">
                <tbody>
                  <tr>
                    <td style="width: 180px;">Event</td>
                    <td>{{ booking?.event?.name }}</td>
                  </tr>
                  <tr>
                    <td style="width: 180px;">Location Type</td>
                    <td>{{ booking?.location?.key }}</td>
                  </tr>
                  <tr>
                    <td style="width: 180px;">Date</td>
                    <td>{{ booking?.header?.event_date }}</td>
                  </tr>
                  <tr>
                    <td style="width: 180px;">Check In</td>
                    <td>{{ booking?.header?.event_start_time }}</td>
                  </tr>
                  <tr>
                    <td style="width: 180px;">Check Out</td>
                    <td>{{ booking?.header?.event_end_time }}</td>
                  </tr>
                  <tr :title="booking?.header.add_fee_description">
                    <td style="width: 180px;">Added Fees</td>
                    <td>{{ toCurrencyFormat(booking?.header?.add_fee_amount) }}</td>
                  </tr>
                  <tr>
                    <td style="width: 180px;">Grand Total</td>
                    <td>{{ toCurrencyFormat(parseFloat(booking?.header?.total_price) + parseFloat(booking?.header?.add_fee_amount)) }}</td>
                  </tr>
                  <tr>
                    <td style="width: 180px;">Status</td>
                    <td>{{ booking?.status?.value }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <h5 class="mt-4">Food</h5>
          <div class="card">
            <div class="card-body">
              <table class="table">
                <thead>
                  <tr>
                    <th>No</th>
                    <th>Name</th>
                    <th>Category</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(food, fi) in booking?.food">
                    <td>{{ fi + 1 }}</td>
                    <td>{{ food?.name }}</td>
                    <td>{{ food?.category }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <h5 class="mt-4">Add-ons</h5>
          <div class="card">
            <div class="card-body">
              <table class="table">
                <thead>
                  <tr>
                    <th>No</th>
                    <th>Name</th>
                    <th>Price</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(addon, ai) in booking?.addons" :key="ai">
                    <td>{{ ai + 1 }}</td>
                    <td>{{ addon?.name }}</td>
                    <td>{{ toCurrencyFormat(addon?.booking_addons_price) }}</td>
                  </tr>
                </tbody>
              </table>
              <div class="d-flex justify-content-start">
                <p>Total: {{ toCurrencyFormat(booking?.addons_total) }}</p>
              </div>
            </div>
          </div>
          <h5 class="mt-4">Customer Details</h5>
          <div class="card">
            <div class="card-body">
              <table class="table-borderless">
                <tbody>
                  <tr>
                    <td style="width: 180px;">Customer Name</td>
                    <td>: {{ booking?.header?.first_name + ' ' + booking?.header?.last_name }}</td>
                  </tr>
                  <tr>
                    <td>Email</td>
                    <td>: {{ booking?.header?.email }}</td>
                  </tr>
                  <tr>
                    <td>Mobile</td>
                    <td>: {{ booking?.header?.phone }}</td>
                  </tr>
                  <tr>
                    <td>Location</td>
                    <td>: {{ booking?.location?.key }}</td>
                  </tr>
                  <tr>
                    <td>Valid ID</td>
                    <td>:</td>
                  </tr>
                </tbody>
              </table>
              <img class="w-100 mt-3" :src="booking?.valid_id"/>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="closeModal()">Close</button>
          <button v-show="booking?.status?.key == 4 ? false : true "  class="btn btn-danger" @click="onCancelBooking()" >Cancel Booking</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { variable } from '@/var';
  import { toCurrency } from "@/assets/ts/formatter.ts";
  import axios from 'axios';
  import Swal from 'sweetalert2';
  import $ from 'jquery';

  export default defineComponent({
    emits: ['closed', 'refresh'],
    props: {
      open: {
        default: false,
        type: Boolean
      },
      booking: {
        default: {},
        type: Object
      }
    },
    data() {
      return {}
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      toCurrencyFormat(amount: number) {
        return toCurrency(amount);
      },
      async onCancelBooking() {
        Swal.fire({
          title: 'Confirmation',
          text: 'Cancel booking for ' + this.booking?.event?.name + '?',
          icon: 'question',
          showCancelButton: true,
          confirmButtonText: "Yes",
        }).then( async (result) => {
          if(result.isConfirmed) {
            var args = {
              booking_dataid: this.booking?.header?.dataid,
              email: this.booking?.header?.email,
              book_event: this.booking?.event?.name
            };
            await axios.get( variable()['api_main'] + "booking/cancel?" + $.param(args) ).then( async (response) => {
              if(response.data?.success) {
                Swal.fire({
                  title: 'Success',
                  text: '',
                  icon: 'success'
                }).then( async () => {
                  this.$emit('refresh');
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
    },
    watch: {
      open: function() {
        if(this.open) {
          console.log(toRaw(this.booking));
        }
      }
    }
  });

</script>
<style scoped>
  .display {
    display: block;
    background-color: #0a0a0a42;
  }
</style>