<template>
  <div>
    <SectionHeader/>
    <main class="main">
      <SectionSlider/>
      <div class="container">
          <div class="py-5 my-5">
            <div class="row justify-content-center">
              <div class="col-md-5">
                <div class="card">
                  <div class="card-body py-5">
                    <h1 class="text-center mt-5">Verified</h1>
                    <i class="bi bi-person-check-fill d-block display-1 text-center text-success"></i>
                    <p class="text-center mt-4">{{ loading ? "Please wait, we're verifying your account!":"Your account was successfully verified" }}</p>
                    <button class="btn btn-primary btn-lg d-block m-auto w-50 mt-5" @click="()=>{ $router.replace('/login') }" :disabled="loading">{{ loading ? 'Please wait...':'Login' }}</button>
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
  import { variable } from '@/var';
  import SectionHeader from "@/components/SectionHeader.vue";
  import SectionFooter from "@/components/SectionFooter.vue";
  import SectionBanner from "@/components/SectionBanner.vue";
  import axios from 'axios';
  import Swal from 'sweetalert2';
  
  export default defineComponent({
    name: "ContactPage",
    components: { SectionFooter, SectionHeader, SectionBanner },
    data() {
      return {
        loading: false
      }
    },
    methods: {
      async verify() {
        var token = this.$route.params?.token + '';
        this.loading = true;
        await axios.get( variable()['api_main'] + "users_customer/verify?token=" + token ).then( async (response) => {
          this.loading = false;
          if(response.data?.success) {
            Swal.fire({
              title: 'Verified',
              text: response.data?.message,
              icon: 'success'
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
    },
    async mounted() {
      await this.verify();
    },
  });

</script>