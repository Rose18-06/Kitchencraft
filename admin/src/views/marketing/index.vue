<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="d-flex justify-content-between align-items-center py-3">
              <h4 class="fw-bold">Manage Marketing</h4>
              <div class="d-flex">
                <input type="text" class="form-control me-3" placeholder="Search" />
                <button class="btn btn-primary" style="width: 180px;" @click="()=>{ modal.create_marketing_open = true; }">Create</button>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-6 col-lg-4" v-for="(marketing, bi) in marketings" :key="bi">
                <CardMarketing 
                  :marketing="marketing" 
                  @edit="openEditModal"
                  @refresh="fetchMarketing()"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <ModalCreateMarketing :open="modal.create_marketing_open" @closed="()=>{ modal.create_marketing_open = false; }" @refresh="fetchMarketing()" />
    <ModalEditMarketing :open="modal.update_marketing_open" :marketing="modal.update_marketing_info" @closed="()=>{ modal.update_marketing_open = false; }" />
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { variable } from '@/var';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import CardMarketing from './components/CardMarketing.vue';
  import ModalCreateMarketing from './components/ModalCreateMarketing.vue';
  import ModalEditMarketing from './components/ModalEditMarketing.vue';
  import axios from 'axios';
  
  export default defineComponent({
    components: { ModalEditMarketing, ModalCreateMarketing, CardMarketing, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        modal: {
          create_marketing_open: false,
          update_marketing_open: false,
          update_marketing_info: {} as any,
        },
        marketings: {} as any
      }
    },
    methods: {
      async fetchMarketing() {
        await axios.get( variable()['api_main'] + "marketing/fetchAll" ).then( async (response) => {
          this.marketings = response.data;
        });
      },
      openEditModal(marketing: any) {
        this.modal.update_marketing_open = true;
        this.modal.update_marketing_info = marketing.data;
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchMarketing().then( async () => {
            console.log("Marketing:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>
