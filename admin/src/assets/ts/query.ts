import {
    type QueryDeleteProps,
    type QueryFetchAllProps,
    type QueryFetchPaginateProps,
    type QueryFetchSingleProps,
    type QueryInsertGetIDProps,
    type QueryUpdateProps
} from "./types"
import { variable } from "@/var";
import $ from 'jquery';

export async function queryDelete({ connection, table, where }: QueryDeleteProps ):Promise<any>  {
    return new Promise( async (resolve) => {
        var args = {
            connection: connection,
            table: table,
            where: JSON.stringify(where)
        };
        
        var uri = variable()['api_main'] + "util_query/delete?" + $.param(args);
        await fetch(uri).then( res => res.json()).then((response) => {
            return resolve(response);
        });
    });
}

export async function queryFetchAll({ connection, table, where, orderby }: QueryFetchAllProps ):Promise<any>  {
    return new Promise( async (resolve) => {
        var args = {
            connection: connection,
            table: table,
            where: JSON.stringify(where),
            orderby: JSON.stringify(orderby)
        };
        
        var uri = variable()['api_main'] + "util_query/fetchAll?" + $.param(args);
        await fetch(uri).then( res => res.json()).then((response) => {
            return resolve(response);
        });
    });
}

export async function queryFetchPaginate({ connection, table, where, orderby, per_page = 25, page_no = 1 }: QueryFetchPaginateProps ):Promise<any>  {
    return new Promise( async (resolve) => {
        var args = {
            connection: connection,
            table: table,
            where: JSON.stringify(where),
            orderby: JSON.stringify(orderby),
            per_page: per_page,
            page_no: page_no
        };
        
        var uri = variable()['api_main'] + "util_query/fetchPaginate?" + $.param(args);
        await fetch(uri).then( res => res.json()).then((response) => {
            return resolve(response);
        });
    });
}

export async function queryFetchSingle({ connection, table, where }: QueryFetchSingleProps ):Promise<any>  {
    return new Promise( async (resolve) => {
        
        var args = {
            connection: connection,
            table: table,
            where: JSON.stringify(where)
        };
        
        var uri = variable()['api_main'] + "util_query/fetchSingle?" + $.param(args);
        await fetch(uri).then( res => res.json()).then((response) => {
            return resolve(response);
        });
        
    });
}

export async function queryInsertGetID({ connection, table, columns }: QueryInsertGetIDProps ):Promise<any>  {
    return new Promise( async (resolve) => {
        
        var args = {
            connection: connection,
            table: table,
            columns: columns
        };
        var uri = variable()['api_main'] + "util_query/insertGetID?" + $.param(args);
        console.log(uri);
        await fetch(uri).then( res => res.json()).then((response) => {
            console.log(response);
            return resolve(response);
        });
    });
}

export async function queryUpdate({ connection, table, where, columns }: QueryUpdateProps ):Promise<any>  {
    return new Promise( async (resolve) => {
        
        var args = {
            connection: connection,
            table: table,
            where: JSON.stringify(where),
            columns: columns
        };
        
        var uri = variable()['api_main'] + "util_query/update?" + $.param(args);
        console.log(uri);
        await fetch(uri).then( res => res.json()).then((response) => {
            return resolve(response);
        });
    });
}


