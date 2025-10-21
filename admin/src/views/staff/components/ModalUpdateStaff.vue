<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content ">
        <div class="modal-header">
          <h5 class="modal-title">Update Staff</h5>
        </div>
        <div class="modal-body bg-light-gray" style="max-height: calc(100vh - 300px);overflow: auto;">
          <div class="card">
            <div class="card-body">
              <div class="row mt-4">
                <div class="col-sm-12 col-md-4">
                  <div class="form-group">
                    <label>First name</label>
                    <input v-model="staff.first_name" type="text" class="form-control form-control-lg">
                  </div>
                </div>
                <div class="col-sm-12 col-md-4">
                  <div class="form-group">
                    <label>Last name</label>
                    <input v-model="staff.last_name" type="text" class="form-control form-control-lg">
                  </div>
                </div>
                <div class="col-sm-12 col-md-4">
                  <div class="form-group">
                    <label>Mobile No.</label>
                    <input v-model="staff.contact" type="text" class="form-control form-control-lg">
                  </div>
                </div>
              </div>
              <div class="row mt-4">
                <div class="col-sm-12 col-md-6">
                  <div class="form-group">
                    <label>Email</label>
                    <input v-model="staff.email" type="text" class="form-control form-control-lg">
                  </div>
                </div>
                <div class="col-sm-12 col-md-6">
                  <div class="form-group">
                    <label>Role</label>
                    <select v-model="staff.role" class="form-control form-control-lg">
                      <option value="0">Select role</option>
                      <option value="1">Admin</option>
                      <option value="2">Staff</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="row mt-4">
                <div class="col-sm-12 col-md-6">
                  <div class="form-group">
                    <label>Password</label>
                    <input v-model="staff.password" type="password" class="form-control form-control-lg">
                  </div>
                </div>
                <div class="col-sm-12 col-md-6">
                  <div class="form-group">
                    <label>Status</label>
                    <select v-model="staff.status" class="form-control form-control-lg">
                      <option value="0">Select status</option>
                      <option value="1">Active</option>
                      <option value="2">Inactive</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" @click="closeModal()">Close</button>
          <button type="button" class="btn btn-primary" @click="updateStaff()">Register Staff</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { variable } from '@/var';
  import Swal from 'sweetalert2';
  import axios from 'axios';
  import $ from 'jquery';
  
  export default defineComponent({
    emits: ['closed', 'refresh'],
    props: {
      open: {
        default: false,
        type: Boolean
      },
      staff: {
        default: {},
        type: Object
      }
    },
    data() {
      return {
        confirm_password: ''
      }
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      async updateStaff() {
        await axios.get( variable()['api_main'] + "users_system/update?" + $.param(this.staff)).then( async (response) => {
          if(response.data?.success) {
            Swal.fire({
              title: 'Success',
              text: response.data?.message,
              icon: 'success'
            }).then( async () => {
              this.$emit('refresh');
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
    }
  });

</script>
<style scoped>
  .display {
    display: block;
    background-color: #0a0a0a42;
  }
</style>