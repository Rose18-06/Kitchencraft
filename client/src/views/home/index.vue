<template>
  <div>
    <SectionHeader/>
    <main class="main">
      <SectionSlider/>

      <div class="content">
        <div class="container">
          <!-- Welcome Section -->
          <div
            class="py-5"
            data-aos="fade-right"
            data-aos-duration="800"
            data-aos-easing="ease-in-out"
          >
            <h1 class="text-center">Welcome to</h1>
            <h1 class="text-center">Kitchencraft Catering</h1>
          </div>

          <!-- Featured Section (static example) -->
          <div class="row mb-5">
            <SectionFeatured />
          </div>

          <!-- Discounted Add-ons Section -->
          <div
            class="py-5"
            data-aos="fade-right"
            data-aos-duration="800"
            data-aos-easing="ease-in-out"
          >
            <h1 class="text-center text-danger">Discounted Add-ons</h1>
            <p class="text-center">
              Enjoy our limited discounted offers for add-ons
            </p>
          </div>
          <div class="row">
            <SectionDiscountedAddOns />
          </div>
        </div>
      </div>

      <SectionParalax/>
      <SectionFooter/>
    </main>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import SectionHeader from "@/components/SectionHeader.vue";
import SectionSlider from "./components/SectionSlider.vue";
import SectionFeatured from "./components/SectionFeatured.vue";
import SectionDiscountedAddOns from "./components/SectionDiscountedAddOns.vue";
import SectionParalax from "./components/SectionParalax.vue";
import SectionFooter from "@/components/SectionFooter.vue";
import Aos from "aos";

export default defineComponent({
  name: "HomePage",
  components: {
    SectionFooter,
    SectionHeader,
    SectionSlider,
    SectionFeatured,
    SectionDiscountedAddOns,
    SectionParalax,
  },
  mounted() {
    Aos.init();
  },
});
</script>
