<template>
  <div class="card">
    <h5 class="card-header">Update Theme</h5>
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
        <button class="btn btn-primary" @click="updateTheme()">Update</button>
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
    props: {
      theme: {
        default: {},
        type: Object
      }
    },
    data() {
      return {
        form: {
          dataid: '',
          name: '',
          description: ''
        }
      }
    },
    methods: {
      async updateTheme() {
        await axios.get( variable()['api_main'] + "themes/update?" + $.param(this.form)).then( async (response) => {
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
    },
    watch: {
      theme: function () {
        this.form.dataid      = this.theme?.dataid;
        this.form.name        = this.theme?.name;
        this.form.description = this.theme?.description;
      }
    }
  });

</script>