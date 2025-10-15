<?php

namespace App\Http\Controllers\activity;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * 
 */

class Delete extends Controller
{
    public static function delete(Request $request) {

        $deleted = DB::table("activity")->where("dataid", $request['dataid'])->delete();
        
        if($deleted) {
            return [
                "success"   => true,
                "message"   => "Activity log deleted successfully"
            ];
        }
        else {
            return [
                "success"   => false,
                "message"   => "Fail to deleted activity log, try again later"
            ];
        }
    }
}
