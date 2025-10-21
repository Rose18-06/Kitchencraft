<template>
  <div class="card">
		<h5 class="card-header">Manage Category</h5>
    <div class="table-responsive text-nowrap">
			<table class="table">
				<thead>
					<tr>
            <th style="width: 50px;">No.</th>
						<th>Category</th>
            <th>Description</th>
						<th style="width: 100px;">View</th>
						<th style="width: 100px;">Update</th>
						<th style="width: 100px;">Delete</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(category, ci) in categories" :key="ci">
						<td>{{ ci + 1 }}</td>
            <td>{{ category?.name }}</td>
            <td class="text-wrap"><small>{{ category?.description }}</small></td>
						<td><button class="btn btn-primary btn-sm" @click="onView(category)">View</button></td>
            <td><button class="btn btn-primary btn-sm" @click="onUpdate(category)">Update</button></td>
            <td><button class="btn btn-danger btn-sm" @click="onDelete(category)">Delete</button></td>
					</tr>
				</tbody>
			</table>
		</div>
  </div>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';
  import { getLocalUser } from '@/assets/ts/localStorage';
	import { variable } from '@/var';
  import axios from 'axios';
  import Swal from 'sweetalert2';
  
	export default defineComponent({
		emits: ['view', 'update', 'refresh'],
    props: {
      categories: {
        default: {} as any,
        type: Object
      }
    },
		methods: {
			onView(category: any) {
				this.$emit('view', { category });
			},
			onUpdate(category: any) {
				this.$emit('update', { category });
			},
			async onDelete(category: any) {
        await getLocalUser().then( async (user) => {
          if(user?.role == 1) {
            Swal.fire({
              title: 'Confirmation',
              text: 'Delete ' + category?.name + '?',
              icon: 'question',
              showCancelButton: true,
              confirmButtonText: 'Delete'
            }).then( async (result) => {
              if(result.isConfirmed) {
                await axios.get( variable()['api_main'] + "menu_categories/delete?dataid=" + category?.dataid ).then( async (response) => {
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