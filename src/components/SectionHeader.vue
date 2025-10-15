<template>
  <header id="header" class="header d-flex align-items-center position-relative" style="background-color: #1e1e1e;">
    <div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">
      <a href="index.html" class="logo d-flex align-items-center">
        <img src="/src/assets/image/kitchencraft-logo.png" alt="AgriCulture">
      </a>
      <nav id="navmenu" class="navmenu">
        <ul>
          <li><router-link :class="{ 'active': $route.name == 'home' ? true : false }" to="/">Home</router-link></li>
          <li><router-link :class="{ 'active': $route.name == 'about' ? true : false }" to="/about">About Us</router-link></li>
          <li><router-link :class="{ 'active': $route.name == 'contact' ? true : false }" to="/contact">Contact Us</router-link></li>
          <li v-show="authenticated"><router-link :class="{ 'active': $route.name == 'my_account' ? true : false }" to="/my-account">My Account</router-link></li>
          
          <li v-show="!authenticated"><router-link :class="{ 'active': $route.name == 'login' ? true : false }" to="/login">Login</router-link></li>
          <li v-show="!authenticated"><router-link :class="{ 'active': $route.name == 'registration' ? true : false }" to="/registration">Register</router-link></li>
          <li><button class="btn btn-danger rounded-5 px-5 me-2" @click="()=>{ $router.push('/events') }">Book</button></li>
          <li v-show="authenticated"><button class="btn btn-secondary rounded-5 px-5" @click="logoutClient()">Logout</button></li>
        </ul>
        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
      </nav>
    </div>
  </header>
</template>
<script lang="ts">

  import { getLocalUser } from '@/assets/ts/localStorage';
import Swal from 'sweetalert2';
  import { defineComponent } from 'vue';

  export default defineComponent({
    name: "SectionHeader",
    data() {
      return {
        authenticated: false
      }
    },
    methods: {
      async logoutClient() {
        Swal.fire({
          title: 'Confirmation',
          text: 'Logout account?',
          icon: 'question',
          showCancelButton: true,
          confirmButtonText: 'Logout'
        }).then( async (result) => {
          if(result.isConfirmed) {
            localStorage.clear();
            this.$router.replace('/');
            setTimeout( () => {
              window.location.reload();
            },800);
          }
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (user) => {
        if(user) {
          this.authenticated = true;
        }
        else {
          this.authenticated = false;
        }
      });
    },
  });

</script>
