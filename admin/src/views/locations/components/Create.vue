<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Create Location</h5>
        </div>
        <div class="modal-body bg-light-gray" style="max-height: calc(100vh - 300px);overflow: auto;">
          <div class="card">
            <div class="card-body">
              <div class="mb-3">
                <label class="form-label">Location</label>
                <input v-model="form.location" type="text" class="form-control">
              </div>
              <div class="row">
                <div class="col-6">
                  <div class="mb-3">
                    <label class="form-label">Price</label>
                    <input v-model="form.price" type="number" class="form-control">
                  </div>
                </div>
                <div class="col-6">
                  <div class="mb-3">
                    <label class="form-label">Add-on Fee</label>
                    <input v-model="form.applied_fee" type="number" class="form-control">
                  </div>
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label">Notice</label>
                <input v-model="form.venue" type="text" class="form-control">
              </div>
              <div class="mb-3">
                <label class="form-label">Inclusion</label>
                <textarea v-model="form.inclusions" class="form-control"></textarea>
              </div>
              <div class="mb-3">
                <label class="form-label">Remarks</label>
                <textarea v-model="form.remarks" class="form-control"></textarea>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="closeModal()">Close</button>
          <button type="button" class="btn btn-primary w-25" @click="onCreateLocation()">Create</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { queryInsertGetID } from '@/assets/ts/query';
  import Swal from 'sweetalert2';

  export default defineComponent({
    emits: ['closed', 'refresh'],
    props: {
      open: {
        default: false,
        type: Boolean
      }
    },
    data() {
      return {
        user: {} as any,
        form: {
          location: '',
          price: 0,
          venue: '',
          inclusions: '',
          remarks: '',
          applied_fee: 0
        }
      }
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      async onCreateLocation() {
        await queryInsertGetID({
          connection: 'undercater',
          table: 'location',
          columns: this.form
        }).then( async (response) => {
          if(response.success) {
            Swal.fire({
              title: 'Success',
              text: 'Successfully created',
              icon: 'success'
            }).then( async () => {
              this.$emit('refresh');
            });
          }
          else {
            Swal.fire({
              title: 'Warning',
              text: 'Fail to create, try again later.',
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