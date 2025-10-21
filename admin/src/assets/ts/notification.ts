import { queryFetchAll, queryFetchPaginate, queryUpdate } from "./query";


export async function fetchPaginateNotifications(page: number):Promise<any> {
    return new Promise( async (resolve) => {
        await queryFetchPaginate({
            connection: 'undercater',
            table: 'activity',
            where: [
                ['dataid', '>', 0]
            ],
            orderby: ['dataid', 'desc'],
            per_page: 15,
            page_no: page
        }).then( async (response) => {
            return resolve(response);
        });
    });
}

export async function countNotifications():Promise<any> {
    return new Promise( async (resolve) => {
        await queryFetchAll({
            connection: 'undercater',
            table: 'activity',
            where: [
                ['seen', 0]
            ],
            orderby: ['dataid','asc']
        }).then( async (response) => {
            return resolve(response.length);
        });
    });
}

export async function seenAllNotifications():Promise<any> {
    return new Promise( async (resolve) => {
        await queryUpdate({
            connection: 'undercater',
            table: 'activity',
            where: [
                ['seen', 0]
            ],
            columns: [
                {"seen":1}
            ]
        }).then( async (response) => {
            return resolve(response);
        });
    });
}