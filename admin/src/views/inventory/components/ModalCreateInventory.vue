<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Add Inventory</h5>
        </div>
        <hr/>
        <div class="modal-body" style="max-height: calc(100vh - 300px);overflow: auto;">
          <div class="form-group">
            <label>Inventory Name</label>
            <input v-model="form.name" type="text" class="form-control form-control-lg">
          </div>
          <div class="row">
            <div class="col-6">
              <div class="form-group mt-4">
                <label>Inventory Stock</label>
                <input v-model="form.stock"  type="number" class="form-control form-control-lg">
              </div>
            </div>
            <div class="col-6">
              <div class="form-group mt-4">
                <label>Price</label>
                <input v-model="form.price" type="number" class="form-control form-control-lg">
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" @click="closeModal()">Close</button>
          <button type="button" class="btn btn-primary" @click="saveItem()">Save</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { variable } from '@/var';
  import axios from 'axios';
  import Swal from 'sweetalert2';
  import $ from 'jquery';

  export default defineComponent({
    props: {
      open: {
        default: false,
        type: Boolean
      }
    },
    data() {
      return {
        form: {
          name: '',
          price: 0,
          stock: 0
        }
      }
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      async saveItem() {
        await axios.get( variable()['api_main'] + "inventory_stocks/create?" + $.param(this.form) ).then( async (response) => {
          if(response.data?.success) {
            Swal.fire({
              title: 'Success',
              text: response.data?.message,
              icon: 'success'
            }).then( async () => {
              this.form.name        = '';
              this.form.price       = 0;
              this.form.stock       = 0;
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
<style scoped>
  .display {
    display: block;
    background-color: #0a0a0a42;
  }
</style>