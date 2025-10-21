<template>
  <div>
    <div class="card">
      <h5 class="card-header">Add menu</h5>
      <CardPhotoUploader 
        @uploaded="onUploadSuccess"
        @fail="onUploadFail" 
        btn_upload_text="Replace"
        instruction="Select photo with png, jpg, jpeg file extensions for menu photo replacement."
      />
      <div class="card-body">
        <div class="form-group">
          <label>Menu name</label>
          <input v-model="form.name" type="text" class="form-control form-control-lg">
        </div>
        <div class="form-group mt-2">
          <label>Category</label>
          <select v-model="form.category" class="form-control form-control-lg">
            <option value="0">Select Category</option>
            <option v-for="(category, ci) in menu_categories" :key="ci" :value="category?.name">{{ category?.name }}</option>
          </select>
        </div>
        <div class="form-group mt-2">
          <label>Description</label>
          <textarea v-model="form.description" class="form-control form-control-lg" style="min-height: 60px;"></textarea>
        </div>
        <div class="form-group mt-2">
          <label>Package</label>
          <textarea v-model="form.package" class="form-control form-control-lg" style="min-height: 60px;"></textarea>
        </div>
        <div class="d-flex justify-content-end mt-4">
          <button class="btn btn-primary" @click="saveMenu()">Save Menu</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { variable } from '@/var';
  import CardPhotoUploader from "@/components/CardPhotoUploader.vue";
  import Swal from 'sweetalert2';
  import axios from 'axios';
  import $ from 'jquery';

  export default defineComponent({
    emits: ['refresh'],
    components: { CardPhotoUploader },
    data() {
      return {
        form: {
          name: '',
          category: '',
          description: '',
          package: '',
          photo: '',
          status: 1
        },
        menu_categories: {} as any
      }
    },
    methods: {
      onUploadSuccess(event: any) {
        this.form.photo = event?.data?.filepath;
      },
      onUploadFail() {
        Swal.fire({
          title: 'Warning',
          text: 'Fail to upload photo, try again later.',
          icon: 'warning'
        });
      },
      async fethMenuCategories() {
        await axios.get( variable()['api_main'] + "menu_categories/fetchAll" ).then( async (response) => {
          this.menu_categories = response.data;
        });
      },
      async saveMenu() {
        await axios.get( variable()['api_main'] + "menu/add?" + $.param(this.form) ).then( async (response) => {
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