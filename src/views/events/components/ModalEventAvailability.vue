<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Check Availability</h5>
        </div>
        <div class="modal-body">
          <div class="row">
<div class="col-sm-12 col-md-7">
  <img class="w-100" src="/src/assets/image/people.jfif"/>
  <h1>{{ event?.name }}</h1>

  <!-- Direct hardcoded description for Baptism -->
  <p v-if="event?.name === 'Baptism'" class="baptism-description">
    Baptism is a sacred Christian ceremony where a child or adult is welcomed into the faith. 
    The event usually includes prayers, blessings, and a small celebration with family and friends.
  </p>

  <!-- Default description for other events -->
  <p v-else class="default-description">
    This is a wonderful event where everyone is welcome to join and celebrate the special occasion.
  </p>

  <table class="table">
    <tbody>
      <tr>
        <td>Min capacity</td>
        <td>{{ event?.min_occupancy }}</td>
      </tr>
      <tr>
        <td>Max capacity</td>
        <td>{{ event?.max_occupancy }}</td>
      </tr>
      <tr>
        <td>Price per pack</td>
        <td>PHP {{ event?.price }}</td>
      </tr>
    </tbody>
  </table>
</div>


     <div class="col-sm-12 col-md-5">
  <div class="availability-card p-4 rounded">
    <h2 class="mb-4 text-dark">Enter date and time to verify availability</h2>
    <div class="mb-3">
      <label class="form-label text-dark">Date of Visit</label>
      <input v-model="form.date" type="date" class="form-control form-control-lg">
    </div>
    <div class="mb-3">
      <label class="form-label text-dark">Select Start Time</label>
      <input v-model="form.start_time" type="time" class="form-control form-control-lg">
    </div>
    <div class="mb-3">
      <label class="form-label text-dark">Select End Time</label>
      <input v-model="form.end_time" type="time" class="form-control form-control-lg">
    </div>
<button class="btn btn-check-availability btn-lg w-100 mt-3" @click="checkAvailability()">Check Availability</button>
  </div>
</div>
</div>
          <div class="alert alert-warning mt-4">
            <p>
              <small>"Only 50 pax can be accommodate for a one-day preparation, and no bookings will be accepted for the following day. Any such booking will be automatically cancelled."</small>
            </p>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" @click="closeModal()">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { variable } from '@/var';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import ls from 'localstorage-slim';
  import axios from 'axios';
  import $ from 'jquery';
  import Swal from 'sweetalert2';


  export default defineComponent({
    name: "ModalEventAvailability",
    props: {
      open: {
        default: true,
        type: Boolean
      },
      event: {
        default: {},
        type: Object
      }
    },
    data() {
      return {
        form: {
          date: '',
          start_time: '',
          end_time: '',
        }
      }
    },
    methods: {
      async closeModal() {
        this.$emit("closed");
      },
      async checkAvailability() {
        await axios.get( variable()['api_main'] + "events/checkAvailability?" + $.param(this.form) ).then( async (response) => {
          console.log(response.data);
          if(response.data?.success) {
            Swal.fire({
              title: "Available",
              text: "Your selected date and time is available, would you like to proceed in booking process?",
              icon: "question",
              showCancelButton: true,
              cancelButtonText: "Maybe later",
              confirmButtonColor: "#3085d6",
              cancelButtonColor: "#d33",
              confirmButtonText: "Yes, Proceed to Booking"
            }).then( async (result) => {
              if (result.isConfirmed) {
                await this.proceedToBooking();
              }
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
        
      },
      async proceedToBooking() {
        await getLocalUser().then( async (user) => {
          if(user) {
            var args = {
              user_dataid: user?.dataid,
              pax_price: this.event?.price,
              event_dataid: this.event?.dataid,
              event_date: this.form.date,
              event_start_time: this.form.start_time,
              event_end_time: this.form.end_time,
            };
            await axios.get( variable()['api_main'] + "booking/initBooking?" + $.param(args) ).then( async (response) => {
              if(response.data?.success) {
                ls.set('booking-event', this.event );
                ls.set('booking-dataid', response.data?.last_dataid);
                this.$router.replace('/events-booking');
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
          else {
            Swal.fire({
              title: 'Sign In required',
              text: 'Please sign in or create account to continue',
              icon: 'warning'
            });
          }
        });
      }
    }
  });

</script>
<style scoped>
.availability-card {
  background-color: #ffe6eb; /* light pink */
  padding: 30px;              /* more spacing inside */
  border-radius: 0.5rem;
  min-height: 600px;          /* taller card */
  width: 100%;                /* full width of its column */
  max-width: 450px;           /* optional: limit max width */
  box-sizing: border-box;     /* include padding in width */
  display: flex;
  flex-direction: column;
  justify-content: flex-start; /* keeps content at the top */
}

/* Button styling */
.btn-check-availability {
  background-color: #e63946; /* red */
  border-color: #e63946;
  color: #fff;
  transition: background-color 0.2s ease, border-color 0.2s ease;
}

.btn-check-availability:hover {
  background-color: #d42e3f; /* slightly darker red on hover */
  border-color: #d42e3f;
  margin-top: 20px;
}

/* Input fields focus styling */
.availability-card input.form-control:focus {
  border-color: #e63946 !important;       /* red border */
  box-shadow: 0 0 8px rgba(230, 57, 70, 0.8) !important; /* visible red glow */
  outline: none !important;
}

/* Optional: smooth transition for focus effect */
.availability-card input.form-control {
  transition: box-shadow 0.2s ease, border-color 0.2s ease;
}

</style>


