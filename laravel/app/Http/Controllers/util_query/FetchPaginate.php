<?php

namespace App\Http\Controllers\util_query;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * connection=
 */

class FetchPaginate extends Controller
{
    public static function fetchPaginate(Request $request) {
        $orderby    = json_decode($request['orderby']);
        $source     = DB::table($request['table'])
                    ->orderBy($orderby[0], $orderby[1])
                    ->paginate($request['per_page'])
                    ->toArray();
        $data       = $source['data'];
        $list       = [];

        foreach($data as  $index => $object) {;
            $list[]     = $object;
        }
        return \App\Http\Controllers\util_parser\Paginator::parse($source, $list);
    }
}
