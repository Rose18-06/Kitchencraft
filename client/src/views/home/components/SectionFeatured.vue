<template>
  <div class="row g-4">
    <!-- Video Card (left) -->
    <div
      class="col-md-6"
      data-aos="fade-right"
      data-aos-duration="1000"
      data-aos-easing="ease-out-cubic"
    >
      <div class="card custom-shadow border-0">
        <video class="w-100" :src="videoFile" controls></video>
        <div class="card-body text-center">
          <h3 class="text-danger">Savor</h3>
          <p><i>Freshly Prepared, Served with Love.</i></p>
        </div>
      </div>
    </div>

    <!-- Image Card (right) -->
    <div
      class="col-md-6"
      data-aos="fade-left"
      data-aos-duration="1000"
      data-aos-easing="ease-out-cubic"
    >
      <div class="card custom-shadow border-0">
        <img class="w-100" :src="imageFile" alt="Home Logo" />
        <div class="card-body text-center">
          <h3 class="text-danger">CaterMate</h3>
          <p><i>Your Trusted Catering Partner.</i></p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// Import static files from src/assets
import videoFile from "@/assets/vid/video.mp4";
import imageFile from "@/assets/image/homelogo.jfif";
</script>

<style scoped>
img,
video {
  max-height: 300px;
  object-fit: cover;
  object-position: center;
  border-radius: 8px;
}

/* Custom shadow style */
.custom-shadow {
  box-shadow: 0 8px 20px rgba(230, 57, 70, 0.45) !important;
  border-radius: 12px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.custom-shadow:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 25px rgba(230, 57, 70, 0.6) !important;
}
</style>
