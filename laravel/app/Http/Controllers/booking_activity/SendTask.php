<?php

namespace App\Http\Controllers\booking_activity;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Mail;

/**
 * 
 */

class SendTask extends Controller
{
    public static function send(Request $request) {
        $user = DB::table('users_system')->where('dataid', $request['user_dataid'])->get();
        if(count($user) > 0) {
            $fullname           = $user[0]->first_name . ' ' . $user[0]->last_name;
            $email              = $user[0]->email;
            $booking            = DB::table("booking")
                                ->select("event_location", "event_date", "event_start_time", "event_end_time", "first_name", "last_name","email")
                                ->where('dataid', $request['booking_dataid'])
                                ->get();

            return SendTask::sendEmail($fullname, $email, $request['title'], $request['description'], $booking[0]);
        }
        else {
            return [
                "success"   => false,
                "message"   => "Staff not found"
            ];
        }
    }

    public static function sendEmail($fullname, $email, $title, $description, $booking) {

        try {
            $subject    = 'Task assignment';
            $content    = '<div style="font-family: sans-serif; width: 100%;height: 100%;background: #e8eff1;position: absolute;">
                                <div style="display: block;margin: 40px auto 0px auto; max-width: 500px;min-height: 300px;background-color: white;position: relative;border-bottom: 10px solid #ff3131;">
                                    <img style="display: block;margin: 0 auto;width: 160px;" src="https://student.jlipreso.com/undercater-assets/logo.png"/>
                                    <div style="padding: 0px 24px 24px 24px;font-size: 13px;line-height: 1.7;">
                                        <h3 style="text-align: center;">UnderCater Restaurant.</h3>
                                        <p><strong>Dear '. $fullname .',</strong></p>
                                        <p>
                                            A new task was assigned to you.<br>
                                            <table>
                                                <tr>
                                                    <td>Title</td>
                                                    <td> : '. $title .'</td>
                                                </tr>
                                                <tr>
                                                    <td>Description</td>
                                                    <td> : '. $description .'</td>
                                                </tr>
                                            </table>
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
                                            This is a system generated email please don\'t reply.<br>
                                            <br>
                                            Warm regards,<br>
                                            The UnderCater Restaurant Team
                                        </p>
                                    </div>
                                </div>
                            </div>';
            Mail::html($content, function ($message) use($email, $subject) { $message->to($email)->subject($subject); });
            return [
                "success"   => true,
                "message"   => "Sent successfully"
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
