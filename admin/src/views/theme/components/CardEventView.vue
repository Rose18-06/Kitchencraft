<template>
  <div class="card">
    <h5 class="card-header">View Theme</h5>
    <div class="card-body">
      <div class="form-group mt-4">
        <label>Theme name</label>
        <input :value="theme.name" type="text" class="form-control form-control-lg bg-white" readonly/>
      </div>
      <div class="form-group mt-4">
        <label>Description</label>
        <textarea :value="theme.description" class="form-control form-control-lg bg-white" readonly></textarea>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';

  export default defineComponent({
    props: {
      theme: {
        default: {},
        type: Object
      }
    }
  });

</script>