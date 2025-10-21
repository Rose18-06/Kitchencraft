<template>
  <div>
    <SectionHeader/>
    <main class="main">
      <div class="content">
        <div class="container">
          <div class="py-5 my-5">
            <div class="row justify-content-center">
              <div class="col-md-5">
                <div class="card shadow-card">
                  <div class="card-header text-center">
                    <h5 class="text-center"><strong>Login</strong></h5>
                  </div>
                  <div class="card-body py-5">
                    <div>
                      <div class="mb-3">
                        <label for="email" class="form-label">Email address</label>
                        <input v-model="form.email" type="email" class="form-control form-control-lg" id="email" name="email" required>
                      </div>
                      <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input v-model="form.password" type="password" class="form-control form-control-lg" id="password" name="password" required>
                      </div>
                      <div class="d-flex justify-content-end">
                        <!-- Use btn-login class -->
                        <button class="btn btn-login w-50" @click="login()" :disabled="loading">
                          {{ loading ? 'Please wait...' : 'Login' }}
                        </button>
                      </div>
                    </div>
                  </div>
                  <div class="card-footer text-center">
                    <small>
                      Don't have an account? 
                      <router-link to="/registration">Register here</router-link>
                    </small>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <SectionFooter/>
    </main>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { variable } from '@/var';
import SectionHeader from "@/components/SectionHeader.vue";
import SectionFooter from "@/components/SectionFooter.vue";
import $ from 'jquery';
import axios from 'axios';
import Swal from 'sweetalert2';
import ls from 'localstorage-slim';
import { getLocalUser } from '@/assets/ts/localStorage';

export default defineComponent({
  name: "LoginPage",
  components: { SectionFooter, SectionHeader },
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
      this.loading = true;
      await axios.get(variable()['api_main'] + "users_customer/login?" + $.param(this.form)).then(async (response) => {
        this.loading = false;
        if(response.data?.success) {
          ls.set('user', response.data?.profile, { encrypt: true });
          this.$router.push('/events');
        } else {
          Swal.fire({
            title: 'Warning',
            text: response.data?.message,
            icon: 'warning'
          }).then(async () => {
            this.form.email = '';
            this.form.password = '';
          });
        }
      });
    }
  },
  async mounted() {
    await getLocalUser().then(async (user) => {
      console.log(user);
    });
  },
});
</script>

<style scoped>
/* 🔴 Red box shadow for login card */
.shadow-card {
  box-shadow: 0 4px 12px rgba(230, 57, 70, 0.45) !important;
  border-radius: 0.5rem;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.shadow-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 6px 16px rgba(230, 57, 70, 0.55) !important;
}

/* ✨ Input box shadow only on focus */
.form-control {
  border: 1px solid #ccc; /* normal border color */
  transition: box-shadow 0.2s ease, border-color 0.2s ease;
}

.form-control:focus {
  box-shadow: 0 1px 5px rgba(230, 57, 70, 0.55);
  border-color: #e63946;
  outline: none;
}

/* 🔴 Custom login button color */
.btn-login {
  background-color: #e63946;
  border-color: #e63946;
  transition: background-color 0.2s ease, border-color 0.2s ease, transform 0.2s ease;
  color: #fff;
}

.btn-login:hover {
  background-color: #d42e3f;
  border-color: #d42e3f;
  transform: translateY(-2px); /* slight lift on hover */
}
</style>
