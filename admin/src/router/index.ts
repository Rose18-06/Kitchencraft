import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'login',
      component: () => import('@/views/login/index.vue'),
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: () => import('@/views/dashboard/index.vue'),
    },
    {
      path: '/account',
      name: 'account',
      component: () => import('@/views/account/index.vue'),
    },
    {
      path: '/add-ons',
      name: 'add_ons',
      component: () => import('@/views/add-ons/index.vue'),
    },
    {
      path: '/blogs',
      name: 'blogs',
      component: () => import('@/views/blogs/index.vue'),
    },
    {
      path: '/booking-calendar',
      name: 'booking_calendar',
      component: () => import('@/views/booking-calendar/index.vue'),
    },
    {
      path: '/booking-details',
      name: 'booking_details',
      component: () => import('@/views/booking-details/index.vue'),
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: () => import('@/views/dashboard/index.vue'),
    },
    {
      path: '/events',
      name: 'events',
      component: () => import('@/views/events/index.vue'),
    },
    {
      path: '/inquiry',
      name: 'inquiry',
      component: () => import('@/views/inquiry/index.vue'),
    },
    {
      path: '/inventory',
      name: 'inventory',
      component: () => import('@/views/inventory/index.vue'),
    },
    {
      path: '/marketing',
      name: 'marketing',
      component: () => import('@/views/marketing/index.vue'),
    },
    {
      path: '/menu',
      name: 'menu',
      component: () => import('@/views/menu/index.vue'),
    },
    {
      path: '/menu-category',
      name: 'menu_category',
      component: () => import('@/views/menu-category/index.vue'),
    },
    {
      path: '/reports',
      name: 'reports',
      component: () => import('@/views/reports/index.vue'),
    },
    {
      path: '/staff',
      name: 'staff',
      component: () => import('@/views/staff/index.vue'),
    },
    {
      path: '/theme',
      name: 'theme',
      component: () => import('@/views/theme/index.vue'),
    },
    {
      path: '/activity-logs',
      name: 'activity_logs',
      component: () => import('../views/activity-logs/index.vue')
    },
    {
      path: '/locations',
      name: 'locations',
      component: () => import('../views/locations/index.vue')
    },
  ],
})

export default router
