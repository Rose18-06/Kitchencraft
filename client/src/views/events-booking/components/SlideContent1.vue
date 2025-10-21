<template>
  <div>
    <div class="card shadow-card p-4 mb-4">
      <h1 class="mb-3">Theme and Packs</h1>
      <p>Select your preferred theme and number of packs to continue</p>

      <!-- Event and Location -->
      <div class="mb-3">
        <div class="row">
          <div class="col-6">
            <label class="form-label me-2">Event</label>
            <input
              type="text"
              :value="event?.name || ''"
              class="form-control form-control-lg"
              readonly
            />
          </div>
          <div class="col-6">
            <label class="form-label me-2">Event Location <sup class="text-danger">*</sup></label>
            <select
              class="form-control form-control-lg"
              v-model="form.event_location_dataid"
              @change="onChangeLocation"
            >
              <option value="0">Select location</option>
              <option
                v-for="loc in locations"
                :key="loc.dataid"
                :value="loc.dataid"
              >
                {{ loc.location }}
              </option>
            </select>
          </div>
        </div>
      </div>

      <!-- Per Pax -->
      <div class="mb-3">
        <label class="form-label">Per Pax</label>
        <input
          type="text"
          :value="`PHP ${form.event_pax_price}`"
          class="form-control form-control-lg"
          readonly
        />
      </div>

      <!-- Theme Selection -->
      <div class="mb-3">
        <div class="d-flex justify-content-between align-items-center">
          <label class="form-label">Select Theme <sup class="text-danger">*</sup></label>
          <button class="btn btn-secondary btn-sm" @click="fetchAllThemes">
            <i class="bi bi-arrow-clockwise"></i> Reload
          </button>
        </div>
        <select v-model="form.event_theme_dataid" class="form-control form-control-lg">
          <option value="0">Select theme</option>
          <option
            v-for="theme in themes"
            :key="theme.dataid"
            :value="theme.dataid"
          >
            {{ theme.name }}
          </option>
        </select>
      </div>

      <!-- Number of Pax and Total Cost -->
      <div class="row">
        <div class="col-6">
          <div class="mb-3">
            <label class="form-label">Number of Pax (Min. 20) <sup class="text-danger">*</sup></label>
            <input
              type="number"
              v-model.number="form.event_pax"
              class="form-control form-control-lg"
              @input="onPaxChanged"
            />
          </div>
        </div>
        <div class="col-6">
          <div class="mb-3">
            <label class="form-label">Total Cost</label>
            <input
              type="text"
              :value="toCurrencyFormat(form.event_cost)"
              class="form-control form-control-lg"
              readonly
            />
          </div>
        </div>
      </div>

      <!-- Location Details -->
      <div class="alert alert-warning mt-3" v-if="location">
        <p class="m-0"><small><strong>Venue:</strong> {{ location.venue }}</small></p>
        <p class="m-0"><small><strong>Inclusions:</strong> {{ location.inclusions }}</small></p>
        <p class="m-0"><small><strong>Remarks:</strong> {{ location.remarks }}</small></p>
      </div>

      <!-- Next Button -->
      <div class="d-flex justify-content-end mt-3">
        <button class="btn btn-next" @click="nextSlide">Next</button>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import axios from "axios";
import $ from "jquery";
import Swal from "sweetalert2";
import { variable } from "@/var";
import { getLocalUser } from "@/assets/ts/localStorage";
import { toCurrency } from "@/assets/ts/formatter";

export default defineComponent({
  name: "SlideContent1",
  emits: ["next"],
  props: {
    event: {
      type: Object,
      default: () => ({}),
    },
  },
  data() {
    return {
      themes: [] as any[],
      locations: [
        { dataid: 1, location: "Can-asujan, City of Carcar Cebu", price: 500, applied_fee: 50, venue: "Topsai Hall", inclusions: "Tables, Chairs, Lights", remarks: "Surrounded by nature’s charm, this hall offers a refreshing and calming setting for meaningful gatherings." },
        { dataid: 2, location: "Upper, San fernando Cebu", price: 600, applied_fee: 60, venue: "Blueridges Mountain Resort", inclusions: "Tables, Chairs, Lights, Sound System", remarks: "Perched on a hilltop, this resort treats you to a stunning mountain view while you celebrate life’s special moments." },
        { dataid: 3, location: "Inayagan, City of Naga Cebu", price: 700, applied_fee: 70, venue: "Jv Resort", inclusions: "Tables, Chairs, Lights, Sound System", remarks: "A fun and inviting resort that blends relaxation and celebration, perfect for family events and joyful occasions." }
      ],
      location: {} as any,
      form: {
        user_dataid: "",
        event_theme_dataid: 0,
        event_location_dataid: 0,
        event_location: "",
        event_pax: 0,
        event_cost: 0,
        event_pax_price: 0,
        event_applied_fee: 0,
      },
    };
  },
  methods: {
    async nextSlide() {
      try {
        const response = await axios.get(
          variable()["api_main"] + "booking/themeAndPacks?" + $.param(this.form)
        );
        if (response.data?.success) {
          this.$emit("next", { data: { index: 1 } });
        } else {
          Swal.fire("Warning", response.data?.message, "warning");
        }
      } catch (err) {
        console.error(err);
      }
    },
    async fetchAllThemes() {
      const response = await axios.get(variable()["api_main"] + "themes/fetchAll");
      this.themes = Array.isArray(response.data) ? response.data : Object.values(response.data);
    },
    onChangeLocation(event: any) {
      const dataid = event.target.value;
      const choice = this.locations.find((l: any) => l.dataid == dataid);
      if (choice) {
        this.location = choice;
        this.form.event_location = choice.location;
        this.form.event_location_dataid = choice.dataid;
        this.form.event_pax_price = choice.price;
        this.form.event_applied_fee = choice.applied_fee;
        this.form.event_cost = this.form.event_pax_price * this.form.event_pax;
      }
    },
    onPaxChanged() {
      this.form.event_cost = this.form.event_pax_price * this.form.event_pax;
    },
    toCurrencyFormat(amount: number) {
      return toCurrency(amount);
    },
  },
  async mounted() {
    await this.fetchAllThemes();
    const user = await getLocalUser();
    if (user) this.form.user_dataid = user.dataid;
  },
});
</script>

<style scoped>
.shadow-card {
  box-shadow: 0 8px 20px rgba(230, 57, 70, 0.25) !important;
  border-radius: 10px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.shadow-card:hover {
  box-shadow: 0 12px 25px rgba(230, 57, 70, 0.35) !important;
  transform: translateY(-5px);
}
.form-control {
  border-width: 1.5px;
  border-color: #ced4da;
}
.form-control:focus {
  box-shadow: 0 0 0 0.10rem rgba(230, 57, 70, 0.5);
  border-color: #e63946;
  outline: none;
}
.btn-next {
  background-color: #e63946;
  border-color: #e63946;
  color: #fff;
  width: 150px;
  transition: 0.2s;
  box-shadow: 0 2px 8px rgba(230, 57, 70, 0.4);
}
.btn-next:hover {
  background-color: #d42e3f;
  border-color: #d42e3f;
  box-shadow: 0 4px 12px rgba(230, 57, 70, 0.5);
  transform: translateY(-1px);
}
.alert-warning {
  box-shadow: 0 2px 8px rgba(255, 193, 7, 0.2);
  border: none;
}
</style>
