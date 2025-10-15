import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('../views/home/index.vue'),
    },
    {
      path: '/about',
      name: 'about',
      component: () => import('../views/about/index.vue')
    },
    {
      path: '/contact',
      name: 'contact',
      component: () => import('../views/contact/index.vue')
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('../views/login/index.vue')
    },
    {
      path: '/registration',
      name: 'registration',
      component: () => import('../views/registration/index.vue')
    },
    {
      path: '/events',
      name: 'events',
      component: () => import('../views/events/index.vue')
    },
    {
      path: '/events-booking',
      name: 'events_booking',
      component: () => import('../views/events-booking/index.vue')
    },
    {
      path: '/events-booking-placed',
      name: 'events-booking-placed',
      component: () => import('../views/events-booking-placed/index.vue')
    },
    {
      path: '/registration-verify',
      name: 'registration-verify',
      component: () => import('../views/registration-verify/index.vue')
    },
    {
      path: '/registration-verified/:token',
      name: 'registration_verified',
      component: () => import('../views/registration-verified/index.vue')
    },
    {
      path: '/my-account',
      name: 'my_account',
      component: () => import('../views/my-account/index.vue')
    },
    {
      path: '/agreement/:booking_id',
      name: 'agreement',
      component: () => import('../views/agreement/index.vue')
    }
  ]
})

export default router
