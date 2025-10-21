<template>
  <div class="card">
		<h5 class="card-header">Manage Theme</h5>
    <div class="table-responsive text-nowrap">
			<table class="table">
				<thead>
					<tr>
            <th style="width: 50px;">No</th>
						<th>Theme</th>
						<th style="width: 100px;">View</th>
						<th style="width: 100px;">Update</th>
						<th style="width: 100px;">Delete</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(theme, ei) in themes" :key="ei">
						<td>{{ ei + 1 }}</td>
            <td>{{ theme?.name }}</td>
						<td><button class="btn btn-primary btn-sm" @click="onView(theme)">View</button></td>
            <td><button class="btn btn-primary btn-sm" @click="onUpdate(theme)">Update</button></td>
            <td><button class="btn btn-danger btn-sm" @click="onDelete(theme)">Delete</button></td>
					</tr>
				</tbody>
			</table>
		</div>
  </div>
</template>
<script lang="ts">

	import { defineComponent } from 'vue';
  import Swal from 'sweetalert2';
  import axios from 'axios';
  import { variable } from '@/var';
  import { getLocalUser } from '@/assets/ts/localStorage';

	export default defineComponent({
		emits: ['view', 'refresh', 'update'],
    props: {
      themes: {
        default: {} as any,
        type: Object
      }
    },
		methods: {
			onView(theme: any) {
				this.$emit('view', { data: theme });
			},
			onUpdate(theme: any) {
				this.$emit('update', { data: theme });
			},
			async onDelete(theme: any) {
        await getLocalUser().then( async (user) => {
          if(user.role == 1) {
            Swal.fire({
              title: "Confirmation",
              text: "Delete " + theme?.name + "?",
              showCancelButton: true,
              confirmButtonText: "Delete",
              icon: "question"
            }).then( async (result) => {
              if (result.isConfirmed) {
                await axios.get( variable()['api_main'] + "themes/delete?dataid=" + theme?.dataid ).then( async (response) => {
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