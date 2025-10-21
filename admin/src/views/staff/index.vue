<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="d-flex justify-content-between align-items-center py-3">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Staff /</span> Masterlist</h4>
              <div class="d-flex">
                <button class="btn btn-primary" @click="addStaff()">Add Staff</button>
              </div>
            </div>
            <div class="card">
              <h5 class="card-header">Manage Staff</h5>
              <div class="table-responsive text-nowrap">
                <table class="table">
                  <thead>
                    <tr>
                      <th>No.</th>
                      <th>Name</th>
                      <th>Contact</th>
                      <th>Email/Username</th>
                      <th>Status</th>
                      <th style="width: 100px;">Update</th>
                      <th style="width: 100px;">Delete</th>
                    </tr>
                  </thead>
                  <tbody class="table-border-bottom-0">
                    <tr v-for="(staff, si) in list" :key="si">
                      <td>{{ si + 1 }}</td>
                      <td>{{ staff?.last_name + ' ' + staff?.first_name }}</td>
                      <td>{{ staff?.contact }}</td>
                      <td>{{ staff?.email }}</td>
                      <td>{{ staff?.status == 1 ? 'Active' : 'Inactive' }}</td>
                      <td><button class="btn btn-primary btn-sm" @click="onStaffUpdate(staff)" >Update</button></td>
                      <td><button class="btn btn-danger btn-sm" @click="onStaffDelete(staff)">Delete</button></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <ModalUpdateStaff 
      :open="modal.update.open"
      :staff="modal.update.staff"
      @closed="()=>{ modal.update.open = false; }"
      @refresh="fetchStaff()"
    />
    <ModalAddStaff
      :open="modal.create.open"
      @closed="()=>{ modal.create.open = false; }"
      @refresh="fetchStaff()"
    />
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { variable } from '@/var';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import ModalUpdateStaff from "./components/ModalUpdateStaff.vue";
  import ModalAddStaff from './components/ModalAddStaff.vue';
  import axios from 'axios';
  import Swal from 'sweetalert2';
  
  export default defineComponent({
    components: { ModalAddStaff, ModalUpdateStaff, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        list: {} as any,
        modal: {
          update: {
            open: false,
            staff: {} as any
          },
          create: {
            open: false
          }
        }
      }
    },
    methods: {
      async addStaff() {
        await getLocalUser().then( async (user) => {
          if(user?.role == 1) {
            this.modal.create.open = true;
          }
          else {
            Swal.fire({
              title: 'Action denied',
              text: 'Only administrator level has permission to add a staff',
              icon: 'error'
            });
          }
        });
      },
      async fetchStaff() {
        await axios.get( variable()['api_main'] + "users_system/fetchAll" ).then( async (response) => {
          this.list = response.data;
        });
      },
      onStaffUpdate(staff: any) {
        this.modal.update.staff = staff;
        this.modal.update.open  = true;
      },
      onStaffDelete(staff: any) {
        Swal.fire({
          title: 'Confirmation',
          text: 'Delete ' + staff?.first_name + ' ' + staff?.last_name + '?',
          showCancelButton: true,
          icon: 'warning',
          confirmButtonText: 'Delete'
        }).then( async (result) => {
          if(result.isConfirmed) {
            await axios.get( variable()['api_main'] + "users_system/delete?dataid=" + staff?.dataid ).then( async (response) => {
              if(response.data?.success) {
                Swal.fire({
                  title: 'Success',
                  text: response.data?.message,
                  icon: 'success'
                }).then( async () => {
                  await this.fetchStaff();
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
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchStaff().then( async () => {
            console.log("Staff:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>