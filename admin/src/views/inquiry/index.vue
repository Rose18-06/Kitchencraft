<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Inquiry /</span> Masterlist</h4>
            <div class="card">
              <h5 class="card-header">Manage Inquiry</h5>
              <div class="table-responsive text-nowrap">
                <table class="table">
                  <thead>
                    <tr>
                      <th style="width: 50px;">No.</th>
                      <th>Sender</th>
                      <th>Message</th>
                      <th>Date</th>
                      <th style="width: 100px;">Delete</th>
                    </tr>
                  </thead>
                  <tbody class="table-border-bottom-0">
                    <tr v-for="(inquiry, ii) in inquiries" :key="ii">
                      <td>{{ ii + 1 }}</td>
                      <td>
                        <div>
                          <p class="p-0 m-0">{{ inquiry?.name }}</p>
                          <p class="p-0 m-0"><small>{{ inquiry?.email }}</small></p>
                        </div>
                      </td>
                      <td>
                        <div>
                          <p class="p-0 m-0 text-wrap text-primary"><b>{{ inquiry?.subject }}</b></p>
                          <p class="p-0 m-0 text-wrap"><small>{{ inquiry?.message }}</small></p>
                        </div>
                      </td>
                      <td>{{ inquiry?.created_at }}</td>
                      <td><button class="btn btn-danger btn-sm" @click="deleteInquiry(inquiry)" >Delete</button></td>
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
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { variable } from '@/var';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import Swal from 'sweetalert2';
  import axios from 'axios';

  export default defineComponent({
    components: { SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        inquiries: {} as any
      }
    },
    methods: {
      async fetchFetch() {
        await axios.get( variable()['api_main'] + "inquiry/fetchAll" ).then( async (response) => {
          this.inquiries = response.data;
        });
      },
      async deleteInquiry(inquiry: any) {
        await getLocalUser().then( async (user) => {
          if(user?.role == 1) {
            Swal.fire({
              title: 'Success',
              text: 'Delete inquiry of ' + inquiry?.name + '?',
              icon: 'question',
              showCancelButton: true,
              confirmButtonText: 'Delete',
            }).then( async (result) => {
              if(result.isConfirmed) {
                await axios.get( variable()['api_main'] + "inquiry/delete?dataid=" + inquiry?.dataid ).then( async (response) => {
                  if(response.data?.success) {
                    Swal.fire({
                      title: 'Success',
                      text: response.data?.message,
                      icon: 'success'
                    }).then( async () => {
                      await this.fetchFetch();
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
            });
          }
          else {
            Swal.fire({
              title: 'Action denied',
              text: 'Only administrator level has permission to delete',
              icon: 'error'
            });
          }
        });
            
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchFetch().then( async () => {
            console.log("Inquiry:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>