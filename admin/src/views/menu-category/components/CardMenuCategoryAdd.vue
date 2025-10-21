<template>
  <div class="card">
    <h5 class="card-header">Add Theme</h5>
    <div class="card-body">
      <div class="form-group mt-4">
        <label>Category name</label>
        <input v-model="form.name" type="text" class="form-control form-control-lg">
      </div>
      <div class="form-group mt-4">
        <label>Description</label>
        <textarea v-model="form.description" class="form-control form-control-lg"></textarea>
      </div>
      <div class="d-flex justify-content-end mt-4">
        <button class="btn btn-primary" @click="createCategory()">Save</button>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

	import { variable } from '@/var';
  import { defineComponent } from 'vue';
  import Swal from 'sweetalert2';
  import axios from 'axios';
  import $ from 'jquery';
  
	export default defineComponent({
    data() {
      return {
        form: {
          name: '',
          description: ''
        }
      }
    },
    methods: {
      async createCategory() {
        await axios.get( variable()['api_main'] + "menu_categories/create?" + $.param(this.form) ).then( async (response) => {
          if(response.data?.success) {
            Swal.fire({
              title: 'Success',
              text: response.data?.message,
              icon: 'success'
            }).then( async () => {
              this.form.name        = '';
              this.form.description = '';
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