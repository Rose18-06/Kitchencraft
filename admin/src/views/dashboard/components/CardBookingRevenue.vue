<template>
  <div class="card">
    <div class="card-header">Revenue Chart</div>
    <div class="card-body">
      <Chart type="line" :data="chartData" :options="chartOptions" />
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import Chart from "primevue/chart"

  export default defineComponent({
    name: "CardBookingChart",
    props: {
      chart: {
        default: {} as any,
        type: Object
      }
    },
    components: { Chart },
    data() {
      return {
        chartData: {
          labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
          datasets: [
            {
              label: "Sales",
              data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
              fill: true,
              borderColor: "#42A5F5", // Line color
              backgroundColor: "rgba(66, 165, 245, 0.2)", // Area color
              tension: 0.4, // Smooth curve
            },
          ],
        },
        // Chart configuration options
        chartOptions: {
          responsive: true,
          plugins: {
            legend: {
              position: "top",
            },
            title: {
              display: true,
              text: "Monthly Revenue Data",
            },
          },
          scales: {
            x: {
              title: {
                display: true,
                text: "Months",
              },
            },
            y: {
              title: {
                display: true,
                text: "Sales ($)",
              },
              beginAtZero: true,
            },
          },
        },
      };
    },
    watch: {
      chart: function () {
        this.chartData.labels           = this.chart?.labels;
        this.chartData.datasets[0].data = this.chart?.data;

        console.log("Revenue:", toRaw(this.$data));
      }
    }

  });

</script>