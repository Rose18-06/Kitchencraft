<template>
<div class="container-xxl">
      <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner">
          <div class="card">
            <div class="card-body">

              <div class="py-4">
                <h1 class="text-center p-0 m-0 text-danger">Undercater</h1>
                <h4 class="text-center p-0 m-0">Welcome back 👋</h4>
              </div>
      
              <div id="formAuthentication" class="mb-3">
                <div class="mb-3">
                  <label for="email" class="form-label">Email</label>
                  <input v-model="form.email" type="text" class="form-control form-control-lg" id="email" name="email-username" autofocus/>
                </div>
                <div class="mb-3 form-password-toggle">
                  <label class="form-label" for="password">Password</label>
                  <input v-model="form.password" type="password" id="password" class="form-control form-control-lg" name="password"/>
                </div>
                <div class="mb-3">
                  <button class="btn btn-primary d-grid w-100" @click="login()">Sign in</button>
                </div>
            </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</template>
<script lang="ts">

  import { variable } from '@/var';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { defineComponent } from 'vue';
  import axios from 'axios';
  import $ from 'jquery';
  import ls from 'localstorage-slim';
  import Swal from 'sweetalert2';
  
  export default defineComponent({
    name: "LoginPage",
    data() {
      return {
        loading: false,
        form: {
          email: '',
          password: ''
        }
      }
    },
    methods: {
      async login() {
        await axios.get( variable()['api_main'] + "users_system/login?" + $.param(this.form) ).then( async (response) => {
          this.loading = false;
          if(response.data?.success) {
            ls.set('user-admin', response.data?.profile, { encrypt: true });
            this.$router.push('/dashboard');
          }
          else {
            Swal.fire({
              title: 'Warning',
              text: response.data?.message,
              icon: 'warning'
            }).then( async () => {
              this.form.email     = '';
              this.form.password  = '';
            });
          }
        });
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.$router.replace('/dashboard');
        }
      });
    },
  });

</script>