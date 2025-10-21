<template>
  <div class="card">
    <h5 class="card-header">View Add-ons</h5>
    <img :src="addon.photo ? 'https://api-fileserver.jlipreso.com/' + addon.photo : 'https://www.menuprice.app/assets/img/nn.png' " />
    <div class="card-body">
      <div class="form-group">
        <label>Add-ons Name</label>
        <input v-model="addon.name" type="text" class="form-control form-control-lg bg-white" readonly >
      </div>
      <div class="form-group mt-2">
        <label>Description</label>
        <textarea v-model="addon.description" class="form-control form-control-lg bg-white" style="min-height: 140px;" readonly></textarea>
      </div>
      <div class="row">
        <div class="col-sm-12 col-md-6">
          <div class="form-group mt-2">
            <label>Price</label>
            <input v-model="addon.price" type="text" class="form-control form-control-lg bg-white" readonly>
          </div>
        </div>
        <div class="col-sm-12 col-md-6">
          <div class="form-group mt-2">
            <label>Sale Price</label>
            <input v-model="addon.priceSale" type="text" class="form-control form-control-lg bg-white" readonly>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

	import { defineComponent } from 'vue';

  export default defineComponent({
    props: {
      addon: {
        default: {} as any,
        type: Object
      }
    }
  });

</script>