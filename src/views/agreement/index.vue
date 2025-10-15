<template>
  <div>
    <SectionHeader/>
    <main class="main" style="background-color: rgb(220 221 223);">
      <div class="content">
        <div class="container">
          <div class="row py-5">
            <div class="bg-white p-5">
              <h1>Catering Service Agreement Form</h1>
              <p>This Agreement is made between Kitchencraft Catering ("the Caterer") and the Customer ("the Client"). By signing this Agreement, the Client agrees to the following terms and conditions:</p>
              <hr/>
              <h3><strong>Charges Outside Venue</strong></h3>

              <hr/>
              <h3><strong>Salary of Staff (Overtime)</strong></h3>

              <hr/>
              <h3><strong>Policy on Cancellation and Incidents</strong></h3>

              <hr/>
              <h3><strong>Damages to Property</strong></h3>

              <hr/>
              <h3><strong>Acknowledgment and Agreement</strong></h3>
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
  import SectionHeader from "@/components/SectionHeader.vue";
  import SectionFooter from "@/components/SectionFooter.vue";

  export default defineComponent({
    components: { SectionHeader, SectionFooter}
  });

</script>