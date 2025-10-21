<template>
  <div class="m-2">
    <div class="card">
      <div class="card-body">
        <h6 class="text-center">{{ label }}</h6>
        <h3 class="text-center">{{ value }}</h3>
      </div>
    </div>
  </div>
</template>

<script lang="ts">

  import { defineComponent } from 'vue';

  export default defineComponent({
    props: {
      label: {
        default: "Untitled",
        type: String
      },
      value: {
        default: "0",
        type: String
      }
    }
  });
</script>