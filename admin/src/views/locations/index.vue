<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="d-flex justify-content-between align-items-center">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Locations /</span> Masterlist</h4>
              <button class="btn btn-primary" @click="onCreateLocation()">New Location</button>
            </div>
            <div class="card">
              <div class="table-responsive text-nowrap">
                <table class="table">
                  <thead>
                    <tr>
                      <th>No.</th>
                      <th>Location</th>
                      <th>Price</th>
                      <th>Remarks</th>
                      <th style="width: 80px;">Edit</th>
                      <th style="width: 100px;">Delete</th>
                    </tr>
                  </thead>
                  <tbody class="table-border-bottom-0">
                    <tr v-for="(loc, i) in locations" :key="i">
                      <td>{{ i + 1 }}</td>
                      <td>{{ loc?.location }}</td>
                      <td>{{ toCurrencyFormat(loc?.price) }}</td>
                      <td class="text-wrap">{{ loc?.remarks }}</td>
                      <td><button class="btn btn-primary btn-sm" @click="onEditModal(loc)">Edit</button></td>
                      <td><button class="btn btn-danger btn-sm" @click="onDeleteLocation(loc)" >Delete</button></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <EditLocation
      :location="modal.location"
      :open="modal.edit_open"
      @closed="()=>{ modal.edit_open = false; }"
      @refresh="fetchLocations"
    />
    <CreateLocation
      :open="modal.create_open"
      @closed="()=>{ modal.create_open = false; }"
      @refresh="fetchLocations"
    />
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { queryDelete, queryFetchAll, queryInsertGetID } from '@/assets/ts/query';
  import { toCurrency } from "@/assets/ts/formatter.ts";
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import EditLocation from "./components/Edit.vue";
  import CreateLocation from './components/Create.vue';
  import Swal from 'sweetalert2';
  

  export default defineComponent({
    components: { CreateLocation, EditLocation, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        locations: [] as any,
        modal: {
          location: {} as any,
          edit_open: false,
          create_open: false
        }
      }
    },
    methods: {
      toCurrencyFormat(amount: any) {
        return toCurrency(amount);
      },
      onCreateLocation() {
        if(this.admin?.role == 1) {
          this.modal.create_open = true;
        }
        else {
          Swal.fire({
            title: 'Action denied',
            text: 'Only administrator level has permission to create new location',
            icon: 'error'
          });
        }
      },
      onEditModal(location: any) {
        if(this.admin?.role == 1) {
          this.modal.location   = location;
          this.modal.edit_open  = true;
        }
        else {
          Swal.fire({
            title: 'Action denied',
            text: 'Only administrator level has permission to edit a location',
            icon: 'error'
          });
        }
      },
      async fetchLocations() {
        await queryFetchAll({
          connection: 'undercater',
          table: 'location',
          where: [
            ['dataid', '>', 0]
          ],
          orderby: ['location','asc']
        }).then( async (response) => {
          this.locations = response;
        });
      },
      async onDeleteLocation(location: any) {
        if(this.admin?.role == 1) {
          Swal.fire({
            title: 'Confirmation',
            text: 'Delete ' + location?.location + '?',
            icon: 'question',
            confirmButtonText: 'Delete',
            confirmButtonColor: '#ff3e1d',
            showCancelButton: true
          }).then( async (result) => {
            if(result.isConfirmed) {
              await queryDelete({
                connection: 'undercater',
                table: 'location',
                where: [
                  ['dataid', location?.dataid]
                ]
              }).then( async (response) => {
                if(response.success) {
                  Swal.fire({
                    title: 'Deleted',
                    text: 'Successfully deleted',
                    icon: 'success'
                  }).then( async () => {
                    await this.fetchLocations();
                  });
                }
                else {
                  Swal.fire({
                    title: 'Warning',
                    text: 'Fail to delete, try again later.',
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
            text: 'Only administrator level has permission to delete a location',
            icon: 'error'
          });
        }
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          this.fetchLocations();
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>