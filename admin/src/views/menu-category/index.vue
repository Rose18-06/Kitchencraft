<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="d-flex justify-content-between align-items-center py-3">
              <h4 class="fw-bold py-3">Manage Menu</h4>
              <div class="d-flex">
                <button class="btn btn-primary" @click="swipeToAdd()">Add Menu</button>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-5">
                <swiper :slides-per-view="1" :space-between="50" @swiper="onSwiper">
                  <swiper-slide class="swiper-no-swiping"><CardMenuCategoryView :form="form" /></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><CardMenuCategoryAdd @refresh="fetchAllCategory()" /></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><CardMenuCategoryUpdate :form="form" @refresh="fetchAllCategory()" /></swiper-slide>
                </swiper>
              </div>
              <div class="col-sm-12 col-md-7">
                <TableMenus :categories="categories" @view="swipeToView" @update="swipeToUpdate" @refresh="fetchAllCategory()" />
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
  import TableMenus from "./components/TableMenusCategory.vue";
  import CardMenuCategoryView from './components/CardMenuCategoryView.vue';
  import CardMenuCategoryAdd from "./components/CardMenuCategoryAdd.vue";
  import CardMenuCategoryUpdate from './components/CardMenuCategoryUpdate.vue';
  import axios from 'axios';

  export default defineComponent({
    components: { CardMenuCategoryView, Swiper, SwiperSlide, CardMenuCategoryUpdate, CardMenuCategoryAdd, TableMenus, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        swiper: {} as any,
        categories: {} as any,
        form: {} as any
      }
    },
    methods: {
      onSwiper(event: any) {
        this.swiper = event;
      },
      swipeToView(event: any) {
        this.form = event?.category;
        this.swiper.slideTo(0);
      },
      swipeToUpdate(event: any) {
        this.form = event?.category;
        this.swiper.slideTo(2);
      },
      swipeToAdd() {
        this.swiper.slideTo(1);
      },
      async fetchAllCategory() {
        await axios.get( variable()['api_main'] + "menu_categories/fetchAll" ).then( async (response) => {
          this.categories = response.data;
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchAllCategory().then( async () => {
            console.log("Menu Category:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>