<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="row">
              <div class="col-4">
                <div class="card">
                  <div class="card-body">
                    <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Reports /</span> Masterlist</h4>
                    <div class="form-group row">
                      <label for="report-month" class="col-sm-3 col-form-label">Month</label>
                      <div class="col-sm-9">
                        <select v-model="form.month" class="form-control" id="report-month">
                          <option value="01">January</option>
                          <option value="02">February</option>
                          <option value="03">March</option>
                          <option value="04">April</option>
                          <option value="05">May</option>
                          <option value="06">June</option>
                          <option value="07">July</option>
                          <option value="08">August</option>
                          <option value="09">September</option>
                          <option value="10">October</option>
                          <option value="11">November</option>
                          <option value="12">December</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group row mt-4">
                      <label for="report-month" class="col-sm-3 col-form-label">Year</label>
                      <div class="col-sm-9">
                        <select v-model="form.year" class="form-control" id="report-month">
                          <option value="2024">2024</option>
                          <option value="2025">2025</option>
                          <option value="2026">2026</option>
                          <option value="2027">2027</option>
                          <option value="2028">2028</option>
                          <option value="2029">2029</option>
                          <option value="2030">2030</option>
                        </select>
                      </div>
                    </div>
                    <div class="d-flex justify-content-end mt-4">
                      <button class="btn btn-primary w-50" @click="generateReport()" >Generate Report</button>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-8">
                <iframe style="width: 100%;min-height: calc(100vh - 120px);" src="https://api.undercater.com/ver-1/public/api/booking/reportPDF?month=12&year=2024"></iframe>
              </div>
            </div>
            
          </div>
        </div>
      </div>
    </div>
    <ModalPrintReport :open="modal_open" @closed="()=>{ modal_open = false; }" />
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { variable } from '@/var';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import ModalPrintReport from "./components/ModalPrintReport.vue";
  import axios from 'axios';
  import $ from 'jquery';

  export default defineComponent({
    components: { ModalPrintReport, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        modal_open: false,
        scope: 'daily',
        reports: {} as any,
        form: {
          month: '01',
          year: '2024'
        }
      }
    },
    methods: {
      async generateReport() {
        var uri = variable()['api_main'] + "booking/reportPDF?" + $.param(this.form);
        $("iframe").attr('src', uri);
      },
      async onScopeChanged() {
        await this.fetchReport();
      },
      async fetchReport() {
        await axios.get(  variable()['api_main'] + "booking/report?scope=" + this.scope ).then( async (response) => {
          this.reports = response.data;
        });
      },
      printTable() {
        const elem = document.getElementById('printable-report-booking');
        if(elem) {
          const table = elem.outerHTML;
          const printWindow = window.open('', '', 'height=600,width=800');
          if(printWindow) {
            printWindow.document.write('<html><head><title>Print Table</title>');
            printWindow.document.write('<style>table {width: 100%; border-collapse: collapse;} th, td {border: 1px solid black; padding: 8px; text-align: left;}</style>');
            printWindow.document.write('</head><body>');
            printWindow.document.write(table);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
          }
        }
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchReport().then( async () => {
            console.log("Reports:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>