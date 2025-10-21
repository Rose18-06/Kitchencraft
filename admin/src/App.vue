<template>
  <div>
    <RouterView
      @open_notif="()=>{ modal.notification.open = true }"
    />
    <ModalNotifications
      :open="modal.notification.open"
      @closed="()=>{ modal.notification.open = false }"
    />
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { RouterView } from 'vue-router';
  import ModalNotifications from "@/components/ModalNotifications.vue";

  export default defineComponent({
    components: {RouterView, ModalNotifications},
    data() {
      return {
        modal: {
          notification: {
            open: false
          }
        }
      }
    }
  });
</script>
