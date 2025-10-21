export type QueryUpdateProps = {
    connection: string,
    table: string,
    where: any,
    columns: any
};

export type QueryDeleteProps = {
    connection: string,
    table: string,
    where: any
};

export type QueryInsertGetIDProps = {
    connection: string,
    table: string,
    columns: any
};

export type QueryFetchPaginateProps = {
    connection: string,
    table: string,
    where: any,
    orderby: any,
    per_page?: number,
    page_no?: number
};

export type QueryFetchSingleProps = {
    connection: string,
    table: string,
    where: any
};

export type QueryFetchAllProps = {
    connection: string,
    table: string,
    where: any,
    orderby: any
};