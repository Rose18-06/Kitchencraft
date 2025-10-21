<template>
  <div class="card">
    <h5 class="card-header">Update Add-ons</h5>
    <CardPhotoUploader 
      @uploaded="onUploadSuccess" 
      @fail="onUploadFail"
      btn_upload_text="Replace"
    />
    <div class="card-body">
      <div class="form-group">
        <label>Add-ons Name</label>
        <input v-model="addon.name" type="text" class="form-control form-control-lg">
      </div>
      <div class="form-group mt-2">
        <label>Description</label>
        <textarea v-model="addon.description" class="form-control form-control-lg" style="min-height: 60px;"></textarea>
      </div>
      <div class="row">
        <div class="col-sm-12 col-md-6">
          <div class="form-group mt-2">
            <label>Price</label>
            <input v-model="addon.price" type="text" class="form-control form-control-lg">
          </div>
        </div>
        <div class="col-sm-12 col-md-6">
          <div class="form-group mt-2">
            <label>Sale Price</label>
            <input v-model="addon.priceSale" type="text" class="form-control form-control-lg">
          </div>
        </div>
        <div class="d-flex justify-content-end mt-4">
          <button class="btn btn-primary w-50" @click="updateAddons()" >Update</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

	import { defineComponent } from 'vue';
  import { variable } from '@/var';
  import CardPhotoUploader from "@/components/CardPhotoUploader.vue";
  import axios from 'axios';
  import Swal from 'sweetalert2';
  import $ from 'jquery';

  export default defineComponent({
    emits: ['refresh'],
    components: { CardPhotoUploader },
    props: {
      addon: {
        default: {},
        type: Object
      }
    },
    methods: {
      onUploadSuccess(event: any) {
        this.addon.photo = event?.data?.filepath;
      },
      onUploadFail(event: any) {
        Swal.fire({
          title: 'Warning',
          text: 'Fail to upload photo, try again later.',
          icon: 'warning'
        });
      },
      async updateAddons() {
        await axios.get( variable()['api_main'] + "add_ons/update?" + $.param(this.addon)).then( async (response) => {
          if(response.data?.success) {
            Swal.fire({
              title: 'Success',
              text: response.data?.message,
              icon: 'success'
            }).then( async () => {
              this.$emit('refresh');
            });
          }
          else {
            Swal.fire({
              title: 'Warning',
              text: response.data?.message,
              icon: 'warning'
            });
          }
        });
      }
    }
  });

</script>