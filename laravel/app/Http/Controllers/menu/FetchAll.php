<?php

namespace App\Http\Controllers\menu;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * menu/fetchAll
 * menu/fetchAllByCategory
 */

class FetchAll extends Controller
{
    public static function fetchAll(Request $request) {
        if((isset($request['category'])) && ($request['category'] !== 'all')) {
            return DB::table("menu")
                ->orderBy('name', 'asc')
                ->where("category", $request['category'])
                ->get();
        }
        else {
            return DB::table("menu")
                ->orderBy('name', 'asc')
                ->get();
        }
    }

    public static function fetchAllByCategory(Request $request) {
        $category = DB::table("menu_categories")
            ->orderBy('name', 'asc')
            ->get();

        $list = [];

        foreach($category as $cat) {
            $list[] = [
                "header"    => $cat,
                "child"     => DB::table('menu')->where('category', $cat->name)->orderBy('name', 'asc')->get()
            ];
        }

        return $list;
    }
}
