
export function variable() {
    if(window.location.hostname == 'localhost') {
        return {
            api_main: "https://kitchencraft.online/laravel/public/api/"
        }
    }
    else {
        return {
            api_main: "https://kitchencraft.online/laravel/public/api/"
        }
    }
}
      