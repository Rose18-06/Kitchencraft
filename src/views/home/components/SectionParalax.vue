<template>
  <div class="paralax-home p-5">
    <div class="container">
      <div class="row">
        <div class="col-sm-12 col-md-6" data-aos="zoom-in-down">
          <h1 class="text-center" style="margin-top: 130px;">Kitchencraft</h1>
          <p class="text-center text-white">Secure your spot today and let us help you create the perfect event! Book now to lock in your date and ensure every detail is handled with care and precision. Don’t miss the chance to make your celebration truly unforgettable!</p>
        </div>
        <div class="col-sm-12 col-md-6" data-aos="zoom-in-left">
          <img style="width: 350px;height: 350px;" src="/src/assets/image/kitchencraft-logo.png" />
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';

  export default defineComponent({
    name: "SectionParalax",
    components: { }
  });

</script>
<style scoped>
  .paralax-home {
    background: url('/src/assets/image/welcome.jpg');
    background-repeat: no-repeat;
    background-attachment: fixed;
  }
  .paralax-home img {
    margin-top: 130px;
    width: 300px;
    height: 300px;
    border-radius: 50%;
    border: 5px solid white;
  }
  .paralax-home h1 {
    color: #fff;
    font-weight: 800;
    text-transform: uppercase;
    padding: 0 0 90px 0;
    margin: -6px 0 0 0;
    background: url("/src/assets/image/heading-light.png") no-repeat center 90px;
  }
  .paralax-home p {
    font-size: 20px;
  }
</style>