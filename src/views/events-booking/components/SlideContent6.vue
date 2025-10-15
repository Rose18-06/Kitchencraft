<template>
  <div class="p-5">
    <h1>Place Reservation</h1>
    <div class="mt-4">
      <h4>Guest Details Of Who Will Pay the Booking</h4>
      <p>Fill in your information below.</p>
      <div class="row">
        <div class="col-sm-12 col-md-6">
          <label class="form-label">First name</label>
          <input v-model="form.first_name" type="text" class="form-control form-control-lg" readonly>
        </div>
        <div class="col-sm-12 col-md-6">
          <label class="form-label">Last name</label>
          <input v-model="form.last_name"  type="text" class="form-control form-control-lg" readonly>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-12 col-md-6">
          <label class="form-label">Email</label>
          <input v-model="form.email" type="text" class="form-control form-control-lg" readonly>
        </div>
        <div class="col-sm-12 col-md-6">
          <label class="form-label">Phone</label>
          <input v-model="form.phone" type="text" class="form-control form-control-lg" readonly>
        </div>
      </div>
      <p class="mt-4">Please read and agree to the terms and conditions before proceeding:</p>
      <div style="text-align: left; max-height: 150px; overflow-y: auto; border: 1px solid #ccc; padding: 10px; margin-bottom: 10px;">
        <p>Non-Refundable Deposit : By proceeding with the payment, you acknowledge that 50% of the total amount is non-refundable deposit to confirm your booking .</p>
        <p>Rescheduling : you may reschedule the event, subject to availability, with advance notice as per our policy. additional charge may apply.</p>
        <p>Final Payment : The remaining balance must be settled by the specified deadline before the event</p>
        <p>Changes or cancellations may incur charges.</p>
        <p>All information provided must be accurate.</p>
      </div>
      <div style="text-align: left;">
        <input type="checkbox" @change="onAgree" :checked="agree">
        <label for="agreeCheckbox" class="me-2"> I agree to the </label><span @click="openAgreement()" class="text-dark" style="text-decoration: underline;font-weight: bold;">Terms and Conditions</span>
      </div>
    </div>
    <div class="d-flex justify-content-end">
      <button class="btn btn-outline-secondary btn-lg me-4" style="width: 200px;" @click="backSlide()" :disabled="loading">Back</button>
      <button class="btn btn-primary btn-lg" style="width: 200px;" @click="postBooking()" :disabled="loading">Reserve Booking</button>
    </div>
    <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Terms and Conditions</h5>
          </div>
          <div class="modal-body">
            <p><strong>Charges Outside Venue</strong></p>
            <p>1. Event Extension: If the event extends beyond the agreed duration, an additional charge of Php 1,000 per hour will apply.</p>
            <p>2. Menu Changes After Reservation:</p>
            <ul>
              <li>The Client may request changes to the menu 2-5 days before the reservation date, provided that the preparation of the menu has not yet commenced.</li>
              <li>Any menu changes requested after the specified timeframe or once preparation has begun will incur additional charges, which will depend on the complexity and cost of the new menu.</li>
              <li>Additional charges may apply if the requested changes result in costs exceeding the original menu price.</li>
            </ul>
            <hr/>
            <p><strong>Salary of Staff (Overtime)</strong></p>
            <p>1. The usual duration of an event is 3-4 hours.</p>
            <p>2. If the event exceeds this duration, a corresponding overtime charge will apply, and the staff’s salary will be doubled for the extended hours</p>
            <hr/>
            <p><strong>Policy on Cancellation and Incidents</strong></p>
            <p>1. In the event of a cancellation by the Client, 20% of the down payment will be forfeited.</p>
            <p>2. This forfeiture also applies to other unforeseen incidents that may prevent the event from proceeding as planned.</p>
            <hr/>
            <p><strong>Damages to Property</strong></p>
            <p>1. The Client is responsible for any damage to items or property owned by Kitchencraft's Catering during the event</p>
            <p>2. Examples include, but are not limited to, broken plates, chairs, or other equipment.<br/>
              The Client will be charged the cost of repair or replacement for any damaged items</p>
            <hr/>
            <p><strong>Acknowledgment and Agreemen</strong></p>
            <p>By placing a booking, the Client acknowledges that they have read, understood, and agree to the terms and conditions outlined in this Agreement</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary w-25" @click="()=>{ open = false; }" >Close</button>
            <button type="button" class="btn btn-primary w-25" @click="()=>{ open = false; agree = true; }" >Agree</button>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { variable } from '@/var';
  import axios from 'axios';
  import { getBookingDataID } from '@/assets/ts/localStorage';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import Swal from 'sweetalert2';
  import $ from 'jquery';

  export default defineComponent({
    name: "SlideContent5",
    emits: ['next', 'back', 'refresh'],
    data() {
      return {
        loading: false,
        form: {
          booking_dataid: '',
          first_name: '',
          last_name: '',
          email: '',
          phone: '',
          total_price: 0
        },
        agree: false,
        user: {} as any,
        open: false
      }
    },
    methods: {
      openAgreement() {
        this.open = true;
      },
      onAgree(event: any) {
        this.agree = event.target.checked;
      },
      async postBooking() {
        if(this.agree) {
          this.loading = true;
          await getBookingDataID().then( async (booking_dataid) => {
            this.form.booking_dataid = booking_dataid;
            await axios.get( variable()['api_main'] + "booking/profile?booking_dataid=" + booking_dataid ).then( async (profile) => {
              this.form.total_price = profile.data?.grand_total;
              await axios.get( variable()['api_main'] + "booking/placeReservation?" + $.param(this.form) ).then( async (response) => {
                this.loading = false;
                if(response.data?.success) {
                  Swal.fire({
                    title: 'Success',
                    text: response.data?.message,
                    icon: 'success'
                  }).then( async () => {
                    this.form.booking_dataid  = '';
                    this.form.first_name      = '';
                    this.form.last_name       = '';
                    this.form.email           = '';
                    this.form.phone           = '';
                    this.$router.replace('/events-booking-placed');
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
          });
        }
        else {
          Swal.fire({
            title: 'Warning',
            text: 'You need to agree in our terms and conditions to proceed',
            icon: 'warning'
          });
        }
      },
      backSlide() {
        this.$emit('back', { data: { index: 2 }});
      }
    },
    async mounted() {
      await getLocalUser().then( async (user) => {
        this.user               = user;
        this.form.first_name    = user?.firstname;
        this.form.last_name     = user?.lastname;
        this.form.email         = user?.email;
        this.form.phone         = user?.contact;
      });
    },
  });

</script>
<style scoped>
  .display {
    display: block;
    background-color: #0a0a0a42;
  }
</style>
