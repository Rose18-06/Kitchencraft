<?php

namespace App\Http\Controllers\activity;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * \App\Http\Controllers\activity\Create::create($title, $activity);
 */

class Create extends Controller
{
    public static function create($title, $activity) {
        return DB::table('activity')->insert([
            "title"     => $title,
            "activity"  => $activity
        ]);
    }
}
