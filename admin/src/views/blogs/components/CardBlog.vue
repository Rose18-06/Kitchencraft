<template>
  <div class="card my-4">
    <img class="blog-cover-photo w-100 bg-dark" :src="blog?.photo ? blog?.fullpath : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK9aVGeIwDc_9na_hcvbjcH4oqbm-nWiMs-g&s' "/>
    <div class="card-body">
      <h3 class="text-primary">{{ blog?.title }}</h3>
      <div>
        <h6 class="p-0 m-0 fw-bold">Date Posted:</h6>
        <p class="p-0 m-0"><small>{{ blog?.created_at }}</small></p>
      </div>
      <p class="blog-description mt-4">{{ blog?.description }}</p>
      <div class="d-flex justify-content-end align-items-center">
        <button class="btn btn-primary w-50 me-3" @click="editModal(blog)" >Edit</button>
        <button class="btn btn-danger w-50" @click="deleteBlog()" >Delete</button>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { variable } from '@/var';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import axios from 'axios';
  import Swal from 'sweetalert2';

  export default defineComponent({
    emits: ['edit', 'refresh'],
    props: ['blog'],
    methods: {
      async deleteBlog() {
        await getLocalUser().then( async (user) => {
          if(user?.role == 1) {
            Swal.fire({
              title: 'Confirmation',
              text: 'Delete ' + this.blog?.title + '?',
              icon: 'question',
              showCancelButton: true,
              confirmButtonText: 'Delete',
            }).then( async (result) => {
              if(result.isConfirmed) {
                await axios.get( variable()['api_main'] + "blog/delete?dataid=" + this.blog?.dataid ).then( async (response) => {
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
      editModal(blog: any) {
        this.$emit('edit', { data: blog });
      }
    }
  });

</script>
<style scoped>
  p.blog-description {
    display: -webkit-box;
    overflow : hidden;
    text-overflow: ellipsis;
    -webkit-line-clamp: 5;
    -webkit-box-orient: vertical; 
  }
  img.blog-cover-photo {
    height: 250px;
    object-fit: cover;
    object-position: center;
  }
</style>