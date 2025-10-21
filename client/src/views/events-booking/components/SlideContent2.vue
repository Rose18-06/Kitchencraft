<template>
  <div>
    <!-- ✅ Main wrapper card with border and shadow -->
    <div class="card border p-4 mb-4 main-card-shadow">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <h1 class="p-0 m-0">Add Food</h1>
        </div>
        <div>
          <select class="form-control" @change="onChangeCategory">
            <option v-for="(category, ci) in menus" :key="ci" :value="ci">
              {{ category?.header?.name }}
            </option>
          </select>
        </div>
      </div>

      <div class="py-4">
        <swiper
          :modules="modules"
          :slides-per-view="1"
          :space-between="5"
          navigation
          @swiper="onSwiper"
        >
          <swiper-slide v-for="(menu, mi) in menus" :key="mi">
            <p class="p-0 m-0">Please select 1 from {{ menu?.header?.name }}</p>
            <div class="row">
              <div v-for="(child, ci) in menu?.child" class="col-sm-6 col-md-6">
                <div class="card my-3">
                  <img
                    :src="
                      child?.photo
                        ? 'https://api-fileserver.jlipreso.com/' + child?.photo
                        : 'https://static.vecteezy.com/system/resources/previews/036/804/331/non_2x/ai-generated-assorted-indian-food-on-dark-wooden-background-free-photo.jpg'
                    "
                  />
                  <div class="card-body">
                    <h5 class="text-center text-primary">{{ child?.name }}</h5>
                    <p style="height: 80px; overflow: hidden">
                      {{ child?.description }}
                    </p>
                  </div>
                  <div class="card-footer">
                    <button
                      class="btn btn-clear-primary w-100"
                      @click="addToCart(child)"
                    >
                      Add to Cart
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </swiper-slide>
        </swiper>
      </div>
    </div>

    <!-- ✅ Buttons stay outside the card -->
    <div class="d-flex justify-content-end">
      <button
        class="btn btn-outline-secondary btn-lg me-4"
        style="width: 200px"
        @click="backSlide()"
      >
        Back
      </button>
      <button
        class="btn next-btn btn-lg"
        style="width: 200px"
        @click="nextSlide()"
      >
        Next
      </button>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { Navigation, Pagination } from "swiper/modules";
import { Swiper, SwiperSlide } from "swiper/vue";
import { variable } from "@/var";
import { getBookingDataID } from "@/assets/ts/localStorage";
import axios from "axios";
import Swal from "sweetalert2";
import $ from "jquery";

export default defineComponent({
  name: "SlideContent2",
  components: { Swiper, SwiperSlide },
  emits: ["next", "back", "refresh"],
  setup() {
    return {
      modules: [Navigation, Pagination],
    };
  },
  data() {
    return {
      swiper: {} as any,
      menus: [] as any,
      validate: {
        dish: 5,
        dessert: 1,
      },
      categories: {} as any,
    };
  },
  methods: {
    onSwiper(event: any) {
      this.swiper = event;
    },
    async nextSlide() {
      await getBookingDataID().then(async (booking_dataid) => {
        var args = {
          booking_dataid: booking_dataid,
          target_dish: this.validate.dish,
          target_dessert: this.validate.dessert,
        };
        await axios
          .get(variable()["api_main"] + "booking_foods/verify?" + $.param(args))
          .then(async (response) => {
            if (response.data?.success) {
              this.$emit("next", { data: { index: 2 } });
            } else {
              Swal.fire({
                title: "Warning",
                text: response.data?.message,
                icon: "warning",
              });
            }
          });
      });
    },
    backSlide() {
      this.$emit("back", { data: { index: 0 } });
    },
    async fetchAllMenu() {
      await axios
        .get(variable()["api_main"] + "menu/fetchAllByCategory")
        .then(async (response) => {
          this.menus = response.data;
        });
    },
    async fetchAllMenuCategory() {
      await axios
        .get(variable()["api_main"] + "menu_categories/fetchAll")
        .then(async (response) => {
          this.categories = response.data;
        });
    },
    async onChangeCategory(event: any) {
      this.swiper.slideTo(event?.target?.value);
    },
    async addToCart(menu: any) {
      await getBookingDataID().then(async (dataid) => {
        await axios
          .get(
            variable()["api_main"] +
              "booking_foods/add?booking_dataid=" +
              dataid +
              "&menu_dataid=" +
              menu?.dataid +
              "&menu_category=" +
              menu?.category
          )
          .then(async (response) => {
            if (response.data?.success) {
              Swal.fire({
                title: "Added",
                icon: "success",
              }).then(async () => {
                this.$emit("refresh");
              });
            } else {
              Swal.fire({
                title: "Warning",
                text: response.data?.message,
                icon: "warning",
              });
            }
          });
      });
    },
  },
  async mounted() {
    await this.fetchAllMenu().then(async () => {
      await this.fetchAllMenuCategory();
    });
  },
});
</script>

<style scoped>
img {
  display: block;
  margin: auto;
  width: auto;
  height: 120px;
  object-fit: cover;
  object-position: center;
}

/* Main card with box shadow */
.main-card-shadow {
  box-shadow: 0 4px 15px rgba(230, 57, 70, 0.45);
  border: none;
  transition: all 0.3s ease;
  border-radius: 10px;
  background-color: #fff;
}

/* Hover effect for the main card */
.main-card-shadow:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 25px rgba(230, 57, 70, 0.6);
}

/* Red "Next" button styling */
.next-btn {
  background-color: #e63946;
  border-color: #e63946;
  color: #fff;
  transition: all 0.3s ease;
}

.next-btn:hover {
  background-color: #c9202f;
  border-color: #c9202f;
  transform: translateY(-2px);
  box-shadow: 0 0 10px rgba(230, 57, 70, 0.4);
}
</style>
