<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Activity Logs /</span> Masterlist</h4>
            <div class="card">
              <h5 class="card-header">Manage Booking</h5>
              <div class="table-responsive text-nowrap">
                <table class="table">
                  <thead>
                    <tr>
                      <th>No.</th>
                      <th>Title</th>
                      <th>Description</th>
                      <th>Date & Time</th>
                      <th>Delete</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(log, li) in logs" :key="li">
                      <td>{{ li + 1 }}</td>
                      <td>{{ log?.title }}</td>
                      <td>{{ log?.activity }}</td>
                      <td>{{ log?.created_at }}</td>
                      <td><button class="btn btn-danger btn-sm" @click="deleteLogs(log)">Delete</button></td>
                    </tr>
                  </tbody>
                </table>
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
  import { variable } from '@/var';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import axios from 'axios';
import Swal from 'sweetalert2';
  
  export default defineComponent({
    components: { SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        logs: [] as any
      }
    },
    methods: {
      async fetchAllLogs() {
        await axios.get( variable()['api_main'] + "activity/fetchAll" ).then( async (logs) => {
          this.logs = logs.data;
        });
      },
      async deleteLogs(activity: any) {
        Swal.fire({
          title: 'Confirmation',
          text: 'Delete ' + activity?.title + '?',
          icon: 'question',
          confirmButtonText: 'Delete',
          showCancelButton: true
        }).then( async (result) => {
          if(result.isConfirmed) {
            await axios.get( variable()['api_main'] + "activity/delete?dataid=" + activity?.dataid ).then( async () => {
              await this.fetchAllLogs();
            });
          }
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchAllLogs().then( async () => {
            console.log("Logs:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>