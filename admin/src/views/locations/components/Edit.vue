<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Edit Location</h5>
        </div>
        <div class="modal-body bg-light-gray" style="max-height: calc(100vh - 300px);overflow: auto;">
          <div class="card">
            <div class="card-body">
              <div class="mb-3">
                <label class="form-label">Location</label>
                <input v-model="location.location" type="text" class="form-control">
              </div>
              <div class="row">
                <div class="col-6">
                  <div class="mb-3">
                    <label class="form-label">Price</label>
                    <input v-model="location.price" type="number" class="form-control">
                  </div>
                </div>
                <div class="col-6">
                  <div class="mb-3">
                    <label class="form-label">Add-on Fee</label>
                    <input v-model="location.applied_fee" type="number" class="form-control">
                  </div>
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label">Notice</label>
                <input v-model="location.venue" type="text" class="form-control">
              </div>
              <div class="mb-3">
                <label class="form-label">Inclusion</label>
                <textarea v-model="location.inclusions" class="form-control"></textarea>
              </div>
              <div class="mb-3">
                <label class="form-label">Remarks</label>
                <textarea v-model="location.remarks" class="form-control"></textarea>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="closeModal()">Close</button>
          <button type="button" class="btn btn-primary w-25" @click="updateLocation()" >Update</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { queryUpdate } from '@/assets/ts/query';
  import Swal from 'sweetalert2';

  export default defineComponent({
    emits: ['closed', 'refresh'],
    props: {
      open: {
        default: false,
        type: Boolean
      },
      location: {
        default: {},
        type: Object
      }
    },
    data() {
      return {
        user: {} as any
      }
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      async updateLocation() {
        await queryUpdate({
          connection: 'undercater',
          table: 'location',
          where: [
            ['dataid', this.location?.dataid]
          ],
          columns: [
            {location:this.location?.location},
            {price:this.location?.price},
            {venue:this.location?.venue},
            {inclusions:this.location?.inclusions},
            {remarks:this.location?.remarks},
            {applied_fee:this.location?.applied_fee}
          ]
        }).then( async (response) => {
          if(response.success) {
            Swal.fire({
              title: 'Success',
              text: 'Successfully updated',
              icon: 'success'
            }).then( async () => {
              this.$emit('refresh');
            });
          }
          else {
            Swal.fire({
              title: 'Warning',
              text: 'Fail to update, try again later.',
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