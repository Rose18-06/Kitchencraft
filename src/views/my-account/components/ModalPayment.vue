<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Payment</h5>
        </div>
        <div class="modal-body bg-light-gray" style="max-height: calc(100vh - 300px);overflow: auto;">
          <swiper :slides-per-view="1" :space-between="50" @swiper="onSwiper">
            <swiper-slide class="swiper-no-swiping">
              <div class="card">
                <div class="card-body">
                  <h3 class="text-center">GCash Payment</h3>
                  <p class="text-center"><small>Scan the GCash QR code below and pay the total amount to complete your booking.<br/>You need to pay 50% of the total. Here is 50% of your order.</small></p>
                  <img class="gcash-image" src="/src/assets/image/gcashho.png" />
                  <p class="text-center fs-4 fw-bold p-0 m-0">Transfer fees may apply</p>
                  <p class="text-center fs-2 fw-bold p-0 m-0" style="color: #085bde;">AI**E L.</p>
                  <p class="text-center fs-4 fw-bold p-0 m-0">
                    <span>Mobile No.: </span>
                    <span>091* ****911</span>
                  </p>
                  <p class="mb-4 text-muted text-center">Once payment is made, upload your receipt to confirm your booking.</p>
                  <div class="row mt-5 mb-4">
                    <div class="col-6">
                      <label class="form-label">Reference No.</label>
                      <input v-model="pay_refid" type="number" class="form-control">
                    </div>
                    <div class="col-6">
                      <label class="form-label">Sender Name</label>
                      <input v-model="pay_sender" type="text" class="form-control">
                    </div>
                  </div>
                  
                  <div class="d-flex justify-content-center">
                    <button class="btn btn-primary w-50" @click="slideToUpload()" >Upload Payment Receipt</button>
                  </div>
                </div>
              </div>
            </swiper-slide>
            <swiper-slide class="swiper-no-swiping">
              <div class="card">
                <div class="card-body">
                  <h3 class="text-center">GCash Payment Receipt</h3>
                  <p class="text-center"><small>Please upload screenshot of your payment</small></p>
                  <CardPhotoUploader
                    @uploaded="onUploadSuccess"
                    @fail="onUploadFail"
                  />
                  <div class="d-flex justify-content-end mt-4">
                    <button class="btn btn-primary w-25">Submit Receipt</button>
                  </div>
                </div>
              </div>
            </swiper-slide>
          </swiper>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="closeModal()">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { variable } from '@/var';
  import { toCurrency } from "@/assets/ts/formatter.ts";
  import { Swiper, SwiperSlide } from 'swiper/vue';
  import { getBookingDataID } from "@/assets/ts/localStorage.ts";
  import CardPhotoUploader from "@/components/CardPhotoUploader.vue";
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
    components: { CardPhotoUploader, Swiper, SwiperSlide },
    data() {
      return {
        swiper: {} as any,
        done: false,
        pay_refid: '',
        pay_sender: ''
      }
    },
    methods: {
      onSwiper(swiper: any) {
        this.swiper = swiper;
      },
      closeModal() {
        this.$emit("closed");
      },
      toCurrencyFormat(amount: number) {
        return toCurrency(amount);
      },
      slideToUpload() {
        if(this.pay_refid == '') {
          Swal.fire({
            title: 'Warning',
            text: 'Payment Reference Number is required',
            icon: 'warning'
          });
        }
        else if(this.pay_sender == '') {
          Swal.fire({
            title: 'Warning',
            text: 'Payment Sender Name is required',
            icon: 'warning'
          });
        }
        else {
          this.swiper.slideTo(1);
        }
      },
      async onUploadSuccess(event: any) {
        if(this.pay_refid == '') {
          Swal.fire({
            title: 'Warning',
            text: 'Payment Reference Number is required',
            icon: 'warning'
          });
        }
        else if(this.pay_sender == '') {
          Swal.fire({
            title: 'Warning',
            text: 'Payment Sender Name is required',
            icon: 'warning'
          });
        }
        else {
          await getBookingDataID().then( async () => {
            var args = {
              booking_dataid: this.booking?.header.dataid,
              photo: event?.data?.filepath,
              pay_refid: this.pay_refid,
              pay_sender: this.pay_sender,
              customer_name: this.booking?.header.first_name + ' ' + this.booking?.header.last_name,
              customer_email: this.booking?.header.email,
              event_name: this.booking?.event.name,
              event_location: this.booking?.header.event_location
            };
            var uri = variable()['api_main'] + "booking/updatePaymentReceipt?" + $.param(args);
            console.log("Post:", uri);
            await axios.get( uri ).then( async (response) => {
              if(response.data?.success) {
                this.done = true;
                Swal.fire({
                  title: 'Uploaded',
                  text: 'Payment receipt uploaded successfully',
                  icon: 'info'
                }).then( () => {
                  
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
          });
        }
      },
      onUploadFail(event: any) {
        Swal.fire({
          title: 'Warning',
          text: 'Fail to upload photo, try again later.',
          icon: 'warning'
        });
      },
    },
    watch: {
      open: function () {
        console.log(toRaw(this.booking));
      }
    }
  });

</script>
<style scoped>
  .display {
    display: block;
    background-color: #0a0a0a42;
  }
  .gcash-image {
    display: block;
    margin: 0 auto;
    width: 220px;
  }
</style>