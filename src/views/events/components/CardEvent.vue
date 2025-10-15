<template>
  <div class="card event-card border-0 m-4">
    <img 
      class="w-100" 
      :src="eventImage"
      alt="Event Image"
    />
    <div class="card-body p-4 mt-4">
      <div class="d-flex justify-content-between align-items-center pb-4">
        <h1>{{ event?.name }}</h1>
        <button class="btn btn-select" @click="openModal(event)">Select Event</button>
      </div>

      <!-- Direct hardcoded description for Baptism -->
      <p v-if="event?.name?.trim().toLowerCase() === 'baptism'">
        A baptism is a sacred Christian ceremony where a child or adult is welcomed into the faith. The event usually includes prayers, blessings, and a small celebration with family and friends.
      </p>

      <!-- API description for other events -->
      <p v-else>
        {{ event?.description }}
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
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import myEventImage from '@/assets/image/homelogo.jfif'; // replace with your local file

export default defineComponent({
  name: "CardEvent",
  emits: ['openModal'],
  props: {
    event: {
      default: {} as any,
      type: Object
    }
  },
  setup(props, { emit }) {
    const openModal = (event: Object) => {
      emit('openModal', { data: event });
    };

    const eventImage = myEventImage;

    return { openModal, eventImage };
  }
});
</script>

<style scoped>
.event-card {
  box-shadow: 0 4px 12px rgba(230, 57, 70, 0.45);
  border-radius: 0.5rem;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.event-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 16px rgba(230, 57, 70, 0.55);
}

.btn-select {
  background-color: #e63946;
  border-color: #e63946;
  color: #fff;
  transition: background-color 0.2s ease, border-color 0.2s ease;
}

.btn-select:hover {
  background-color: #d42e3f;
  border-color: #d42e3f;
}

/* Removed custom color, all descriptions will now use default text color */
</style>
