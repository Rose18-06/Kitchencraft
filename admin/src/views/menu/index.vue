<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="d-flex justify-content-between align-items-center py-0">
              <h4 class="fw-bold py-3">Manage Menu</h4>
              <div class="d-flex">
                <button class="btn btn-primary" @click="swipeToAdd()">Add Menu</button>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-5">
                <swiper :slides-per-view="1" :space-between="50" @swiper="onSwiper">
                  <swiper-slide class="swiper-no-swiping"><CardMenuView :menu="menu_form" /></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><CardMenuAdd @refresh="fetchMenus()" /></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><CardMenuUpdate :menu="menu_form" @refresh="fetchMenus()"/></swiper-slide>
                </swiper>
              </div>
              <div class="col-sm-12 col-md-7">
                <TableMenus :menus="menus" @view="swipeToView" @update="swipeToUpdate" @refresh="fetchMenus()" />
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
  import TableMenus from "./components/TableMenus.vue";
  import CardMenuView from './components/CardMenuView.vue';
  import CardMenuAdd from "./components/CardMenuAdd.vue";
  import CardMenuUpdate from './components/CardMenuUpdate.vue';
  import axios from 'axios';
  

  export default defineComponent({
    components: { CardMenuView, Swiper, SwiperSlide, CardMenuUpdate, CardMenuAdd, TableMenus, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        swiper: {} as any,
        menus: {} as any,
        menu_form: {} as any
      }
    },
    methods: {
      onSwiper(event: any) {
        this.swiper = event;
      },
      swipeToView(event: any) {
        this.menu_form = event; 
        this.swiper.slideTo(0);
      },
      swipeToUpdate(event: any) {
        this.menu_form = event; 
        this.swiper.slideTo(2);
      },
      swipeToAdd() {
        this.swiper.slideTo(1);
      },
      async fetchMenus() {
        await axios.get( variable()['api_main'] + "menu/fetchAll" ).then( async (response) => {
          this.menus = response.data;
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchMenus();
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>