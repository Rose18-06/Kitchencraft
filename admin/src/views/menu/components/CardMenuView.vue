<template>
  <div class="card">
    <h5 class="card-header">View Menu</h5>
    <img class="w-100" :src="menu?.photo ? 'https://api-fileserver.jlipreso.com/' + menu?.photo : 'https://www.menuprice.app/assets/img/nn.png' " />
    <div class="card-body">
      <div class="form-group mt-4">
        <label>Menu name</label>
        <input v-model="menu.name" type="text" class="form-control form-control-lg bg-white" readonly>
      </div>
      <div class="form-group mt-4">
        <label>Description</label>
        <textarea v-model="menu.description" class="form-control form-control-lg bg-white" style="min-height: 150px;" readonly></textarea>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';

  export default defineComponent({
    props: {
      menu: {
        default: {},
        type: Object
      }
    }
  });

</script>