<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="card">
              <div class="card-body">
                <p>If you’re a developer looking for most Powerful & comprehensive Bootstrap 5 HTML Admin Dashboard Template built for developers, rich with features, and highly customizable look no further than Sneat. We’ve followed the highest industry standards to bring you the very best admin template that is not only fast and easy to use but highly scalable. Offering ultimate convenience and flexibility, you’ll be able to build whatever application you want with very little hassle.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  

  export default defineComponent({
    components: { SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>