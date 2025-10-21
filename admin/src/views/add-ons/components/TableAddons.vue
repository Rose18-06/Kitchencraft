<template>
  <div class="card">
		<h5 class="card-header">Manage Add-ons</h5>
    <div class="table-responsive text-nowrap">
			<table class="table">
				<thead>
					<tr>
            <th style="width: 50px;">No.</th>
						<th>Add-ons</th>
            <th>Price</th>
						<th style="width: 100px;">View</th>
						<th style="width: 100px;">Update</th>
						<th style="width: 100px;">Delete</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(addon, ai) in addons">
            <td>{{ ai + 1 }}</td>
						<td>{{ addon?.name }}</td>
            <td>{{ toCurrencyFormat(addon?.price) }}</td>
						<td><button class="btn btn-primary btn-sm" @click="onView(addon)">View</button></td>
            <td><button class="btn btn-primary btn-sm" @click="onUpdate(addon)">Update</button></td>
            <td><button class="btn btn-danger btn-sm" @click="onDelete(addon)">Delete</button></td>
					</tr>
				</tbody>
			</table>
		</div>
  </div>
</template>
<script lang="ts">

	import { defineComponent } from 'vue';
  import { toCurrency } from '@/assets/ts/formatter';
  import { variable } from '@/var';
  import { getLocalUser } from '@/assets/ts/localStorage';
  import Swal from 'sweetalert2';
  import axios from 'axios';

	export default defineComponent({
		emits: ['view', 'update', 'refresh'],
    props: {
      addons: {} as any,
      type: Object
    },
		methods: {
			onView(add_on: any) {
				this.$emit('view', { add_on });
			},
			onUpdate(add_on: any) {
				this.$emit('update', { add_on });
			},
      toCurrencyFormat(amount: number) {
        return toCurrency(amount);
      },
			async onDelete(add_on: any) {
        await getLocalUser().then( async (user) => {
          if(user?.role == 1) {
            Swal.fire({
              title: 'Confirmation',
              text: 'Delete ' + add_on?.name + '?',
              icon: 'question',
              showCancelButton: true,
              confirmButtonText: 'Delete'
            }).then( async (result) => {
              if(result.isConfirmed) {
                await axios.get( variable()['api_main'] + "add_ons/delete?dataid=" + add_on?.dataid ).then( async (response) => {
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
			}
		}
	});

</script>