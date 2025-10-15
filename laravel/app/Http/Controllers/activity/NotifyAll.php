<?php

namespace App\Http\Controllers\activity;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Mail;

class NotifyAll extends Controller
{
    public static function notifyAllActivity(Request $request) {
        return NotifyAll::fetchAllStaff($request['message'], $request['booking_dataid'], $request['title'], $request['description']);
    }

    public static function fetchAllStaff($message, $booking_dataid, $title, $description) {

        $users      = DB::table("users_system")->select("dataid", "first_name", "last_name", "email", "contact")->where('status', 1)->get();
        $booking    = DB::table("booking")->select("event_location", "event_date", "event_start_time", "event_end_time", "first_name", "last_name","email")->get();
        $list       = [];

        foreach($users as $user) {
            $user_dataid    = $user->dataid;
            $user_name      = $user->first_name . ' ' . $user->last_name;
            $user_email     = $user->email;
            $list[]         = [
                "email"         => NotifyAll::notifyEmailTemplate($user_name, $user_email, $message, $booking[0]),
                "record"        => DB::table('notifications')->insert([
                    'user_dataid'       => $user_dataid,
                    'message'           => $message,
                    'title'             => $title,
                    'description'       => $description,
                    'seen'              => 0,
                    'created_at'        => date('Y-m-d h:i:s')
                ])
            ];
        }

        return $list;
    }

    public static function notifyEmailTemplate($user_name, $user_email, $message, $booking) {
        try {
            $subject    = "Undercater | System Notification";
            $content    = '<div style="font-family: sans-serif; width: 100%;height: 100%;background: #e8eff1;position: absolute;">
                        <div style="display: block;margin: 40px auto 0px auto; max-width: 500px;min-height: 300px;background-color: white;position: relative;border-bottom: 10px solid #ff3131;">
                            <img style="display: block;margin: 0 auto;width: 160px;" src="https://student.jlipreso.com/undercater-assets/logo.png"/>
                            <div style="padding: 0px 24px 24px 24px;font-size: 13px;line-height: 1.7;">
                                <h3 style="text-align: center;">System Notification</h3>
                                <div style="position: relative;padding: 1rem;margin-bottom: 1rem;border: 1px solid transparent;border-radius: .25rem;color: #664d03;background-color: #fff3cd;border-color: #ffecb5;">
                                    <p><strong>Dear '. $user_name .',</strong></p>
                                    <p>
                                        '. $message .'<br>
                                        This is a system generated email please don\'t reply.<br>
                                    </p>
                                </div>
                                <p>Booking Info:</p>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td>Event Location</td>
                                            <td> : '. $booking->event_location .'</td>
                                        </tr>
                                        <tr>
                                            <td>Event Date</td>
                                            <td> : '. $booking->event_date .'</td>
                                        </tr>
                                        <tr>
                                            <td>End Time</td>
                                            <td> : '. $booking->event_start_time .'</td>
                                        </tr>
                                        <tr>
                                            <td>Start Time</td>
                                            <td> : '. $booking->event_end_time .'</td>
                                        </tr>
                                        <tr>
                                            <td>Customer Name</td>
                                            <td> : '. $booking->first_name .' '. $booking->last_name .'</td>
                                        </tr>
                                        <tr>
                                            <td>Customer Email</td>
                                            <td> : '. $booking->email .'</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <p>
                                    Warm regards,<br>
                                    The UnderCater Restaurant Team
                                </p>
                            </div>
                            
                        </div>
                    </div>';
            Mail::html($content, function ($message) use($user_email, $subject) { $message->to($user_email)->subject($subject); });

            return [
                "success"   => true,
                "message"   => "Email sent to " . $user_name . ' with email ' . $user_email
            ]; 
        }
        catch(\Exception $e) {
            return [
                "success"   => false,
                "message"   => $e->getMessage()
            ]; 
        }
    }
}
