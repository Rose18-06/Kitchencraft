<template>
  <div class="py-4 d-flex justify-content-center">
    <!-- Main Card for Your Reservation with Shadow + Hover -->
    <div class="card main-reservation-card w-100" style="max-width: 600px;">
      <div class="card-body">

        <!-- Header -->
        <h1 class="card-title">Your Reservation</h1>
        <p class="card-subtitle mb-3 text-muted">Ensure your booking is as smooth as possible</p>

        <!-- Date and Time Card -->
        <div class="card my-3">
          <div class="card-body">
            <h6 class="fw-bold">Date and Time</h6>
            <table class="table table-striped table-borderless mb-0">
              <tbody>
                <tr>
                  <td style="width: 120px;">Date of Visit</td>
                  <td>: {{ profile?.header?.event_date }}</td>
                </tr>
                <tr>
                  <td>Start Time</td>
                  <td>: {{ profile?.header?.event_start_time }}</td>
                </tr>
                <tr>
                  <td>End Time</td>
                  <td>: {{ profile?.header?.event_end_time }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Food List Card -->
        <div class="card my-3">
          <div class="card-body">
            <h6 class="fw-bold">Food List</h6>
            <table class="table table-striped table-borderless mb-0">
              <tbody>
                <tr v-for="(food, fi) in profile?.foods?.foods" :key="fi">
                  <td style="width: 180px;">{{ food?.name }}</td>
                  <td>: {{ food?.category }}</td>
                  <td>
                    <i class="bi bi-x-lg" style="cursor: pointer;" @click="removeFood(food?.booking_food_dataid)"></i>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Add-ons Card -->
        <div class="card my-3">
          <div class="card-body">
            <h6 class="fw-bold">Add-ons</h6>
            <table class="table table-striped table-borderless mb-0">
              <tbody>
                <tr v-for="(addon, pi) in profile?.addons?.addons" :key="pi">
                  <td style="width: 180px;">{{ addon?.name }}</td>
                  <td>: {{ toCurrencyFormat(addon?.booking_addons_price) }}</td>
                  <td>
                    <i class="bi bi-x-lg" style="cursor: pointer;" @click="removeAddOns(addon?.booking_addons_dataid)"></i>
                  </td>
                </tr>
                <tr>
                  <td><b>Total</b></td>
                  <td><b>: {{ toCurrencyFormat(profile?.addons?.total) }}</b></td>
                  <td></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Valid ID Card -->
        <div class="card my-3">
          <img class="w-100" :src=" profile?.header?.valid_id_path ? 'https://api-fileserver.jlipreso.com/' + profile?.header?.valid_id_path : '' " />
          <div class="card-body">
            <h6 class="fw-bold">Valid ID</h6>
          </div>
        </div>

        <!-- Costs Summary Card -->
        <div class="card my-3">
          <div class="card-body">
            <h6 class="fw-bold mb-3">Costs Summary</h6>

            <div class="d-flex justify-content-between mb-2">
              <span>Inclusion Cost</span>
              <span>{{ toCurrencyFormat(profile?.pax_cost?.value) }}
                <i class="bi bi-info-circle-fill text-info" :title="profile?.pax_cost?.label"></i>
              </span>
            </div>

            <hr />

            <div class="d-flex justify-content-between">
              <span>Grand Total</span>
              <span class="grand-total">{{ toCurrencyFormat(profile?.grand_total) }}</span>
            </div>

          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { getBookingDataID } from '@/assets/ts/localStorage';
import { variable } from '@/var';
import axios from 'axios';
import { defineComponent } from 'vue';
import { toCurrency } from '@/assets/ts/formatter';

export default defineComponent({
  name: "SummarySection",
  props: ['refresh'],
  data() {
    return {
      profile: {} as any
    }
  },
  watch: {
    refresh: async function () {
      this.fetchProfile();
    }
  },
  methods: {
    async fetchProfile() {
      await getBookingDataID().then(async (booking_dataid) => {
        await axios.get(variable()['api_main'] + "booking/profile?booking_dataid=" + booking_dataid).then(async (profile) => {
          this.profile = profile.data;
        });
      });
    },
    async removeFood(dataid: number) {
      await axios.get(variable()['api_main'] + "booking_foods/remove/" + dataid).then(async () => {
        await this.fetchProfile();
      });
    },
    async removeAddOns(dataid: number) {
      await axios.get(variable()['api_main'] + "booking_addons/remove/" + dataid).then(async () => {
        await this.fetchProfile();
      });
    },
    toCurrencyFormat(amount: number) {
      if(isNaN(amount)) return toCurrency(0);
      return toCurrency(amount);
    }
  },
  async mounted() {
    await this.fetchProfile();
  },
});
</script>

<style scoped>
.main-reservation-card {
  box-shadow: 0 4px 15px rgba(230, 57, 70, 0.45) !important;
  border: none;
  border-radius: 12px;
  transition: all 0.3s ease; /* smooth animation */
}

/* 🌟 Hover effect: lift & stronger shadow */
.main-reservation-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 25px rgba(230, 57, 70, 0.55) !important;
}

.grand-total {
  font-weight: 700;
  font-size: 1.2rem;
  color: #333;
}
</style>
