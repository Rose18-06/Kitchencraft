<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="d-flex justify-content-between align-items-center py-3">
              <h4 class="fw-bold py-3">Manage Inventory</h4>
              <div class="d-flex">
                <button class="btn btn-primary" @click="()=>{ modal.create_open = true; }">Add Inventory</button>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-4">
                <div class="card">
                  <h5 class="card-header">Update Inventory</h5>
                  <div class="card-body">
                    <div class="mb-3">
                      <label class="form-label">Name</label>
                      <input v-model="form.name" type="text" class="form-control form-control-lg">
                    </div>
                    <div class="row">
                      <div class="col-6">
                        <div class="mb-3">
                          <label class="form-label">Price</label>
                          <input v-model="form.price" type="number" class="form-control form-control-lg">
                        </div>
                      </div>
                      <div class="col-6">
                        <div class="mb-3">
                          <label class="form-label">Stock</label>
                          <input v-model="form.stock" type="number" class="form-control form-control-lg">
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-6">
                        <div class="mb-3">
                          <label class="form-label">Lost</label>
                          <input v-model="form.lost" type="number" class="form-control form-control-lg">
                        </div>
                      </div>
                      <div class="col-6">
                        <div class="mb-3">
                          <label class="form-label">Damage</label>
                          <input v-model="form.damage" type="number" class="form-control form-control-lg">
                        </div>
                      </div>
                      <div class="d-flex justify-content-end mt-4">
                        <button class="btn btn-primary btn-lg w-50" @click="updateItem()" >Update</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-sm-12 col-md-8">
                <div class="card">
                  <h5 class="card-header">Manage Inventory</h5>
                  <div class="table-responsive text-nowrap">
                    <table class="table">
                      <thead>
                        <tr>
                          <th style="width: 50px;">No.</th>
                          <th>Name</th>
                          <th>Price</th>
                          <th>Stock</th>
                          <th>Lost</th>
                          <th>Damage</th>
                          <th style="width: 100px;">Update</th>
                          <th style="width: 100px;">Delete</th>
                        </tr>
                      </thead>
                      <tbody class="table-border-bottom-0">
                        <tr v-for="(item, ii) in inventories" :key="ii">
                          <td>{{ ii + 1 }}</td>
                          <td>{{ item?.name }}</td>
                          <td>
                            <button class="btn btn-clear btn-sm px-0">
                              <span class="me-2">PHP {{ item?.price ? item?.price : '0.00'  }}</span>
                            </button>
                          </td>
                          <td>
                            <button class="btn btn-clear btn-sm px-0">
                              <span class="me-2">{{ item?.stock ? item?.stock : '0.00' }}</span>
                            </button>
                          </td>
                          <td>
                            <button class="btn btn-clear btn-sm px-0">
                              <span class="me-2">{{ item?.lost ? item?.lost : '0.00' }}</span>
                            </button>
                          </td>
                          <td>
                            <button class="btn btn-clear btn-sm px-0">
                              <span class="me-2">{{ item?.damage ? item?.damage : '0.00' }}</span>
                            </button>
                          </td>
                          <td><button class="btn btn-primary btn-sm" @click="()=>{ form = item }" >Update</button></td>
                          <td><button class="btn btn-danger btn-sm" @click="deleteItem(item)" >Delete</button></td>
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
    </div>
    <ModalCreateInventory 
      :open="modal.create_open" 
      @closed="()=>{ modal.create_open = false; }"
      @refresh="fetchAllInventory()" />
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { variable } from '@/var';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import ModalCreateInventory from "./components/ModalCreateInventory.vue";
  import axios from 'axios';
  import Swal from 'sweetalert2';
  import $ from 'jquery';

  export default defineComponent({
    components: { ModalCreateInventory, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        modal: {
          create_open: false
        },
        inventories: {} as any,
        form: {} as any
      }
    },
    methods: {
      async fetchAllInventory() {
        await axios.get( variable()['api_main'] + "inventory_stocks/fetchAll" ).then( async (response) => {
          this.inventories = response.data;
        });
      },
      async updateItem() {
        await axios.get( variable()['api_main'] + "inventory_stocks/update?" + $.param(this.form) ).then( async (response) => {
          if(response.data?.success) {
            Swal.fire({
              title: 'Success',
              text: response.data?.message,
              icon: 'success'
            }).then( async () => {
              this.form = {};
              await this.fetchAllInventory();
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
      },
      async deleteItem(item: any) {
        await getLocalUser().then( async (user) => {
          if(user?.role == 1) {
            Swal.fire({
              title: 'Success',
              text: 'Delete ' + item?.name + '?',
              icon: 'question',
              showCancelButton: true,
              confirmButtonText: 'Delete',
            }).then( async (result) => {
              if(result.isConfirmed) {
                await axios.get( variable()['api_main'] + "inventory_stocks/delete?dataid=" + item?.dataid ).then( async (response) => {
                  if(response.data?.success) {
                    Swal.fire({
                      title: 'Success',
                      text: response.data?.message,
                      icon: 'success'
                    }).then( async () => {
                      await this.fetchAllInventory();
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
          await this.fetchAllInventory().then( async () => {
            console.log("Inventory:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>