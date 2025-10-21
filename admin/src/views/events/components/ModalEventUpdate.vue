<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Update Event</h5>
        </div>
        <CardPhotoUploader @uploaded="onUploadSuccess" @fail="onUploadFail" />
        <div class="modal-body bg-light-gray" style="max-height: calc(100vh - 300px);overflow: auto;">
          <div class="card">
            <div class="card-body">
              <div class="mb-3">
                <label class="form-label">Event Name</label>
                <input v-model="event.name" type="text" class="form-control form-control-lg">
              </div>
              <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea v-model="event.description" class="form-control form-control-lg" style="min-height: 150px;"></textarea>
              </div>
              <div class="mb-3">
                <label class="form-label">Package</label>
                <textarea v-model="event.package" class="form-control form-control-lg" style="min-height: 150px;"></textarea>
              </div>
              <div class="row">
                <div class="col-sm-12 col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Min. Occupancy</label>
                    <input v-model="event.min_occupancy" type="number" class="form-control form-control-lg">
                  </div>
                </div>
                <div class="col-sm-12 col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Max. Occupancy</label>
                    <input v-model="event.max_occupancy" type="number" class="form-control form-control-lg">
                  </div>
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label">Price per pax</label>
                <input v-model="event.price" type="number" class="form-control form-control-lg">
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="closeModal()" :disabled="loading">Close</button>
          <button class="btn btn-primary" @click="updateEvent()" :disabled="loading">Update</button>
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
  import CardPhotoUploader from "@/components/CardPhotoUploader.vue";
  import $ from 'jquery';

  export default defineComponent({
    emits: ['closed', 'refresh'],
    props: {
      open: {
        default: false,
        type: Boolean
      },
      event: {
        default: {},
        type: Object
      }
    },
    components: { CardPhotoUploader },
    data() {
      return {
        loading: false
      }
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      async updateEvent() {
        await axios.get( variable()['api_main'] + "events/update?" + $.param(this.event)).then( async (response) => {
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
      },
      onUploadSuccess(event: any) {
        this.event.photo = event?.data?.filepath;
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
<style scoped>
  .display {
    display: block;
    background-color: #0a0a0a42;
  }
</style>