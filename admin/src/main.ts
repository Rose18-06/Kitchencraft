
import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import PrimeVue from 'primevue/config';
import Aura from '@primevue/themes/aura'; 

import 'bootstrap-icons/font/bootstrap-icons.min.css';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import 'swiper/css/scrollbar';


const app = createApp(App)

app.use(router)
    .use(PrimeVue, {
        theme: {
            preset: Aura
        }
    });

app.mount('#app')
