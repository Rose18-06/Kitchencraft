<template>
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <SectionSidebar/>
      <div class="layout-page">
        <SectionHeader @open_notif="()=>{ $emit('open_notif') }"/>
        <div class="content-wrapper">
          <div class="container-xxl flex-grow-1 container-p-y">
            <div class="d-flex justify-content-between align-items-center py-3">
              <h4 class="fw-bold">Manage Blog</h4>
              <div class="d-flex">
                <input type="text" class="form-control me-3" placeholder="Search" />
                <button class="btn btn-primary" style="width: 180px;" @click="()=>{ modal.create_blog_open = true; }">Create Blog</button>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-6 col-lg-4" v-for="(blog, bi) in blogs" :key="bi">
                <CardBlog 
                  :blog="blog" 
                  @edit="openEditModal"
                  @refresh="fetchBlogs()"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <ModalCreateBlog :open="modal.create_blog_open" @closed="()=>{ modal.create_blog_open = false; }" @refresh="fetchBlogs()" />
    <ModalEditBlog :open="modal.update_blog_open" :blog="modal.update_blog_info" @closed="()=>{ modal.update_blog_open = false; }" />
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import { variable } from '@/var';
  import SectionSidebar from "@/components/SectionSidebar.vue";
  import SectionHeader from "@/components/SectionHeader.vue";
  import CardBlog from './components/CardBlog.vue';
  import ModalCreateBlog from './components/ModalCreateBlog.vue';
  import ModalEditBlog from './components/ModalEditBlog.vue';
  import axios from 'axios';
  
  export default defineComponent({
    components: { ModalEditBlog, ModalCreateBlog, CardBlog, SectionSidebar, SectionHeader },
    data() {
      return {
        admin: {} as any,
        modal: {
          create_blog_open: false,
          update_blog_open: false,
          update_blog_info: {} as any,
        },
        blogs: {} as any
      }
    },
    methods: {
      async fetchBlogs() {
        await axios.get( variable()['api_main'] + "blog/fetchAll" ).then( async (response) => {
          this.blogs = response.data;
        });
      },
      openEditModal(blog: any) {
        this.modal.update_blog_open = true;
        this.modal.update_blog_info = blog.data;
      }
    },
    async mounted() {
      await getLocalUser().then( async (admin) => {
        if(admin) {
          this.admin = admin;
          await this.fetchBlogs().then( async () => {
            console.log("Blogs:", toRaw(this.$data));
          });
        }
        else {
          this.$router.replace('/');
        }
      });
    },
  });

</script>
