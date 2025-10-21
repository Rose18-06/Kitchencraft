<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Notification</h5>
        </div>
        <div class="modal-body bg-light-gray" style="max-height: calc(100vh - 300px);overflow: auto;">
          <div class="card">
            <div class="card-body p-0">
              <ul class="nav nav-tabs w-100">
                <li class="nav-item w-50">
                  <button class="nav-link fs-5" :class="{ 'active': menu_index == 0 ? true : false }" @click="onSwipeMenu(0)" >
                    <i class="bi bi-bell-fill me-2"></i>
                    <span>General</span>
                  </button>
                </li>
                <li class="nav-item w-50">
                  <button class="nav-link fs-5" :class="{ 'active': menu_index == 1 ? true : false }" @click="onSwipeMenu(1)">
                    <i class="bi bi-person-fill-check me-2"></i>
                    <span>Personal</span>
                  </button>
                </li>
              </ul>
              <swiper :slides-per-view="1" :space-between="50" @swiper="onSwiper">
                <swiper-slide class="swiper-no-swiping">
                  <table class="table">
                    <tbody>
                      <tr v-for="(notif, ni) in notification?.data" :key="ni">
                        <td style="padding-left: 20px;"><i class="bi bi-bell-fill fs-3 text-primary"></i></td>
                        <td>
                          <div class="py-1">
                            <p class="p-0 m-0">
                              <small class="text-dark"><strong>{{ notif?.title }}</strong> | {{ notif?.created_at }}</small><br/>
                              <small>{{ notif?.activity }}</small>
                            </p>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </swiper-slide>
                <swiper-slide class="swiper-no-swiping">
                  <table class="table">
                    <tbody>
                      <tr v-for="(notifAct, ni) in activities?.data" :key="ni">
                        <td style="padding-left: 20px;width: 50px;"><i class="bi bi-bell-fill fs-3 text-primary"></i></td>
                        <td>
                          <div class="px-3 py-1">
                            <p class="p-0 m-0">
                              <small class="text-dark">
                                <span class="text-dark">Title: {{ notifAct?.title }} | {{ notifAct?.created_at }}</span><br/>
                                <span class="text-secondary">Description: {{ notifAct?.description }}</span><br/>
                                <span class="text-primary">See email for more details</span>
                              </small>
                            </p>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </swiper-slide>
              </swiper>
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
  import { fetchPaginateNotifications, seenAllNotifications } from '@/assets/ts/notification';
  import { notifyFetchPaginate, notifySeenAll } from '@/assets/ts/notificationuser';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { Swiper, SwiperSlide } from 'swiper/vue';

  export default defineComponent({
    emits: ['closed', 'refresh'],
    props: {
      open: {
        default: false,
        type: Boolean
      }
    },
    components: { Swiper, SwiperSlide },
    data() {
      return {
        user: {} as any,
        swiper: {} as any,
        notification: {} as any,
        activities: {} as any,
        menu_index: 0
      }
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      onSwiper(event: any) {
        this.swiper = event;
      },
      async onSwipeMenu(index: number) {
        this.menu_index = index;
        this.user       = await getLocalUser();
        if(index == 0) {
          await this.onFetchNotifications(1).then( async () => {
            this.swiper.slideTo(index);
          });
        }
        else {
          await this.onNotifyFetchPaginate(1).then( async () => {
            this.swiper.slideTo(index);
            await notifySeenAll(this.user?.dataid).then( async (seen) => {
              console.log("Seen:", toRaw(seen));
            });
          });
        }
      },
      async onFetchNotifications(page: number) {
        await fetchPaginateNotifications(1).then( async (notification) => {
          this.notification = notification;
        });
      },
      async onNotifyFetchPaginate(page: number) {
        await notifyFetchPaginate(this.user?.dataid, page).then( async (activities) => {
          this.activities = activities;
        });
      }
    },
    watch: {
      open: async function () {
        if(this.open) {
          this.user = await getLocalUser();
          await this.onFetchNotifications(1).then( async () => {
            await this.onNotifyFetchPaginate(1).then( async () => {
              await seenAllNotifications().then( async () => {
                console.log(toRaw(this.$data));
              });
            }); 
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
  .table tr td {
    padding: 0px;
  }
</style>