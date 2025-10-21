<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Event Details</h5>
        </div>
        <img class="w-100" :src=" 'https://api-fileserver.jlipreso.com/' + event?.photo" />
        <div class="modal-body bg-light-gray" style="max-height: calc(100vh - 300px);overflow: auto;">
          <div class="card">
            <div class="card-body">
              <div class="mb-3">
                <label class="form-label">Event Name</label>
                <input :value="event?.name" type="text" class="form-control form-control-lg bg-white" readonly>
              </div>
              <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea :value="event?.description" class="form-control form-control-lg bg-white" style="min-height: 150px;" readonly></textarea>
              </div>
              <div class="mb-3">
                <label class="form-label">Package</label>
                <textarea :value="event?.package" class="form-control form-control-lg bg-white" style="min-height: 150px;" readonly></textarea>
              </div>
              <div class="row">
                <div class="col-sm-12 col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Min. Occupancy</label>
                    <input :value="event?.min_occupancy" type="number" class="form-control form-control-lg bg-white" readonly>
                  </div>
                </div>
                <div class="col-sm-12 col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Max. Occupancy</label>
                    <input :value="event?.max_occupancy" type="number" class="form-control form-control-lg bg-white" readonly>
                  </div>
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label">Price per pax</label>
                <input :value="toCurrencyFormat(event?.price)" type="text" class="form-control form-control-lg bg-white" readonly>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" @click="closeModal()">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { toCurrency } from '@/assets/ts/formatter';

  export default defineComponent({
    emits: ['closed', 'refresh'],
    props: {
      open: {
        default: false,
        type: Boolean
      },
      event: {
        default: {},
        type: Object
      }
    },
    data() {
      return {}
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      toCurrencyFormat(amount: number) {
        return toCurrency(amount);
      }
    }
  });

</script>
<style scoped>
  .display {
    display: block;
    background-color: #0a0a0a42;
  }
</style>