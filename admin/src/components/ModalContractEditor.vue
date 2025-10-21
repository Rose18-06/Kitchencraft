<template>
  <div class="modal fade" :class="{ show: open, display: open }" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Edit Contract</h5>
        </div>
        <div class="modal-body bg-light-gray p-0" style="max-height: calc(100vh - 300px);overflow: auto;">
          <div class="bg-white">
            <div class="alert alert-danger rounded-0">
              <h5 class="text-dark fw-bold m-0">Attachment 1: Booking Contract</h5>
              <p class="text-dark">Below is the default contract format, which is editable to suit your requirements.</p>
            </div>
          </div>
          <div class="d-flex justify-content-center">
            <div class="card rounded-0" id="printspace-contract" style="width: 700px;font-size: 14px;" :contenteditable="true">
              <div class="card-body text-dark">
                <div>
                  <div id="saved-contract-template" v-html="template"></div>
                  <table class="table table-bordered text-dark">
                    <tbody>
                      <tr>
                        <td style="width: 200px;">Client Name</td>
                        <td>{{ booking?.header?.first_name + ' ' + booking?.header?.last_name }}</td>
                      </tr>
                      <tr>
                        <td>Event Date</td>
                        <td>{{ booking?.header?.event_date }}</td>
                      </tr>
                      <tr>
                        <td>Contact Number</td>
                        <td>{{ booking?.header?.phone }}</td>
                      </tr>
                      <tr>
                        <td>Signature</td>
                        <td></td>
                      </tr>
                      <tr>
                        <td>Date</td>
                        <td></td>
                      </tr>
                    </tbody>
                  </table>
                  <p class="mt-4">For Kitchencraft Catering</p>
                  <table class="table table-bordered text-dark">
                    <tbody>
                      <tr>
                        <td style="width: 200px;">Representative Name</td>
                        <td></td>
                      </tr>
                      <tr>
                        <td>Signature</td>
                        <td></td>
                      </tr>
                      <tr>
                        <td>Date</td>
                        <td></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
          <div class="d-flex justify-content-center">
            <div class="w-50 mt-4">
              <button type="button" class="btn btn-primary w-100" @click="previewContract()" :disabled="loading.preview_contract">
                {{ loading.preview_contract ? 'Please wait...':'Save as PDF' }}
              </button>
            </div>
          </div>
          
          <div class="bg-white mt-4">
            <div class="alert alert-danger rounded-0">
              <h5 class="text-dark fw-bold m-0">Attachment 2: Booking Details</h5>
              <p class="text-dark">Below is the default booking details format, which is editable to suit your requirements.</p>
            </div>
          </div>
          <div class="d-flex justify-content-center pb-3">
            <div class="card rounded-0" id="printspace-details" style="width: 700px;font-size: 14px;" :contenteditable="true">
              <div class="card-body text-dark">
                <div class="d-flex justify-content-center">
                  <img src="/src/assets/img/logo.png" />
                </div>
                <p class="text-dark fw-bold text-center">Catering Service Booking Details</p>
                <table class="table table-bordered text-dark">
                  <tbody>
                    <tr>
                      <td style="width: 200px;">Location</td>
                      <td>{{ booking?.header?.event_location }}</td>
                    </tr>
                    <tr>
                      <td style="width: 200px;">Booking Date</td>
                      <td>{{ booking?.header?.event_date }}</td>
                    </tr>
                    <tr>
                      <td style="width: 200px;">Start Time</td>
                      <td>{{ booking?.header?.event_start_time }}</td>
                    </tr>
                    <tr>
                      <td style="width: 200px;">End Time</td>
                      <td>{{ booking?.header?.event_end_time }}</td>
                    </tr>
                    <tr>
                      <td style="width: 200px;">Number of pax</td>
                      <td>PHP {{ booking?.header?.event_pax }}</td>
                    </tr>
                    <tr>
                      <td style="width: 200px;">Price per pax</td>
                      <td>PHP {{ booking?.header?.event_pax_price }}</td>
                    </tr>
                    <tr>
                      <td style="width: 200px;">Cost</td>
                      <td>PHP {{ booking?.header?.event_cost }}</td>
                    </tr>
                  </tbody>
                </table>
                <p class="text-dark fw-bold mt-3">Customer Details</p>
                <table class="table table-bordered text-dark">
                  <tbody>
                    <tr>
                      <td style="width: 200px;">Name</td>
                      <td>{{ booking?.header?.first_name + ' ' + booking?.header?.last_name }}</td>
                    </tr>
                    <tr>
                      <td style="width: 200px;">Email</td>
                      <td>{{ booking?.header?.email }}</td>
                    </tr>
                    <tr>
                      <td style="width: 200px;">Mobile</td>
                      <td>{{ booking?.header?.phone }}</td>
                    </tr>
                  </tbody>
                </table>
                <p class="text-dark mt-3">
                  Thank you for choosing Kitchencraft Catering<br/>
                  We're looking forward to serve you soon!
                  <br/>
                  <br/>
                  <br/>
                  Warm regards,<br/>
                  The Kitchencraft Catering Team
                </p>
              </div>
            </div>
          </div>
          <div class="d-flex justify-content-center pb-5">
            <div class="w-50">
              <button type="button" class="btn btn-primary w-100" @click="previewDetails()" :disabled="loading.preview_contract">
                {{ loading.preview_contract ? 'Please wait...':'Save as PDF' }}
              </button>
            </div>
          </div>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="closeModal()">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">

  import { defineComponent, toRaw, ref } from 'vue';
  import { jsPDF } from "jspdf";
  import { variable } from '@/var';
  import axios from "axios";
  import $ from 'jquery';
  import Swal from 'sweetalert2';
  import { queryFetchSingle, queryUpdate } from '@/assets/ts/query';

  export default defineComponent({
    emits: ['closed', 'refresh'],
    props: {
      open: {
        default: false,
        type: Boolean
      },
      booking: {
        default: {},
        type: Object
      }
    },
    data() {
      return {
        user: {} as any,
        loading: {
          preview_contract: false
        },
        saved: {
          contract: false,
          details: false,
        },
        template: ''
      }
    },
    methods: {
      closeModal() {
        this.$emit("closed");
      },
      async saveTemplate() {
        var div = document.getElementById("saved-contract-template") as HTMLElement
        if(div) {
          var content = div.innerHTML;
          await queryUpdate({
            connection: 'undercater',
            table: 'template',
            where: [
              ['access_code', 'CONTRACT_TEMPLATE']
            ],
            columns: [
              {"content":content}
            ]
          });
        }
      },
      async getTemplate() {
        await queryFetchSingle({
          connection: 'undercater',
          table: 'template',
          where: [
            ['access_code', 'CONTRACT_TEMPLATE']
          ],
        }).then( async (response) => {
          if(response.length > 0) {
            this.template = response[0]['content'];
          }
        });
      },
      previewContract() {
        this.loading.preview_contract = true;
        var contract = new jsPDF('p', 'pt','legal');
        var elem = document.getElementById("printspace-contract") as HTMLElement;
        if(elem) {
          contract.html(elem, {
            margin: [10, 10, 10, 10],
            html2canvas: { scale: 0.75 },
            autoPaging: 'text',
            callback: async function (contract) {
              var blob = contract.output('blob'); 
              const formData = new FormData();
              const dataid    = localStorage.getItem('booking-dataid');
              formData.append('image', blob); 
              formData.append('dataid', dataid ? dataid : '');
              await axios.post( variable()['api_main'] + "photo/uploadFunctPDFContract", formData, { headers: {'Content-Type': 'multipart/form-data'}}).then( async (response) => {
                if(response.data?.success) {
                  Swal.fire({
                    title: 'Success',
                    text: 'Saved as PDF successfully',
                    icon: 'success'
                  });
                }
                else {
                  Swal.fire({
                    title: 'Fail',
                    text: 'Fail to generate PDF',
                    icon: 'warning'
                  });
                }
              });
            }
          }).then( async () => {
            this.loading.preview_contract = false;
            this.saveTemplate();
          });
        }
      },
      previewDetails() {
        this.loading.preview_contract = true;
        var contract = new jsPDF('p', 'pt','legal');
        var elem = document.getElementById("printspace-details") as HTMLElement;
        if(elem) {
          contract.html(elem, {
            margin: [10, 10, 10, 10],
            html2canvas: { scale: 0.75 },
            autoPaging: 'text',
            callback: async function (contract) {
              var blob = contract.output('blob'); 
              const formData = new FormData();
              const dataid    = localStorage.getItem('booking-dataid');
              formData.append('image', blob); 
              formData.append('dataid', dataid ? dataid : '');
              await axios.post( variable()['api_main'] + "photo/uploadFunctPDFDetails", formData, { headers: {'Content-Type': 'multipart/form-data'}}).then( async (response) => {
                if(response.data?.success) {
                  Swal.fire({
                    title: 'Success',
                    text: 'Saved as PDF successfully',
                    icon: 'success'
                  });
                }
                else {
                  Swal.fire({
                    title: 'Fail',
                    text: 'Fail to generate PDF',
                    icon: 'warning'
                  });
                }
              });
            }
          }).then( async () => {
            this.loading.preview_contract = false;
          });
        }
      }
    },
    watch: {
      open: async function () {
        if(this.open) {
          localStorage.setItem('booking-dataid', this.booking?.header.dataid);
          await this.getTemplate();
        }
      }
    }
  });


</script>
<style scoped>
  .display {
    display: block;
    background-color: #0a0a0a42;
  }
  .table > :not(caption) > * > * {
    padding: 0.3rem 1.25rem !important;
  }
  ul {
    list-style: none; /* Remove default bullets */
    padding-left: 20px; /* Optional: Adjust indentation */
  }

  ul li {
    list-style-type: none;
    position: relative;
    padding-left: 20px; /* Space for custom bullet */
  }

  ul li::before {
    content: '';
    width: 6px;
    height: 6px;
    background-color: black; /* Custom color */
    border-radius: 3px; /* Circle */
    position: absolute;
    top: 12px;
    left: 0;
    transform: translateY(-50%);
  }


</style>