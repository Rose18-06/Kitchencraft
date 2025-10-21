<template>
  <div class="card">
    <h5 class="card-header">Update Theme</h5>
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
        <button class="btn btn-primary w-25" @click="saveChanges()">Save</button>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
	import { variable } from '@/var';
  import axios from 'axios';
  import Swal from 'sweetalert2';
  import $ from 'jquery';

	export default defineComponent({
    emit: ['refresh'],
    props: {
      form: {
        default: {},
        type: Object
      }
    },
    methods: {
      async saveChanges() {
        const uri = variable()['api_main'] + "menu_categories/update?" + $.param(this.form);
        console.log("URI:", uri);
        await axios.get( uri ).then( async (response) => {
          console.log("Res:", toRaw(response));
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