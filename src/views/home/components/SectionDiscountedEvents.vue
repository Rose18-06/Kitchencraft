<template>
  <div class="py-3">
    <div class="row">
      <div class="col-sm-12 col-md-5">
        <h1 class="text-dark">Discounted Events</h1>

      </div>
      <div class="col-sm-12 col-md-7">
        <div class="py-2" v-for="(item, i) in 2" :key="i">
          <div class="card" >
            <img class="w-100" src="/src/assets/img/hero_1.jpg"/>
            <div class="card-body">
              <h3>WEDDING</h3>
              <p>A wedding is a joyful celebration of love, made special with features like tables and chairs for guests, a fully air-conditioned venue for comfort, and existing décor that enhances the ambiance.</p>
              <h5>Discount Price ₱ 2,200</h5>
              <h5>Original Price ₱ 2,500</h5>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';

  export default defineComponent({
    name: "SectionFeatured",
    components: { }
  });

</script>
<style scoped>
  img {
    max-height: 300px;
    object-fit: cover;
    object-position: center;
  }
</style>