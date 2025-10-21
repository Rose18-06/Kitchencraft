<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Booking Details</h5>
        </div>
        <div class="modal-body" style="max-height: calc(100vh - 300px);overflow: auto;">
          <CardPhotoUploader @uploaded="onUploadSuccess" @fail="onUploadFail" />
          <div class="form-group mt-3">
            <label>Title</label>
            <input v-model="form.title" type="text" class="form-control form-control-lg">
          </div>
          <div class="form-group mt-4">
            <label>Description</label>
            <textarea v-model="form.description" class="form-control form-control-lg"></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" @click="closeModal()">Close</button>
          <button type="button" class="btn btn-primary" @click="saveBlog()">Save</button>
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
  
  export default defineComponent({
    emits: ['refresh', 'closed'],
    props: {
      open: {
        default: false,
        type: Boolean
      }
    },
    components: { CardPhotoUploader },
    data() {
      return {
        form: {
          title: '',
          description: '',
          photo: '',
          status: 1
        }
      }
    },
    methods: {
      closeModal() {
        this.$emit("closed");
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
      async saveBlog() {
        await axios.get( variable()['api_main'] + "blog/create?" + $.param(this.form) ).then( async (response) => {
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
<style scoped>
  .display {
    display: block;
    background-color: #0a0a0a42;
  }
</style>