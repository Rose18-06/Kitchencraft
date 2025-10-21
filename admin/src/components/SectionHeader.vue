<template>
  <nav
    class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
    id="layout-navbar"
  >
    <div
      class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none"
    >
      <a class="nav-item nav-link px-0 me-xl-4">
        <i class="bx bx-menu bx-sm"></i>
      </a>
    </div>

    <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
      <ul class="navbar-nav flex-row align-items-center ms-auto">
        <li class="nav-item">
          <div
            class="header-notification position-relative me-2"
            @click="() => { $emit('open_notif') }"
          >
            <span
              v-show="notification_count > 0 ? true : false"
              class="position-absolute bg-danger"
              >{{ notification_count }}</span
            >
            <i class="bi bi-bell-fill d-block w-100 cursor-pointer"></i>
          </div>
        </li>

        <li class="nav-item">
          <div class="avatar avatar-online">
            <img
              src="/src/assets/img/avatars/1.png"
              class="w-px-40 h-auto rounded-circle me-3"
            />
          </div>
        </li>

        <li class="nav-item">
          <div class="px-3">
            <p class="p-0 m-0">
              <strong>{{ user?.last_name + ' ' + user?.first_name }}</strong>
            </p>
            <p class="p-0 m-0">Role: {{ user?.role == 1 ? 'Admin' : 'Staff' }}</p>
          </div>
        </li>

        <li class="nav-item">
          <!-- ✅ Updated button color -->
          <button class="btn btn-logout me-3" @click="logoutSystem()">
            Logout
          </button>
        </li>
      </ul>
    </div>
  </nav>
</template>

<script lang="ts">
import { getLocalUser } from '@/assets/ts/localStorage';
import Swal from 'sweetalert2';
import { defineComponent } from 'vue';
import { countNotifications } from '@/assets/ts/notification';
import { notifyCountUnseen } from '@/assets/ts/notificationuser';

export default defineComponent({
  emits: ['open_notif'],
  data() {
    return {
      user: {} as any,
      notification_count: 0
    }
  },
  methods: {
    async logoutSystem() {
      Swal.fire({
        title: 'Confirmation',
        text: 'Logout Undercater Portal?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Logout'
      }).then(async (result) => {
        if (result.isConfirmed) {
          localStorage.clear();
          this.$router.replace('/');
        }
      });
    },
    async recount() {
      await countNotifications().then(async (count1) => {
        await notifyCountUnseen(this.user?.dataid).then(async (count2) => {
          this.notification_count = count1 + count2;
        });
      });
    }
  },
  async mounted() {
    await getLocalUser().then(async (user) => {
      this.user = user;
      await this.recount().then(async () => {
        setInterval(async () => {
          this.recount();
        }, 15000);
      });
    });
  },
});
</script>

<style scoped>
.header-notification {
  width: 40px;
  height: 40px;
}

.header-notification i {
  line-height: 40px;
  text-align: center;
  font-size: 24px;
}

.header-notification span {
  right: 0px;
  padding: 0px 3px;
  border-radius: 6px;
  font-size: 12px;
  color: white;
}

/* ✅ Custom logout button color */
.btn-logout {
  background-color: #e63946;
  color: #fff;
  border: none;
}

.btn-logout:hover {
  background-color: #d62839; /* Slightly darker on hover */
}
</style>
