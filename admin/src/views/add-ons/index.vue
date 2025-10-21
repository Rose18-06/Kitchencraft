<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="d-flex justify-content-between align-items-center py-0">
              <h4 class="fw-bold py-3">Manage Add-ons</h4>
              <div class="d-flex">
                <button class="btn btn-primary" @click="swipeToAdd()">Add Add-ons</button>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-5">
                <swiper :slides-per-view="1" :space-between="50" @swiper="onSwiper">
                  <swiper-slide class="swiper-no-swiping"><CardAddonsView :addon="addon" /></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><CardAddonsAdd @refresh="fetchAddonsList()" /></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><CardAddonsUpdate :addon="addon" @refresh="fetchAddonsList()" /></swiper-slide>
                </swiper>
              </div>
              <div class="col-sm-12 col-md-7">
                <TableAddons :addons="addons" @view="swipeToView" @update="swipeToUpdate" @refresh="fetchAddonsList()" />
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
  import { variable } from '@/var';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import TableAddons from "./components/TableAddons.vue";
  import CardAddonsView from './components/CardAddonsView.vue';
  import CardAddonsAdd from "./components/CardAddonsAdd.vue";
  import CardAddonsUpdate from './components/CardAddonsUpdate.vue';
  import axios from 'axios';

  export default defineComponent({
    components: { CardAddonsView, Swiper, SwiperSlide, CardAddonsUpdate, CardAddonsAdd, TableAddons, SectionSidebar, SectionHeader },
    data() {
      return {
        swiper: {} as any,
        admin: {} as any,
        addons: {} as any,
        addon: {}  as any
      }
    },
    methods: {
      onSwiper(event: any) {
        this.swiper = event;
      },
      swipeToView(event: any) {
        this.addon = event.add_on;
        this.swiper.slideTo(0);
      },
      swipeToUpdate(event: any) {
        this.addon = event.add_on;
        this.swiper.slideTo(2);
      },
      swipeToAdd() {
        this.swiper.slideTo(1);
      },
      async fetchAddonsList() {
        await axios.get( variable()['api_main'] + "add_ons/fetchAll" ).then( async (response) => {
          this.addons = response.data;
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchAddonsList().then( async () => {
            console.log("Addons:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>