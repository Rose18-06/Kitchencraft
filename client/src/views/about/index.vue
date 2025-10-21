<template>
  <div>
    <SectionHeader />
    <main class="main">
      <div class="content">
        <SectionBanner title="About Us" />
        <div class="container">
          <div class="row py-5">
            <!-- Left: All text + services inside a single card -->
            <div class="col-sm-12 col-md-6">
              <div class="card shadow-card p-4">
                <h1 class="mb-4">ENJOY our Offer Services</h1>

                <!-- Who we are -->
                <div class="mb-4">
                  <h3>Who we are</h3>
                  <p>
                    Kitchencraft Catering is a food business selling Classic Filipino dishes coming
                    from the owners’ secret recipes. It is located at Inayagan City of Naga Cebu,
                    Philippines. Kitchencraft Catering is owned by Rose Ann V. Padin with her
                    business partner Richard S. Labanda. It was established on January 01, 2025,
                    and they started with 9 staff members in their management, and the current
                    staff is 8.
                  </p>
                </div>

                <!-- What we do -->
                <div class="mb-4">
                  <h3>What we do</h3>
                  <p>
                    We specialize in planning and executing events of all sizes, offering services
                    such as venue setup with comfortable tables and chairs, fully air-conditioned
                    spaces, and elegant décor. From start to finish, we handle every detail so you
                    can relax and enjoy your special moments.
                  </p>
                </div>

                <!-- Service Inclusion -->
                <h3 class="text-center mb-3">Service Inclusion</h3>

                <!-- First row of service cards -->
                <div class="d-flex justify-content-center mb-3">
                  <div class="card shadow-card p-3 mx-2 text-center">
                    <img src="/src/assets/image/icon-cup.png" />
                    <h5 class="mt-2">Breakfast</h5>
                  </div>
                  <div class="card shadow-card p-3 mx-2 text-center">
                    <img src="/src/assets/image/icon-ac.png" />
                    <h5 class="mt-2">Air Conditioning</h5>
                  </div>
                  <div class="card shadow-card p-3 mx-2 text-center">
                    <img src="/src/assets/image/icon-led.png" />
                    <h5 class="mt-2">TV LCD</h5>
                  </div>
                </div>

                <!-- Second row of service cards -->
                <div class="d-flex justify-content-center">
                  <div class="card shadow-card p-3 mx-2 text-center">
                    <img src="/src/assets/image/icon-wifi.png" />
                    <h5 class="mt-2">Wi-fi</h5>
                  </div>
                  <div class="card shadow-card p-3 mx-2 text-center">
                    <img src="/src/assets/image/icon-car.png" />
                    <h5 class="mt-2">Free Parking</h5>
                  </div>
                </div>
              </div>
            </div>

            <!-- Right: Image inside a card -->
            <div class="col-sm-12 col-md-6">
              <div class="card shadow-card">
                <div class="card-body p-0">
                  <swiper
                    :modules="modules"
                    navigation
                    :pagination="{ clickable: true }"
                    :slides-per-view="1"
                    :space-between="0"
                    @swiper="onSwiper"
                  >
                    <swiper-slide>
                      <img
                        class="about-image"
                        src="/src/assets/image/about-image-2.png"
                      />
                    </swiper-slide>
                  </swiper>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <SectionFooter />
    </main>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import SectionHeader from "@/components/SectionHeader.vue";
import SectionFooter from "@/components/SectionFooter.vue";
import SectionBanner from "@/components/SectionBanner.vue";
import { Swiper, SwiperSlide } from "swiper/vue";
import { Navigation, Pagination } from "swiper/modules";

export default defineComponent({
  name: "AboutPage",
  components: {
    SectionBanner,
    SectionFooter,
    SectionHeader,
    Swiper,
    SwiperSlide,
  },
  setup() {
    return {
      modules: [Navigation, Pagination],
    };
  },
  data() {
    return {
      swiper: {} as any,
    };
  },
  methods: {
    onSwiper(event: any) {
      this.swiper = event;
    },
  },
});
</script>

<style scoped>
.about-image {
  width: 100%;
  height: 750px;
  object-fit: cover;
  border-radius: 0.5rem;
}

/* 🔴 Custom red box shadow for all cards */
.shadow-card {
  box-shadow: 0 8px 20px rgba(230, 57, 70, 0.45) !important;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.shadow-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 25px rgba(230, 57, 70, 0.55) !important;
}
</style>
