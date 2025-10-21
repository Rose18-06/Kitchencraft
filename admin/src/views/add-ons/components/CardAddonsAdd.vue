<template>
  <div class="card">
    <h5 class="card-header">Add Add-ons</h5>
    <CardPhotoUploader 
      @uploaded="onUploadSuccess" 
      @fail="onUploadFail"
    />
    <div class="card-body">
      <div class="form-group">
        <label>Add-ons Name</label>
        <input v-model="form.name" type="text" class="form-control form-control-lg">
      </div>
      <div class="form-group mt-2">
        <label>Description</label>
        <textarea v-model="form.description" class="form-control form-control-lg"></textarea>
      </div>
      <div class="row">
        <div class="col-sm-12 col-md-6">
          <div class="form-group mt-2">
            <label>Price</label>
            <input v-model="form.price" type="text" class="form-control form-control-lg">
          </div>
        </div>
        <div class="col-sm-12 col-md-6">
          <div class="form-group mt-2">
            <label>Sale Price</label>
            <input v-model="form.priceSale" type="text" class="form-control form-control-lg">
          </div>
        </div>
      </div>
      <div class="d-flex justify-content-end mt-4">
        <button class="btn btn-primary" @click="saveAddOns()">Save</button>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { variable } from '@/var';
  import { defineComponent } from 'vue';
  import CardPhotoUploader from "@/components/CardPhotoUploader.vue";
  import axios from 'axios';
  import Swal from 'sweetalert2';
  import $ from 'jquery';
  
  export default defineComponent({
    emits: ['refresh'],
    components: { CardPhotoUploader },
    data() {
      return {
        form: {
          name: '',
          description: '',
          price: 0,
          priceSale: 0,
          photo: '',
          status: 1
        }
      }
    },
    methods: {
      async saveAddOns() {
        await axios.get( variable()['api_main'] + "add_ons/create?" + $.param(this.form)).then( async (response) => {
          if(response.data?.success) {
            Swal.fire({
              title: 'Success',
              text: response.data?.message,
              icon: 'success'
            }).then( async () => {
              this.form.name          = '';
              this.form.description   = '';
              this.form.price         = 0;
              this.form.priceSale     = 0;
              this.form.photo         = '';
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
      },
      onUploadSuccess(event: any) {
        this.form.photo = event?.data?.filepath;
      },
      onUploadFail(event: any) {
        Swal.fire({
          title: 'Warning',
          text: 'Fail to upload photo, try again later.',
          icon: 'warning'
        });
      },
    }
  });

</script>