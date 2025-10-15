import ls from 'localstorage-slim';

export async function getLocalUser():Promise<any> {
    return new Promise( async (resolve) => {
        var user = ls.get('user', { encrypt: true });
        if(user) {
            return resolve(user);
        }
        else {
            return resolve(null);
        }
    });
}

export async function getLocalEvent():Promise<any> {
    return new Promise( async (resolve) => {
        var event = ls.get('booking-event');
        if(event) {
            return resolve(event);
        }
        else {
            return resolve(null);
        }
    });
}

export async function getBookingDataID():Promise<any> {
    return new Promise( async (resolve) => {
        var dataid = ls.get('booking-dataid');
        if(dataid) {
            return resolve(dataid);
        }
        else {
            return resolve(null);
        }
    });
}


      