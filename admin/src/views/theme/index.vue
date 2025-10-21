<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="d-flex justify-content-between align-items-center py-3">
              <h4 class="fw-bold py-3">Manage Theme</h4>
              <div class="d-flex">
                <button class="btn btn-primary" @click="swipeToAdd()">Add Theme</button>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-5">
                <swiper :slides-per-view="1" :space-between="50" @swiper="onSwiper">
                  <swiper-slide class="swiper-no-swiping"><CardEventView :theme="view.theme" /></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><CardEventAdd @refresh="fetchThemes()" /></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><CardEventUpdate @refresh="fetchThemes()" :theme="update.theme" /></swiper-slide>
                </swiper>
              </div>
              <div class="col-sm-12 col-md-7">
                <TableEvents :themes="themes" @view="swipeToView" @refresh="fetchThemes()" @update="swipeToUpdate" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { Swiper, SwiperSlide } from 'swiper/vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import TableEvents from "./components/TableEvents.vue";
  import CardEventView from './components/CardEventView.vue';
  import CardEventAdd from "./components/CardEventAdd.vue";
  import CardEventUpdate from './components/CardEventUpdate.vue';
  import axios from 'axios';
  import { variable } from '@/var';

  export default defineComponent({
    components: { CardEventView, Swiper, SwiperSlide, CardEventUpdate, CardEventAdd, TableEvents, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        swiper: {} as any,
        themes: {} as any,
        view: {
          theme: {} as any
        },
        update: {
          theme: {} as any
        }
      }
    },
    methods: {
      onSwiper(event: any) {
        this.swiper = event;
      },
      swipeToView(event: any) {
        console.log(toRaw(event));
        this.view.theme = event.data;
        this.swiper.slideTo(0);
      },
      swipeToUpdate(event: any) {
        this.update.theme = event.data;
        this.swiper.slideTo(2);
      },
      swipeToAdd() {
        this.swiper.slideTo(1);
      },
      async fetchThemes() {
        await axios.get( variable()['api_main'] + "themes/fetchAll" ).then( async (response) => {
          this.themes = response.data;
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchThemes().then( async () => {
            console.log("Theme:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>