<template>
  <div class="card">
		<h5 class="card-header">Manage Menu</h5>
    <div class="table-responsive text-nowrap" style="height: 600px;">
			<table class="table">
				<thead>
					<tr>
            <th style="width: 50px;">No.</th>
						<th>Menu</th>
						<th style="width: 100px;">View</th>
						<th style="width: 100px;">Update</th>
						<th style="width: 100px;">Delete</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(menu, mi) in menus" :key="mi">
						<td>{{ mi + 1 }}</td>
            <td>{{ menu?.name }}</td>
						<td><button class="btn btn-primary btn-sm" @click="onView(menu)">View</button></td>
            <td><button class="btn btn-primary btn-sm" @click="onUpdate(menu)">Update</button></td>
            <td><button class="btn btn-danger btn-sm" @click="onDelete(menu)">Delete</button></td>
					</tr>
				</tbody>
			</table>
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
		emits: ['view', 'update', 'refresh'],
    props: {
      menus: {
        default: {},
        type: Object
      }
    },
		methods: {
			onView(menu: any) {
				this.$emit('view', menu);
			},
			onUpdate(menu: any) {
				this.$emit('update', menu);
			},
			async onDelete(menu: any) {
        await getLocalUser().then( async (user) => {
          if(user?.role == 1) {
            Swal.fire({
              title: 'Confirmation',
              text: 'Delete ' + menu?.name + '?',
              icon: 'question',
              showCancelButton: true,
              confirmButtonText: 'Delete'
            }).then( async (result) => {
              if(result.isConfirmed) {
                await axios.get( variable()['api_main'] + "menu/delete?dataid=" + menu?.dataid ).then( async (response) => {
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