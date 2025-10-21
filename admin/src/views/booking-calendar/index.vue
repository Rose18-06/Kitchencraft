<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Booking /</span> Calendar</h4>
            <div class="card">
              <div class="card-body">
                <FullCalendar :options="calendarOptions" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <ModalBookingView :open="modal.view.open" :booking="modal.view.booking" @closed="()=>{ modal.view.open = false; }" @refresh="fetchBookingDates()" />
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import ModalBookingView from "@/components/ModalBookingView.vue";
  import FullCalendar from '@fullcalendar/vue3'
  import dayGridPlugin from '@fullcalendar/daygrid'
  import interactionPlugin from '@fullcalendar/interaction'
  import axios from 'axios';
  import { variable } from '@/var';

  /**
   * https://fullcalendar.io/docs/eventClick
   * https://fullcalendar.io/docs/event-object
   */

  export default defineComponent({
    components: { ModalBookingView, SectionSidebar, SectionHeader, FullCalendar  },
    data() {
      return {
        admin: {} as any,
        calendarOptions: {
          plugins: [ dayGridPlugin, interactionPlugin ],
          initialView: 'dayGridMonth',
          events: [],
          eventClick: this.eventDateClicked as any
        },
        modal: {
          view: {
            open: false,
            booking: {} as any
          }
        }
      }
    },
    methods: {
      async eventDateClicked(info: any) {
        console.log("Dataid:", info?.event?.id);
        await axios.get( variable()['api_main'] + "booking/fetchByDataID/" + info?.event?.id ).then( async (response) => {
          this.modal.view.booking = response.data;
          this.modal.view.open    = true;

          console.log(response.data);
        });
      },
      async fetchBookingDates() {
        await axios.get( variable()['api_main'] + "booking/calendar" ).then( async (response) => {
          this.calendarOptions.events = response.data;
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchBookingDates().then( async () => {
            console.log('Calendar:', toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
    
  });

</script>