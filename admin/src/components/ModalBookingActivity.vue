<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-xl" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Booking Activity</h5>
        </div>
        <div class="modal-body bg-light-gray" style="max-height: calc(100vh - 300px);overflow: auto;">
          <div class="row">
            <div class="col-sm-12 col-md-4">
              <swiper :slides-per-view="1" :space-between="0" @swiper="onSwiper">
                <swiper-slide data-role="Event Details" class="swiper-no-swiping">
                  <div class="card">
                    <div class="card-body">
                      <h5 class="text-primary fw-bold">Event Details</h5>
                      <table class="table">
                        <tbody>
                          <tr>
                            <td class="px-0" style="width: 130px;">Event</td>
                            <td class="px-0">: {{ booking?.event?.name }}</td>
                          </tr>
                          <tr>
                            <td class="px-0">Location Type</td>
                            <td class="px-0">: {{ booking?.location?.value }}</td>
                          </tr>
                          <tr>
                            <td class="px-0">Date</td>
                            <td class="px-0">: {{ booking?.header?.event_date }}</td>
                          </tr>
                          <tr>
                            <td class="px-0">Check In</td>
                            <td class="px-0">: {{ booking?.header?.event_start_time }}</td>
                          </tr>
                          <tr>
                            <td class="px-0">Check Out</td>
                            <td class="px-0">: {{ booking?.header?.event_end_time }}</td>
                          </tr>
                          <tr>
                            <td class="px-0">Status</td>
                            <td class="px-0">: {{ booking?.status?.value }}</td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </swiper-slide>
                <swiper-slide data-role="Update Activity" class="swiper-no-swiping">
                  <div class="card">
                    <div class="card-body">
                      <h5 class="text-primary fw-bold">Update Activity</h5>
                      <div class="mb-3">
                        <label>Title</label>
                        <input v-model="form_update.title" type="text" class="form-control form-control-lg">
                      </div>
                      <div class="mb-3">
                        <label>Description</label>
                        <textarea v-model="form_update.description" class="form-control form-control-lg" style="min-height: 150px"></textarea>
                      </div>
                      <div class="mb-3">
                        <label>Status</label>
                        <select v-model="form_update.status" class="form-control form-control-lg">
                          <option value="0">Select status</option>
                          <option value="Pending">Pending</option>
                          <option value="Ongoing">Ongoing</option>
                          <option value="Done">Done</option>
                        </select>
                      </div>
                      <div class="d-flex justify-content-end mb-3">
                        <button class="btn btn-clear-secondary" @click="cancelUpdateTask()">Cancel</button>
                        <button class="btn btn-primary" @click="updateActivity()">Update Activity</button>
                      </div>
                    </div>
                  </div>
                </swiper-slide>
                <swiper-slide data-role="Add Activity" class="swiper-no-swiping">
                  <div class="card">
                    <div class="card-body">
                      <h5 class="text-primary fw-bold">Add Activity</h5>
                      <div class="mb-3">
                        <label>Title</label>
                        <input v-model="form_add.title" type="text" class="form-control form-control-lg">
                      </div>
                      <div class="mb-3">
                        <label>Description</label>
                        <textarea v-model="form_add.description" class="form-control form-control-lg" style="min-height: 150px"></textarea>
                      </div>
                      <div class="mb-3">
                        <label>Status</label>
                        <select v-model="form_add.status" class="form-control form-control-lg">
                          <option value="0">Select status</option>
                          <option value="Pending">Pending</option>
                          <option value="Ongoing">Ongoing</option>
                          <option value="Done">Done</option>
                        </select>
                      </div>
                      <div class="d-flex justify-content-end mb-3">
                        <button class="btn btn-clear-secondary" @click="cancelUpdateTask()">Cancel</button>
                        <button class="btn btn-primary" @click="saveActivity()">Save</button>
                      </div>
                    </div>
                  </div>
                </swiper-slide>
                <swiper-slide data-role="Add Staff" class="swiper-no-swiping">
                  <div class="card">
                    <div class="card-body">
                      <h5 class="text-primary fw-bold">Add Staff</h5>
                      <table class="table">
                        <thead>
                          <tr>
                            <th class="px-0 m-0">Name</th>
                            <th>Role</th>
                            <th style="width: 80px">Add</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr v-for="(st, si) in staff" :key="si">
                            <td class="p-0 m-0">{{ (si + 1) }}. {{ st?.last_name + ' ' + st?.first_name }}</td>
                            <td>{{  st?.role == 1 ? 'Admin':'Staff' }}</td>
                            <td><button class="btn btn-primary btn-sm" @click="saveStaff(st)" >Add</button></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </swiper-slide>
                <swiper-slide data-role="Add Food" class="swiper-no-swiping">
                  <div class="card">
                    <div class="card-body">
                      <h5 class="text-primary fw-bold">Add Food</h5>
                      <table class="table">
                        <thead>
                          <tr>
                            <th class="px-0">Food Name</th>
                            <th style="width: 80px">Add</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr v-for="(food, fi) in booking?.food" :key="fi">
                            <td class="px-0">{{ food?.name }}</td>
                            <td><button class="btn btn-primary btn-sm" @click="saveFood(food)">Add</button></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </swiper-slide>
              </swiper>
            </div>
            <div class="col-sm-12 col-md-8">
              <div class="card">
                <div class="card-body">
                  <div class="d-flex justify-content-start align-items-center py-3">
                    <button class="btn btn-primary me-2" @click="()=>{ swiper.slideTo(2) }" >Add Activity</button>
                    <button class="btn btn-primary me-2" @click="onSwiperAddStaff()" >Add Staff</button>
                    <button class="btn btn-primary me-2" @click="()=>{ swiper.slideTo(4) }" >Add Food</button>
                  </div>
                  <div class="table-responsive text-nowrap">
                    <table class="table">
                      <thead>
                        <tr>
                          <th style="max-width: calc(100% - 200px)">Task</th>
                          <th style="width: 100px;">Update</th>
                          <th style="width: 100px;">Delete</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr v-for="(activity, ai) in activities" :key="ai">
                          <td>
                            <div >
                              <p class="p-0 m-0"><strong><small class="text-primary">{{ activity?.title }}</small> | <small class="text-warning">{{ activity?.status }}</small></strong></p>
                              <p class="p-0 m-0 text-wrap"><small>{{ activity?.description }}</small></p>
                            </div>
                          </td>
                          <td><button class="btn btn-primary btn-sm" @click="updateActivitySwipe(activity)">Update</button></td>
                          <td><button class="btn btn-danger btn-sm" @click="deleteActivity(activity)" >Delete</button></td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" @click="closeModal()">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { variable } from '@/var';
  import { Swiper, SwiperSlide } from 'swiper/vue';
  import { notifyAllActivity } from '@/assets/ts/notificationuser';
  import axios from 'axios';
  import Swal from 'sweetalert2';
  import $ from 'jquery';

  export default defineComponent({
    emits: ['closed', 'refresh'],
    props: {
      open: {
        default: false,
        type: Boolean
      },
      booking: {
        default: {},
        type: Object
      }
    },
    components: { Swiper, SwiperSlide },
    data() {
      return {
        swiper: {} as any,
        activities: {} as any,
        form_update: {
          dataid: '',
          title: '',
          description: '',
          status: '0'
        },
        form_add: {
          booking_dataid: '',
          title: '',
          description: '',
          status: '0'
        },
        staff: {} as any
      }
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      async onSwiperAddStaff() {
        this.swiper.slideTo(3);
        await axios.get( variable()['api_main'] + "users_system/fetchAll" ).then( async (staff) => {
          this.staff = staff.data;
        });
      },
      onSwiper(event: any) {
        this.swiper = event;
      },
      cancelUpdateTask() {
        this.swiper.slideTo(0);
      },
      updateActivitySwipe(activity: any) {
        this.form_update.dataid           = activity?.dataid;
        this.form_update.title            = activity?.title;
        this.form_update.description      = activity?.description;
        this.form_update.status           = activity?.status;
        this.swiper.slideTo(1);
      },
      async updateActivity() {
        await axios.get( variable()['api_main'] + "booking_activity/update?" + $.param(this.form_update) ).then( async (response) => {
          if(response.data?.success) {
            await notifyAllActivity(this.form_update.title, this.form_update.description, this.booking?.header?.dataid, "Activity titled " + this.form_update.title + " was recently updated. Check it out for more details.").then( async () => {
              Swal.fire({
                title: 'Updated!',
                text: response.data?.message,
                icon: 'success'
              }).then( async () => {
                this.form_update.dataid     = '';
                this.form_update.title       = '';
                this.form_update.description = '';
                this.form_update.status      = '0';
                await this.fetchActivities();
              });
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
      async saveFood(event: any) {
        var args = {
          booking_dataid: this.booking?.header?.dataid,
          title: 'FOOD: ' + event?.name,
          description: event?.description,
          status: 'Pending'
        };
        await axios.get( variable()['api_main'] + "booking_activity/add?" + $.param(args)).then( async (response) => {
          if(response.data?.success) {
            await notifyAllActivity(args.title, args.description, this.booking?.header?.dataid, event?.name + ' is added to the booking of customer named ' + this.booking?.header?.first_name +  ' for location ' + this.booking?.header?.event_location).then( async () => {
              Swal.fire({
                title: 'Added!',
                text: response.data?.message,
                icon: 'success'
              }).then( async () => {
                this.form_add.title       = '';
                this.form_add.description = '';
                this.form_add.status      = '0';
                await this.fetchActivities();
              });
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
      async saveStaff(event: any) {
        Swal.fire({
          title: "Task Description",
          input: "text",
          inputAttributes: {
            autocapitalize: "off"
          },
          showCancelButton: true,
          confirmButtonText: "Assign Task",
        }).then( async (result) => {
          if (result.isConfirmed) {
            var args = {
              booking_dataid: this.booking?.header?.dataid,
              title: 'STAFF: ' + event?.first_name + ' ' + event?.last_name,
              description: result.value,
              status: 'Pending',
              user_dataid: event?.dataid
            };
            await axios.get( variable()['api_main'] + "booking_activity/sendTask?" + $.param(args) ).then( async () => {
              await axios.get( variable()['api_main'] + "booking_activity/add?" + $.param(args)).then( async (response) => {
                if(response.data?.success) {
                  await notifyAllActivity(args.title, args.description, this.booking?.header?.dataid, 'Staff ' + event?.first_name + ' ' + event?.last_name + ' was added as collaborator for the booking of customer named ' + this.booking?.header?.first_name +  ' for location ' + this.booking?.header?.event_location).then( async () => {
                    Swal.fire({
                      title: 'Added!',
                      text: response.data?.message,
                      icon: 'success'
                    }).then( async () => {
                      this.form_add.title       = '';
                      this.form_add.description = '';
                      this.form_add.status      = '0';
                      await this.fetchActivities();
                    });
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
            });
          }
        });
      },
      async saveActivity() {
        await axios.get( variable()['api_main'] + "booking_activity/add?" + $.param(this.form_add)).then( async (response) => {
          if(response.data?.success) {
            await notifyAllActivity(this.form_add.title, this.form_add.description, this.booking?.header?.dataid, "New activity was added titled " + this.form_add.title + " check it out for more details").then( async () => {
              Swal.fire({
                title: 'Added!',
                text: response.data?.message,
                icon: 'success'
              }).then( async () => {
                this.form_add.title       = '';
                this.form_add.description = '';
                this.form_add.status      = '0';
                await this.fetchActivities();
              });
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
      async deleteActivity(activity: any) {
        Swal.fire({
          title: "Confirmation",
          text: "Delete " + activity?.title + "?",
          showCancelButton: true,
          confirmButtonText: "Delete",
          icon: "question"
        }).then( async (result) => {
          if (result.isConfirmed) {
            await axios.get( variable()['api_main'] + "booking_activity/delete?dataid=" + activity?.dataid ).then( async (response) => {
              if(response.data?.success) {
                await notifyAllActivity(activity?.title, activity?.activity, this.booking?.header?.dataid, "Activity title " + activity?.title + " was deleted. Check it out for more details.").then( async () => {
                  Swal.fire({
                    title: 'Success',
                    text: response.data?.message,
                    icon: 'success'
                  }).then( async () => {
                    await this.fetchActivities();
                  });
                });
              }
              else {
                Swal.fire({
                  title: 'Warning',
                  text: response.data?.message,
                  icon: 'warning'
                })
              }
            });
          }
        });
      },
      async fetchActivities() {
        await axios.get( variable()['api_main'] + "booking_activity/fetchAll?booking_dataid=" + this.booking?.header?.dataid ).then( async (response) => {
          this.activities = response.data;
        });
      }
    },
    watch: {
      open: function () {
        if(this.open) {
          this.fetchActivities().then( async () => {
            this.form_add.booking_dataid = this.booking?.header?.dataid;
            console.log("Data:", this.$data);
            console.log("Booking:", toRaw(this.booking));
          });
        }
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