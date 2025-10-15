<template>
  <div class="d-flex flex-column align-items-center">
    <!-- ✅ Single main card for Addons content -->
    <div class="card main-card p-4 mb-4">
      <!-- ✅ Smaller title -->
      <h2 class="text-center mb-4 addons-title">Add Addons</h2>

      <div class="py-4 swiper-wrapper-container">
        <swiper
          :modules="modules"
          :slides-per-view="1"
          :space-between="5"
          navigation
          @swiper="onSwiper"
        >
          <swiper-slide v-for="(addon, ai) in addons" :key="ai">
            <div class="text-center">
              <img
                :src="addon.photo"
                class="img-fluid rounded mx-auto d-block"
                alt="addon image"
              />

              <div class="mt-4 text-start">
                <div class="d-flex justify-content-between align-items-center mb-4">
                  <div>
                    <h3>{{ addon.name }}</h3>
                    <div v-if="addon.priceSale > 0">
                      <h5 class="p-0 m-0">PHP {{ addon.priceSale }}</h5>
                      <p class="p-0 m-0">
                        Discounted PHP
                        <span style="text-decoration: line-through;">{{ addon.price }}</span>
                      </p>
                    </div>
                    <div v-else>
                      <h5 class="p-0 m-0">PHP {{ addon.price }}</h5>
                    </div>
                  </div>
                  <!-- ✅ Add to Cart button red -->
                  <button
                    class="btn btn-danger btn-lg w-25"
                    @click="addToCart(addon)"
                  >
                    Add to Cart
                  </button>
                </div>
                <p>{{ addon.description }}</p>
              </div>
            </div>
          </swiper-slide>
        </swiper>
      </div>
    </div>

    <!-- ✅ Buttons outside of the card -->
    <div class="d-flex justify-content-end w-100" style="max-width: 920px;">
      <button
        class="btn btn-outline-secondary btn-lg me-4"
        style="width: 200px;"
        @click="backSlide()"
      >
        Back
      </button>
      <!-- ✅ Next button red -->
      <button
        class="btn btn-danger btn-lg"
        style="width: 200px;"
        @click="nextSlide()"
      >
        Next
      </button>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { Navigation, Pagination } from 'swiper/modules';
import { Swiper, SwiperSlide } from 'swiper/vue';
import Swal from 'sweetalert2';

import clownImg from '@/assets/image/clownlogo.jfif';
import karaokeImg from '@/assets/image/karaokelogo.jfif';
import photoImg from '@/assets/image/photologo.jfif';

export default defineComponent({
  name: "SlideContent3",
  components: { Swiper, SwiperSlide },
  emits: ['next', 'back', 'refresh'],
  setup() {
    return { modules: [Navigation, Pagination] };
  },
  data() {
    return {
      swiper: {} as any,
      addons: [
        {
          name: "Clown",
          price: 3500,
          priceSale: 3000,
          description:
            "A clown is an entertainer who performs comedy acts, magic tricks, and games to make people laugh, especially at parties or events. They usually wear colorful costumes, face paint, and wigs to attract attention and create a fun atmosphere.",
          photo: clownImg,
        },
        {
          name: "Karaoke",
          price: 1500,
          priceSale: 1000,
          description:
            "A karaoke is an entertainment activity where people sing along to instrumental versions of popular songs displayed with lyrics on a screen. It is often used during parties, gatherings, and celebrations as a fun group activity.",
          photo: karaokeImg,
        },
        {
          name: "Photographer",
          price: 8000,
          priceSale: 7000,
          description:
            "A photographer is a professional who captures moments and scenes using a camera, either for artistic or commercial purposes. They play a vital role in events by preserving memories through photos and videos.",
          photo: photoImg,
        },
      ],
    };
  },
  methods: {
    onSwiper(event: any) {
      this.swiper = event;
    },
    nextSlide() {
      this.$emit('next', { data: { index: 3 } });
    },
    backSlide() {
      this.$emit('back', { data: { index: 1 } });
    },
    addToCart(addon: any) {
      Swal.fire({
        title: 'Added to Cart!',
        text: `${addon.name} has been added successfully.`,
        icon: 'success',
      });
    },
  },
});
</script>

<style scoped>
.main-card {
  width: 100%;
  max-width: 920px;
  border-radius: 15px;
  border: 1px solid #ddd;
  background: #fff;
}

.swiper-wrapper-container {
  width: 100%;
}

img {
  width: 80%;
  height: 400px;
  object-fit: cover;
  border-radius: 12px;
}

/* ✅ Smaller Addons title */
.addons-title {
  font-size: 1.8rem;
  font-weight: bold;
}

h3 {
  font-weight: bold;
}

h5 {
  font-weight: normal;
}

/* Make Swiper button shadow transparent */
.swiper-button-next,
.swiper-button-prev {
  box-shadow: none !important;
  outline: none !important;
  filter: drop-shadow(0 0 0 transparent) !important;
}

.swiper-button-next:focus,
.swiper-button-prev:focus,
.swiper-button-next:active,
.swiper-button-prev:active,
.swiper-button-next:hover,
.swiper-button-prev:hover {
  box-shadow: none !important;
  outline: none !important;
  filter: drop-shadow(0 0 0 transparent) !important;
}
</style>
