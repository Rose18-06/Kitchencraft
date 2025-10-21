<template>
  <div class="card">
    <h5 class="card-header">View Theme</h5>
    <div class="card-body">
      <div class="form-group mt-4">
        <label>Category name</label>
        <input v-model="form.name" type="text" class="form-control form-control-lg bg-white" readonly>
      </div>
      <div class="form-group mt-4">
        <label>Description</label>
        <textarea v-model="form.description" class="form-control form-control-lg bg-white" readonly></textarea>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

	import { defineComponent } from 'vue';

	export default defineComponent({
    props: {
      form: {
        default: {},
        type: Object
      }
    }
  });

</script>