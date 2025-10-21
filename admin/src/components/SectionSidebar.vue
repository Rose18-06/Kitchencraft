<template>
  <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
    <div class="app-brand demo">
      <a class="app-brand-link">
        <img class="w-100" src="/src/assets/img/logo.png" />
      </a>
      <a class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
        <i class="bx bx-chevron-left bx-sm align-middle"></i>
      </a>
    </div>
    <div class="menu-inner-shadow"></div>
    <ul class="menu-inner py-1">
      <li class="menu-header small text-uppercase">
        <span class="menu-header-text">MANAGE RESTAURANT</span>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'dashboard' ? true : false }">
        <router-link class="menu-link" to="/dashboard">
          <i class="menu-icon bi bi-speedometer"></i>
          <div data-i18n="Analytics">Dashboard</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'booking_calendar' ? true : false }">
        <router-link class="menu-link" to="/booking-calendar">
          <i class="menu-icon bi bi-calendar-day"></i>
          <div data-i18n="Analytics">Booking Calendar</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'booking_details' ? true : false }">
        <router-link class="menu-link" to="/booking-details">
          <i class="menu-icon bi bi-bookmark-heart-fill"></i>
          <div data-i18n="Analytics">Booking Details</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'locations' ? true : false }">
        <router-link class="menu-link" to="/locations">
          <i class="menu-icon bi bi-building-fill-check"></i>
          <div data-i18n="Analytics">Locations</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'events' ? true : false }">
        <router-link class="menu-link" to="/events">
          <i class="menu-icon bi bi-person-lines-fill"></i>
          <div data-i18n="Analytics">Events</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'theme' ? true : false }">
        <router-link class="menu-link" to="/theme">
          <i class="menu-icon bi bi-border-style"></i>
          <div data-i18n="Analytics">Theme</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'blogs' ? true : false }">
        <router-link class="menu-link" to="/blogs">
          <i class="menu-icon bi bi-substack"></i>
          <div data-i18n="Analytics">Blogs</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'menu' ? true : false }">
        <router-link class="menu-link" to="/menu">
          <i class="menu-icon bi bi-menu-button-fill"></i>
          <div data-i18n="Analytics">Menu</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'menu_category' ? true : false }">
        <router-link class="menu-link" to="/menu-category">
          <i class="menu-icon bi bi-menu-button-wide-fill"></i>
          <div data-i18n="Analytics">Menu Category</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'inventory' ? true : false }">
        <router-link class="menu-link" to="/inventory">
          <i class="menu-icon bi bi-diagram-3-fill"></i>
          <div data-i18n="Analytics">Inventory</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'add_ons' ? true : false }">
        <router-link class="menu-link" to="/add-ons">
          <i class="menu-icon bi bi-diagram-2"></i>
          <div data-i18n="Analytics">Add-ons</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'marketing' ? true : false }">
        <router-link class="menu-link" to="/marketing">
          <i class="menu-icon bi bi-file-spreadsheet"></i>
          <div data-i18n="Analytics">Marketing</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'reports' ? true : false }">
        <router-link class="menu-link" to="/reports">
          <i class="menu-icon bi bi-file-earmark-spreadsheet-fill"></i>
          <div data-i18n="Analytics">Reports</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'activity-logs' ? true : false }">
        <router-link class="menu-link" to="/activity-logs">
          <i class="menu-icon bi bi-file-earmark-spreadsheet-fill"></i>
          <div data-i18n="Analytics">Activity Logs</div>
        </router-link>
      </li>
      <li class="menu-header small text-uppercase">
        <span class="menu-header-text">MANAGE USER</span>
      </li>
      <li 
        class="menu-item" 
        :class="{ 'active': $route.name == 'staff' ? true : false }"
        v-show="user?.role == 1 ? true: false"
        >
        <router-link class="menu-link" to="/staff">
          <i class="menu-icon bi bi-people"></i>
          <div data-i18n="Analytics">Staff</div>
        </router-link>
      </li>
      <li class="menu-item" :class="{ 'active': $route.name == 'inquiry' ? true : false }">
        <router-link class="menu-link" to="/inquiry">
          <i class="menu-icon bi bi-chat-left-dots-fill"></i>
          <div data-i18n="Analytics">Inquiry</div>
        </router-link>
      </li>   
    </ul>
  </aside>
</template>
<script lang="ts">

  import { getLocalUser } from '@/assets/ts/localStorage';
  import { defineComponent } from 'vue';

  export default defineComponent({
    data() {
      return {
        user: {} as any
      }
    },
    async mounted() {
      await getLocalUser().then( async (user) => {
        this.user = user;
      });
    },
  });

</script>