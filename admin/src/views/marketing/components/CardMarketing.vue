<template>
  <div class="card my-4">
    <div v-if="(marketing?.photo).includes('mp4')">
      <video class="marketing-cover-photo w-100 bg-dark" :src="marketing?.photo ? marketing?.fullpath : ''" controls></video>
    </div>
    <div v-else>
      <img class="marketing-cover-photo w-100 bg-dark" :src="marketing?.photo ? marketing?.fullpath : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK9aVGeIwDc_9na_hcvbjcH4oqbm-nWiMs-g&s' "/>
    </div>
    <div class="card-body">
      <h3 class="text-primary">{{ marketing?.title }}</h3>
      <div>
        <h6 class="p-0 m-0 fw-bold">Date Posted:</h6>
        <p class="p-0 m-0"><small>{{ marketing?.created_at }}</small></p>
      </div>
      <p class="marketing-description mt-4">{{ marketing?.content }}</p>
      <div class="d-flex justify-content-end align-items-center">
        <button class="btn btn-primary w-50 me-3" @click="editModal(marketing)" >Edit</button>
        <button class="btn btn-danger w-50" @click="deleteMarketing()" >Delete</button>
      </div>
      <button class="btn btn-success w-100 mt-3" @click="sendEmailMarketing(marketing?.dataid)" >Send Email Marketing</button>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { variable } from '@/var';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import axios from 'axios';
  import Swal from 'sweetalert2';
  import { data } from 'jquery';

  export default defineComponent({
    emits: ['edit', 'refresh'],
    props: ['marketing'],
    data() {
      return {
        timerInterval: 0
      }
    },
    methods: {
      async deleteMarketing() {
        await getLocalUser().then( async (user) => {
          if(user?.role == 1) {
            Swal.fire({
            title: 'Confirmation',
            text: 'Delete ' + this.marketing?.title + '?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Delete',
          }).then( async (result) => {
            if(result.isConfirmed) {
              await axios.get( variable()['api_main'] + "marketing/delete?dataid=" + this.marketing?.dataid ).then( async (response) => {
                if(response.data?.success) {
                  Swal.fire({
                    title: 'Success',
                    text: response.data?.message,
                    icon: 'success'
                  }).then( async () => {
                    this.$emit('refresh');
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
            }
          });
          }
          else {
            Swal.fire({
              title: 'Action denied',
              text: 'Only administrator level has permission to delete',
              icon: 'error'
            });
          }
        }); 
      },
      editModal(marketing: any) {
        this.$emit('edit', { data: marketing });
      },
      async sendEmailMarketing(dataid: number) {
        Swal.fire({
          title: 'Confirmation',
          text: 'Send as email marketing?',
          showCancelButton: true,
          confirmButtonText: 'Send',
          icon: 'question'
        }).then( async (result) => {
          if(result.isConfirmed) {
            Swal.fire({
                title: "Sending...",
                html: "Please wait while sending email to all customers",
                timer: 12000,
                timerProgressBar: true,
                didOpen: async () => {
                  Swal.showLoading();
                  await axios.get( variable()['api_main'] + "marketing/sendMarketing?dataid=" + dataid ).then( async (response) => {
                    Swal.close();
                    
                  });
                },
                willClose: () => {
                  clearInterval(this.timerInterval);
                }
            }).then((result) => {
              Swal.fire({
                title: 'Email sent',
                icon: 'success'
              });
            });
          };
        });
      }
    }
  });

</script>
<style scoped>
  p.marketing-description {
    display: -webkit-box;
    overflow : hidden;
    text-overflow: ellipsis;
    -webkit-box-orient: vertical; 
  }
  img.marketing-cover-photo,
  video.marketing-cover-photo {
    height: 250px;
    object-fit: cover;
    object-position: center;
  }
</style>