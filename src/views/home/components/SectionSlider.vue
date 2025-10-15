<template>
  <div class="banner position-relative">
    <div class="d-block p-5" style="height: calc(100vh - 90px);">
      <div class="center-me pt-5" style="position: absolute;bottom: 120px;">
        <h4 class="text-uppercase text-white text-center" data-aos="fade-right" data-aos-easing="ease-in-out">RESERVE NOW</h4>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { Navigation, Pagination } from 'swiper/modules';
  import { Swiper, SwiperSlide } from 'swiper/vue';

  export default defineComponent({
    name: "SectionSlider",
    components: { Swiper, SwiperSlide },
    setup() {
      return {
        modules: [Navigation, Pagination],
      }
    },
    data() {
      return {
        swiper: {} as any,
      }
    },
    methods: {
      onSwiper(event: any) {
        this.swiper = event;
      }
    }
  });

</script>
<style scoped>
  .banner.position-relative {
    background-image: url('/src/assets/image/banner-logo.jfif');
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
  }
  .center-me {
    position: absolute;
    left: 50%;
    transform: translate(-50%);
  }
</style>