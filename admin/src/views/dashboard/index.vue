<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }" />
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="row">
              <div class="col-sm-12 col-md-4 col-lg-3" v-for="(count, ci) in dashboard.counter" :key="ci">
                <CardCounts :label="count?.label" :value="count?.value" />
              </div>
            </div>
            <div class="row mt-4">
              <div class="col-sm-12 col-md-6">
                <CardBookingChart :chart="dashboard.chart?.sale"/>
              </div>
              <div class="col-sm-12 col-md-6">
                <CardBookingRevenue :chart="dashboard.chart?.revenue" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { variable } from '@/var';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import CardCounts from './components/CardCounts.vue';
  import CardBookingChart from './components/CardBookingChart.vue';
  import CardBookingRevenue from "./components/CardBookingRevenue.vue";
  import axios from 'axios';
  
  export default defineComponent({
    components: { CardBookingChart, CardBookingRevenue, CardCounts, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        dashboard: {
          counter: {} as any,
          chart: {} as any
        }
      }
    },
    methods: {
      async fetchCounter() {
        await axios.get( variable()['api_main'] + "dashboard/counter" ).then( async (counter) => {
          this.dashboard.counter = counter.data;
        });
      },
      async fetchChart() {
        await axios.get( variable()['api_main'] + "dashboard/chart" ).then( async (chart) => {
          this.dashboard.chart = chart.data;
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchCounter().then( async () => {
            await this.fetchChart().then( async () => {
              console.log("Dashboard:", toRaw(this.$data));
            });
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>