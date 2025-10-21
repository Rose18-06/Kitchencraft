<template>
  <div class="card">
    <h5 class="card-header">Add Theme</h5>
    <div class="card-body">
      <div class="form-group mt-4">
        <label>Theme name</label>
        <input v-model="form.name" type="text" class="form-control form-control-lg">
      </div>
      <div class="form-group mt-4">
        <label>Description</label>
        <textarea v-model="form.description" class="form-control form-control-lg"></textarea>
      </div>
      <div class="d-flex justify-content-end mt-4">
        <button class="btn btn-primary" @click="saveTheme()">Save</button>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { variable } from '@/var';
  import $ from 'jquery';
  import axios from 'axios';
  import Swal from 'sweetalert2';

  export default defineComponent({
    emits: ['refresh'],
    data() {
      return {
        form: {
          name: '',
          description: ''
        }
      }
    },
    methods: {
      async saveTheme() {
        await axios.get( variable()['api_main'] + "themes/add?" + $.param(this.form)).then( async (response) => {
          if(response.data?.success) {
            Swal.fire({
              title: 'Success',
              text: response.data?.message,
              icon: 'success'
            }).then( async () => {
              this.form.name          = '';
              this.form.description   = '';
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