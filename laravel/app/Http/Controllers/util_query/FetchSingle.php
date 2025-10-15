<?php

namespace App\Http\Controllers\util_query;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * 
 */

class FetchSingle extends Controller
{
    public static function fetchSingle(Request $request) {
        $orderby = json_decode($request['orderby']);
        return DB::table($request['table'])
                ->where(json_decode($request['where']))
                ->get();
    }
}
