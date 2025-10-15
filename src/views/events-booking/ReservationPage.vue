<template>
  <div class="container py-4">

    <!-- SlideContent2 for adding dishes -->
    <SlideContent2 @addLocalDish="addDish" />

    <!-- SummarySection showing the selected dishes -->
    <SummarySection 
      :dishes="selectedDishes" 
      @removeDish="removeDish" 
    />

  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import SlideContent2 from './components/SlideContent2.vue';
import SummarySection from './components/SummarySection.vue';


export default defineComponent({
  components: { SlideContent2, SummarySection },
  data() {
    return {
      selectedDishes: [] as any[],
    };
  },
  methods: {
    addDish(dish: any) {
      // Limit to max 3 dishes per category
      const categoryDishes = this.selectedDishes.filter(d => d.category === dish.category);
      if (categoryDishes.length >= 3) return;
      this.selectedDishes.push(dish);
    },
    removeDish(dish: any) {
      this.selectedDishes = this.selectedDishes.filter(d => d.dataid !== dish.dataid);
    }
  }
});
</script>
