<template>
  <div>
    <SectionHeader/>
    <main class="main">
      <div class="content">
        <SectionBanner title="Booking" description="Come for the Food, stay for the memories"/>
        <div class="container py-5">
          <div class="row">
            <div class="col-sm-12 col-lg-6" v-for="(event, ei) in events" :key="ei">
              <CardEvent :event="event" @openModal="openModalAvailChecker"/>
            </div>
          </div>
        </div>
      </div>
      <SectionFooter/>
    </main>
    <ModalEventAvailability :event="modal.checkAvailabilityEvent" :open="modal.checkAvailability" @closed="()=>{ modal.checkAvailability = false; }" />
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from "@/assets/ts/localStorage.ts";
  import SectionHeader from "@/components/SectionHeader.vue";
  import SectionFooter from "@/components/SectionFooter.vue";
  import SectionBanner from "@/components/SectionBanner.vue";
  import CardEvent from "./components/CardEvent.vue";
  import ModalEventAvailability from "./components/ModalEventAvailability.vue";
  import axios from 'axios';
  import { variable } from '@/var';
  import Swal from 'sweetalert2';

  export default defineComponent({
    name: "EventsPage",
    data() {
      return {
        user: {} as any,
        events: [] as any,
        draft: {} as any,
        modal: {
          checkAvailability: false,
          checkAvailabilityEvent: {} as Object
        }
      }
    },
    components: { ModalEventAvailability, CardEvent, SectionBanner, SectionFooter, SectionHeader },
    methods: {
      async fetchAll() {
        await axios.get( variable()['api_main'] + "events/fetchAll" ).then( async (response) => {
          this.events = response.data;
        });
      },
      async openModalAvailChecker(data: any) {
        this.modal.checkAvailability = true;
        this.modal.checkAvailabilityEvent = data?.data;
      },
      async fetchDraft() {
        await axios.get( variable()['api_main'] + "booking/getDraft/" + this.user?.dataid ).then( async (response) => {
          this.draft = response.data;
          if(response.data?.success) {
            localStorage.setItem('booking-dataid', response.data?.data?.header?.dataid);
            localStorage.setItem('booking-event', JSON.stringify(response.data?.data?.event));
            this.$router.push('/events-booking');
          }
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (user) => {
        if(user) {
          this.user = user;
          await this.fetchAll().then( async () => {
            await this.fetchDraft().then( async () => {
              console.log("Data:", toRaw(this.$data));
            });
          });
        }
        else {
          await this.fetchAll().then( async () => {
            console.log("Data:", toRaw(this.$data));
          });
        }
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