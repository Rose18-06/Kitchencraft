<template>
  <div>
    <SectionHeader/>
    <main class="main">
      <div class="content">
        <div class="container">
          <div class="py-5 my-5">
            <div class="row justify-content-center">
              <div class="col-md-5">
                <div class="card">
                  <div class="card-body py-5">
                    <h1 class="text-center mt-5">Email Sent</h1>
                    <i class="bi bi-envelope-check-fill d-block display-1 text-center text-success"></i>
                    <p class="text-center mt-4">We sent an email verification, please check your email and verify your account to continue.</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <SectionFooter/>
    </main>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import SectionHeader from "@/components/SectionHeader.vue";
  import SectionFooter from "@/components/SectionFooter.vue";
  import SectionBanner from "@/components/SectionBanner.vue";

  export default defineComponent({
    name: "ContactPage",
    components: { SectionFooter, SectionHeader, SectionBanner }
  });

</script>