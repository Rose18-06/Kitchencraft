<template>
  <div>
    <!-- ✅ Card with border + shadow -->
    <div class="card upload-id-card shadow-card">
      <div class="card-body text-center">
        <!-- ✅ Title and description inside the card -->
        <h1>Upload Valid ID</h1>
        <p>
          Please upload a front photo of your valid ID<br />
          Make sure the text is clear and can be read.
        </p>

        <!-- ✅ Cropper Area -->
        <Cropper 
          class="cropper" 
          :src="photo.coverPicked" 
          :auto-zoom="false" 
          :stencil-props="{ aspectRatio: 10/10, movable: true, resizable: true }" 
          image-restriction="none"
          ref="cropper"
          :canvas="{ fillColor: 'white' }"
        />

        <!-- Hidden File Input -->
        <input
          class="d-none"
          type="file"
          ref="file"
          @change="loadImage($event)"
          accept="image/*"
        />

        <!-- ✅ Buttons -->
        <div class="row mt-4">
          <div class="col-6">
            <button
              class="btn btn-select-photo py-3 w-100 d-flex justify-content-center align-items-center"
              type="button"
              @click="openPhotoChooser()"
            >
              <i class="bi bi-file-image me-2" style="font-size: 26px; color: red;"></i>
              <span style="color: red;">Select Photo</span>
            </button>
          </div>
          <div class="col-6">
            <button
              class="btn btn-danger py-3 w-100 d-flex justify-content-center align-items-center"
              type="button"
              @click="upload()"
            >
              <i class="bi bi-cloud-upload-fill me-2" style="font-size: 26px;"></i>
              <span>Upload ID</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { Cropper } from 'vue-advanced-cropper';
import 'vue-advanced-cropper/dist/style.css';
import axios from 'axios';
import Swal from 'sweetalert2';
import { variable } from '@/var';
import { getBookingDataID } from '@/assets/ts/localStorage';

export default defineComponent({
  name: "SlideContent4",
  components: { Cropper },
  data() {
    return {
      photo: {
        coverPicked: "" as any,
      },
    };
  },
  methods: {
    async openPhotoChooser() {
      (this.$refs['file'] as any).click();
    },
    async loadImage(event: any) {
      const input = event.target;
      if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = (e) => {
          this.photo.coverPicked = e?.target?.result;
        };
        reader.readAsDataURL(input.files[0]);
      }
    },
    upload() {
      const canvas = (this.$refs['cropper'] as any).getResult();
      if (canvas) {
        const form = new FormData();
        canvas?.canvas?.toBlob(async (blob: Blob) => {
          await getBookingDataID().then(async (booking_dataid) => {
            form.append("image", blob);
            form.append("booking_dataid", booking_dataid);
            await axios
              .post(variable()['api_main'] + "photo/upload", form, {
                headers: { 'Content-Type': 'multipart/form-data' },
              })
              .then(async (response) => {
                console.log("Upload:", response.data);
                if (response.data?.success) {
                  Swal.fire({
                    title: "Success",
                    text: "Uploaded successfully",
                    icon: "success",
                  }).then(async () => {
                    this.$emit('next', { data: { index: 4 } });
                  });
                } else {
                  Swal.fire({
                    title: "Warning",
                    text: "Failed to upload photo. Please try again later.",
                    icon: "warning",
                  });
                }
              });
          });
        }, "image/png");
      } else {
        Swal.fire({
          title: "Warning",
          text: "Please select a valid ID to upload.",
          icon: "warning",
        });
      }
    },
  },
});
</script>

<style scoped>
/* ✅ Cropper area style */
.cropper {
  height: 400px;
  background: dimgray;
  border-radius: 10px;
}

/* ✅ Card Base Style */
.upload-id-card {
  border: 1px solid #ccc !important;
  border-radius: 12px;
  padding: 20px;
  background-color: #fff;
  transition: all 0.3s ease;
}

/* 🌟 Default shadow */
.shadow-card {
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
  transition: all 0.3s ease;
}

/* 💫 Hover Effect: lift, glow, and scale */
.shadow-card:hover {
  transform: translateY(-6px) scale(1.02);
  box-shadow: 0 8px 20px rgba(224, 47, 62, 0.35);
  border-color: rgba(224, 47, 62, 0.3);
}

/* 🟡 Select Photo button */
.btn-select-photo {
  background-color: #fff !important;
  border: 1px solid red !important;
  color: red !important;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.btn-select-photo:hover {
  background-color: #ffe6e6 !important;
  transform: translateY(-2px);
}

/* 🔴 Upload button hover */
.btn-danger {
  border-radius: 8px;
  transition: all 0.3s ease;
}

.btn-danger:hover {
  background-color: #c82333 !important;
  transform: translateY(-2px);
}
</style>
