<template>
  <div class="row g-4 mb-5">
    <!-- Left Card -->
    <div class="col-md-6" data-aos="fade-up" data-aos-duration="1000" data-aos-easing="ease-out-cubic">
      <div class="card custom-shadow border-0">
        <img class="w-100" :src="leftImage" alt="Left Add-on" />
        <div class="card-body text-center">
          <h3 class="text-dark">Clown</h3>
          <p>
            Bring laughter and joy to your event with our fun-filled clown performance.
            Perfect for kids’ parties and family celebrations. Expect balloons,
            magic tricks, and endless smiles!
          </p>
          <div class="mt-4 border-left-orange">
            <h1>₱4500</h1>
            <h5>
              Before <span style="text-decoration: line-through;">₱5000</span>
            </h5>
          </div>
        </div>
      </div>
    </div>

    <!-- Right Card -->
    <div class="col-md-6" data-aos="fade-up" data-aos-duration="1200" data-aos-easing="ease-out-cubic">
      <div class="card custom-shadow border-0">
        <img class="w-100" :src="rightImage" alt="Right Add-on" />
        <div class="card-body text-center">
          <h3 class="text-dark">Karaoke</h3>
          <p>
            Turn your event into a concert with our karaoke add-on. Sing your heart
            out with friends and family — complete with sound system, microphones,
            and a library of your favorite songs.
          </p>
          <div class="mt-4 border-left-orange">
            <h1>₱700</h1>
            <h5>
              Before <span style="text-decoration: line-through;">₱1000</span>
            </h5>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// Import static images from src/assets
import leftImage from "@/assets/image/clownlogo.jfif";
import rightImage from "@/assets/image/karaokelogo.jfif";
</script>

<style scoped>
img {
  max-height: 300px;
  object-fit: cover;
  object-position: center;
  border-radius: 8px;
}

.row {
  margin-bottom: 80px; /* Extra spacing before SectionParalax */
}

/* Hover animation */
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
