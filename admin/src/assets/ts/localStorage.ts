import ls from 'localstorage-slim';

export async function getLocalUser():Promise<any> {
    return new Promise( async (resolve) => {
        var user = ls.get('user-admin', { encrypt: true });
        if(user) {
            return resolve(user);
        }
        else {
            return resolve(null);
        }
    });
}


      