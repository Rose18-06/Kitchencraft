<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Update Marketing</h5>
        </div>
        <hr/>
        <div class="modal-body" style="max-height: calc(100vh - 300px);overflow: auto;">
          <CardPhotoUploader 
            @uploaded="onUploadSuccess"
            @fail="onUploadFail" 
            btn_upload_text="Replace"
            instruction="Select photo with png, jpg, jpeg file extensions for marketing photo replacement."
          />
          <div class="form-group mt-3">
            <label>Title</label>
            <input v-model="marketing.title" type="text" class="form-control form-control-lg">
          </div>
          <div class="form-group mt-4">
            <label>Description</label>
            <textarea v-model="marketing.content" class="form-control form-control-lg" style="min-height: 250px;"></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" @click="closeModal()">Close</button>
          <button type="button" class="btn btn-primary" @click="saveMarketing()" >Save</button>
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
    props: {
      open: {
        default: false,
        type: Boolean
      },
      marketing: {
        default: {},
        type: Object
      }
    },
    components: { CardPhotoUploader },
    data() {
      return {}
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      async saveMarketing() {
        await axios.get( variable()['api_main'] + "marketing/update?" + $.param(this.marketing)).then( async (response) => {
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
        this.marketing.photo = event?.data?.filepath;
      },
      onUploadFail(event: any) {
        Swal.fire({
          title: 'Warning',
          text: 'Fail to replace photo, try again later.',
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