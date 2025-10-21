<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Marketing Details</h5>
        </div>
        <div class="modal-body" style="max-height: calc(100vh - 300px);overflow: auto;">
          <swiper :slides-per-view="1" :space-between="50" @swiper="onSwiper">
            <swiper-slide class="swiper-no-swiping">
              <CardPhotoUploader 
                @uploaded="onUploadSuccess"
                @fail="onUploadFail"
                instruction="Upload photo with png, jpg, jpeg file extension"
              />
            </swiper-slide>
            <swiper-slide class="swiper-no-swiping">
              <CardVideoUploader
                @uploaded="onUploadSuccess"
                @fail="onUploadFail"
                instruction="Upload video with mp4 extension"
              />
            </swiper-slide>
          </swiper>
          <div class="form-group mt-3">
            <label>File Type</label>
            <select class="form-control form-control-lg" @change="onFileTypeChanged">
              <option value="0">Select File Type</option>
              <option value="photo">Photo</option>
              <option value="video">Video</option>
            </select>
          </div>
          <div class="form-group mt-3">
            <label>Title</label>
            <input v-model="form.title" type="text" class="form-control form-control-lg">
          </div>
          <div class="form-group mt-4">
            <label>Description</label>
            <textarea v-model="form.content" class="form-control form-control-lg"></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" @click="closeModal()">Close</button>
          <button type="button" class="btn btn-primary" @click="saveMarketing()">Save</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { variable } from '@/var';
  import { Swiper, SwiperSlide } from 'swiper/vue';
  import CardVideoUploader from "@/components/CardVideoUploader.vue";
  import CardPhotoUploader from "@/components/CardPhotoUploader.vue";
  import Swal from 'sweetalert2';
  import axios from 'axios';
  import $ from 'jquery';
  
  export default defineComponent({
    emits: ['refresh', 'closed'],
    props: {
      open: {
        default: false,
        type: Boolean
      }
    },
    components: { CardVideoUploader, CardPhotoUploader, Swiper, SwiperSlide },
    data() {
      return {
        swiper: {} as any,
        form: {
          title: '',
          content: '',
          photo: '',
          status: 1
        }
      }
    },
    methods: {
      onFileTypeChanged(event: any) {
        if(event?.target.value == 'photo') {
          this.swiper.slideTo(0);
        }
        else if(event?.target.value == 'video') {
          this.swiper.slideTo(1);
        }
      },
      onSwiper(event: any) {
        this.swiper = event;
      },
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
      async saveMarketing() {
        await axios.get( variable()['api_main'] + "marketing/create?" + $.param(this.form) ).then( async (response) => {
          if(response.data?.success) {
            Swal.fire({
              title: 'Success',
              text: response.data?.message,
              icon: 'success'
            }).then( async () => {
              this.form.title       = '';
              this.form.content     = '';
              this.form.photo       = '';
              this.form.status      = 1;
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