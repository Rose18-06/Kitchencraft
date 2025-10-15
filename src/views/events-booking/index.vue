<template>
  <div>
    <SectionHeader/>
    <main class="main">
      <div class="content">
        <div class="container">
          <div class="py-5">
            <div class="row">
              <div class="col-sm-12 col-md-4">
                <SummarySection :refresh="refresh_summary" />
              </div>
              <div class="col-sm-12 col-md-8">
                <swiper :slides-per-view="1" :space-between="0" @swiper="onSwiper">
                  <swiper-slide class="swiper-no-swiping"><SlideContent1 :event="event" @refresh="refreshSummary()" @next="slideToSlide" /></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><SlideContent2 :event="event" @refresh="refreshSummary()" @back="slideToSlide" @next="slideToSlide"/></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><SlideContent3 :event="event" @refresh="refreshSummary()" @back="slideToSlide" @next="slideToSlide"/></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><SlideContent4 :event="event" @refresh="refreshSummary()" @back="slideToSlide" @next="slideToSlide"/></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><SlideContent5 :event="event" @refresh="refreshSummary()" @back="slideToSlide" @next="slideToSlide"/></swiper-slide>
                  <swiper-slide class="swiper-no-swiping"><SlideContent6 :event="event" @refresh="refreshSummary()" @back="slideToSlide" @next="slideToSlide"/></swiper-slide>
                </swiper>
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
  import { Swiper, SwiperSlide } from 'swiper/vue';
  import SectionHeader from "@/components/SectionHeader.vue";
  import SectionFooter from "@/components/SectionFooter.vue";
  import SlideContent1 from "./components/SlideContent1.vue";
  import SlideContent2 from "./components/SlideContent2.vue";
  import SlideContent3 from "./components/SlideContent3.vue";
  import SlideContent4 from "./components/SlideContent4.vue";
  import SlideContent5 from "./components/SlideContent5.vue";
  import SlideContent6 from "./components/SlideContent6.vue";
  import SummarySection from "./components/SummarySection.vue";
  import { getLocalEvent } from '@/assets/ts/localStorage';

  export default defineComponent({
    name: "EventsBookingPage",
    components: { SummarySection, SlideContent1, SlideContent2, SlideContent3, SlideContent4, SlideContent5, SlideContent6, Swiper, SwiperSlide, SectionFooter, SectionHeader },
    data() {
      return {
        swiper: {} as any,
        event: {} as any,
        refresh_summary: 0
      }
    },
    methods: {
      refreshSummary() {
        this.refresh_summary = Math.random();
      },
      onSwiper(event: any) {
        this.swiper = event;
      },
      slideToSlide(data: any) {
        this.swiper.slideTo(data.data?.index);
        this.refreshSummary();
      }
    },
    async mounted() {
      await getLocalEvent().then( async (event) => {
        this.event = event;
      });
    },
  });

</script>