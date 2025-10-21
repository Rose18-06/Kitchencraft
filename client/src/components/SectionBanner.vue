<template>
  <div class="page-title dark-background">
    <div class="container position-relative">
      <h1>{{ title }}</h1>
      <p>{{ description }}</p>
      <nav class="breadcrumbs">
        <ol>
          <li><a href="index.html">Home</a></li>
          <li class="current">{{ title }}</li>
        </ol>
      </nav>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';

  export default defineComponent({
    name: "SectionBanner",
    props: {
      title: {
        default: 'Untitled Page',
        type: String
      },
      description: {
        default: '',
        type: String
      }
    },
  });

</script>
<style>
  .page-title {
    background-image: url('/src/assets/image/sub-banner-hotel.jpg');
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
  }
</style>