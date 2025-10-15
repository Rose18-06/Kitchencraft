<?php

namespace App\Http\Controllers\marketing;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Mail;

/**
 * marketing/sendMarketing?dataid=8
 */

class Notification extends Controller
{
    public static function send(Request $request) {

        $dataid     = $request['dataid'];
        $customers  = DB::table('users_customer')->select('firstname', 'lastname', 'email')->where('email_verified', 1)->orderBy('lastname')->get();
        $list       = [];

        $promo      = DB::table("marketing")->where('dataid', $dataid)->get();
        $title      = $promo[0]->title;
        $content    = $promo[0]->content;
        $photo      = env('FTP_DIRECTORY') . $promo[0]->photo;

        foreach($customers as $recepient) {
            $name   = $recepient->firstname . ' ' . $recepient->lastname;
            $email  = $recepient->email;
            Notification::sendEmail($name, $email, $title, $content, $photo);
        }

        return [
            "success"   => true
        ];
    }

    public static function sendEmail($name, $email, $title, $content, $photo) {
        try {
            $subject    = "PROMO: " . $title;
            $content    = '<div style="font-family: sans-serif; width: 100%;height: 100%;background: #e8eff1;position: absolute;">
                                <div style="display: block;margin: 40px auto 0px auto; max-width: 500px;min-height: 300px;background-color: white;position: relative;border-bottom: 10px solid #ff3131;">
                                    <img style="width: 100%;" src="'. $photo .'"/>
                                    <div style="padding: 0px 24px 24px 24px;font-size: 13px;line-height: 1.7;">
                                        <h1 style="text-align: center;">'. $title .'</h1>
                                        <br>
                                        <p>Hi, '. $name .' We have personal offers to you as one of our loyal customers</p>
                                        <p>'. $content .'</p>
                                        <br>
                                        <p>Warm regards,<br>The UnderCater Restaurant Team</p>
                                    </div>
                                </div>
                            </div>';
            Mail::html($content, function ($message) use($email, $subject) { $message->to($email)->subject($subject); });
        }
        catch(\Exception $e) {
            return [
                "success"   => false,
                "message"   => $e->getMessage()
            ]; 
        }
        
    }
}
