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
                    <h5 class="text-center"><strong>Create Account</strong></h5>
                  </div>
                  <div class="card-body py-5">
                    <div>
                      <div class="form-group row mb-3">
                        <label class="col-sm-4 col-form-label">First name</label>
                        <div class="col-sm-8">
                          <input v-model="form.firstname" type="text" class="form-control form-control-lg" @keyup="()=>{ form.firstname == '' ? validate.firstname = true : validate.firstname = false; }">
                          <p v-show="validate.firstname" class="p-0 m-0 text-danger"><small>Input fields required</small></p>
                        </div>
                      </div>

                      <div class="form-group row mb-3">
                        <label class="col-sm-4 col-form-label">Last name</label>
                        <div class="col-sm-8">
                          <input v-model="form.lastname" type="text" class="form-control form-control-lg" @keyup="()=>{ form.lastname == '' ? validate.lastname = true : validate.lastname = false; }" >
                          <p v-show="validate.lastname" class="p-0 m-0 text-danger"><small>Input fields required</small></p>
                        </div>
                      </div>

                      <div class="form-group row mb-3">
                        <label class="col-sm-4 col-form-label">Email address</label>
                        <div class="col-sm-8">
                          <input v-model="form.email" type="email" class="form-control form-control-lg" @keyup="()=>{ form.email == '' ? validate.email = true : validate.email = false; }">
                          <p v-show="validate.email" class="p-0 m-0 text-danger"><small>Input fields required</small></p>
                        </div>
                      </div>

                      <div class="form-group row mb-3">
                        <label class="col-sm-4 col-form-label">Mobile Number</label>
                        <div class="col-sm-8">
                          <div class="input-group">
                            <div class="input-group-prepend">
                              <div class="input-group-text">+63</div>
                            </div>
                            <input v-model="form.contact" type="text" maxlength="10" class="form-control" @keyup="()=>{ form.contact.length < 10 ? validate.contact = true : validate.contact = false; }" >
                          </div>
                          <p v-show="validate.contact" class="p-0 m-0 text-danger"><small>Invalid Mobile Number</small></p>
                        </div>
                      </div>

                      <div class="form-group row mb-3">
                        <label class="col-sm-4 col-form-label">Password</label>
                        <div class="col-sm-8">
                          <input v-model="form.password" type="password" class="form-control form-control-lg" @keyup="()=>{ form.password == '' ? validate.password = true : validate.password = false; }">
                          <p v-show="validate.password" class="p-0 m-0 text-danger"><small>Input fields required</small></p>
                        </div>
                      </div>

                      <div class="form-group row mb-3">
                        <label class="col-sm-4 col-form-label">Confirm Password</label>
                        <div class="col-sm-8">
                          <input v-model="form.confirm_password" type="password" class="form-control form-control-lg" @keyup="()=>{ (form.confirm_password == '' || form.password !== form.confirm_password ) ? validate.confirm_password = true : validate.confirm_password = false; }">
                          <p v-show="validate.confirm_password" class="p-0 m-0 text-danger"><small>Password not match</small></p>
                        </div>
                      </div>

                      <div class="d-flex justify-content-end">
                        <button class="btn btn-register w-50" @click="register()" :disabled="loading">
                          {{ loading ? 'Please wait...' : 'Create Account' }}
                        </button>
                      </div>
                    </div>
                  </div>
                  <div class="card-footer text-center">
                    <small>Already have an account? 
                      <router-link to="/login">Login here</router-link>
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
import axios from 'axios';
import $ from 'jquery';
import Swal from 'sweetalert2';

export default defineComponent({
  name: "RegisterPage",
  components: { SectionFooter, SectionHeader },
  data() {
    return {
      loading: false,
      form: {
        firstname: '',
        lastname: '',
        email: '',
        password: '',
        contact: '',
        confirm_password: ''
      },
      validate: {
        firstname: false,
        lastname: false,
        email: false,
        password: false,
        contact: false,
        confirm_password: false
      }
    }
  },
  methods: {
    async register() {
      this.loading = true;
      await axios.get(variable()['api_main'] + "users_customer/register?" + $.param(this.form)).then(async (response) => {
        this.loading = false;
        if(response.data?.success) {
          Swal.fire({
            title: 'Success',
            text: '',
            icon: 'success'
          }).then(() => {
            this.form.firstname = '';
            this.form.lastname = '';
            this.form.email = '';
            this.form.password = '';
            this.form.confirm_password = '';
            this.form.contact = '';
            this.$router.replace('/registration-verify');
          });
        }
      });
    }
  }
});
</script>

<style scoped>
/* 🔴 Red box shadow for registration card */
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
  border: 1px solid #ccc;
  transition: box-shadow 0.2s ease, border-color 0.2s ease;
}

.form-control:focus {
  box-shadow: 0 1px 5px #e63946;
  border-color: #e63946;
  outline: none;
}

/* 🔴 Custom register button color */
.btn-register {
  background-color: #e63946;
  border-color: #e63946;
  transition: background-color 0.2s ease, border-color 0.2s ease, transform 0.2s ease;
  color: #fff;
}

.btn-register:hover {
  background-color: #d42e3f;
  border-color: #d42e3f;
  transform: translateY(-2px);
}
</style>
