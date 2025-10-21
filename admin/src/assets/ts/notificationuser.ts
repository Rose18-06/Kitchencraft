import { variable } from "@/var";
import axios from "axios";
import $ from 'jquery';
import { queryFetchAll, queryFetchPaginate, queryUpdate } from "./query";

export async function notifyAllActivity(title: string, description: string, booking_dataid: string, message: string, ):Promise<any> {
    return new Promise( async (resolve) => {
        var args = {
            message: message,
            booking_dataid: booking_dataid,
            title: title,
            description: description
        };
        await axios( variable()['api_main'] + "activity/notifyAllActivity?" + $.param(args) ).then( async (response) => {
            return resolve(response);
        });
    });
}

export async function notifyFetchPaginate(user_dataid: string, page: number):Promise<any> {
    return new Promise( async (resolve) => {
        await queryFetchPaginate({
            connection: 'undercater',
            table: 'notifications',
            where: [
                ['user_dataid', user_dataid]
            ],
            orderby: ['dataid', 'desc'],
            per_page: 15,
            page_no: page
        }).then( async (response) => {
            return resolve(response);
        });
    });
}

export async function notifySeenAll(user_dataid: string):Promise<any> {
    return new Promise( async (resolve) => {
        await queryUpdate({
            connection: 'undercater',
            table: 'notifications',
            where: [
                ['user_dataid', user_dataid],
                ['seen', 0]
            ],
            columns: [
                {'seen':1}
            ]
        }).then( async (response) => {
            return resolve(response);
        });
    });
}

export async function notifyCountUnseen(user_dataid: string):Promise<any> {
    return new Promise( async (resolve) => {
        await queryFetchAll({
            connection: 'undercater',
            table: 'notifications',
            where: [
                ['user_dataid', user_dataid],
                ['seen', 0]
            ],
            orderby: ['dataid', 'desc']
        }).then( async (response) => {
            return resolve(response.length);
        });
    });
}