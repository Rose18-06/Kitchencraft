<?php

namespace App\Http\Controllers\booking;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Mail;

/**
 * booking/sendContract?booking_dataid=6
 */

class SendContract extends Controller
{
    public static function send(Request $request) {
        $name = DB::table('booking')
            ->select("event_location_dataid", "first_name", "last_name", "email","path_contract","path_details")
            ->where("dataid", $request['booking_dataid'])
            ->get();

        if(count($name) > 0) {

            $fullname           = $name[0]->first_name . ' ' . $name[0]->last_name;
            $email              = $name[0]->email;

            $path_contract      = $name[0]->path_contract;
            $path_details       = $name[0]->path_details;

            if(is_null($path_contract)) {
                return [
                    "success"   => false,
                    "message"   => "No PDF Contract found"
                ];
            }

            if(is_null($path_details)) {
                return [
                    "success"   => false,
                    "message"   => "No PDF Booking details found"
                ];
            }

            $location           = DB::table('location')->where('dataid', $name[0]->event_location_dataid)->get();
            $location_name      = "";
            $location_price     = "";
            $location_venue     = "";
            $location_inclusions= "";
            $location_remarks   = "";

            if(count($location) > 0) {
                $location_name          = $location[0]->location;
                $location_price         = $location[0]->price;
                $location_venue         = $location[0]->venue;
                $location_inclusions    = $location[0]->inclusions;
                $location_remarks       = $location[0]->remarks;
            }



            DB::table("booking")
            ->where("dataid", $request['booking_dataid'])
            ->update([
                "contract" => 1
            ]);

            return SendContract::sendEmail(
                $fullname,
                $email,
                $location_name,
                $location_price,
                $location_venue,
                $location_inclusions,
                $location_remarks,
                $path_contract,
                $path_details
            );
        }
        else {
            return [
                "success"   => true,
                "message"   => "Booking not found"
            ];
        }
    }

    public static function sendEmail($fullname, $email, $name, $price, $venue, $inclusions, $remarks, $path_contract, $path_details) {

        try {
            $subject    = 'Booking Contract for review';
            $content    = '<div style="font-family: sans-serif; width: 100%;height: 100%;background: #e8eff1;position: absolute;">
                            <div style="display: block;margin: 40px auto 0px auto; max-width: 500px;min-height: 300px;background-color: white;position: relative;border-bottom: 10px solid #ff3131;">
                                <img style="display: block;margin: 0 auto;width: 160px;" src="https://student.jlipreso.com/undercater-assets/logo.png"/>
                                <div style="padding: 0px 24px 24px 24px;font-size: 13px;line-height: 1.7;">
                                    <h3 style="text-align: center;">UnderCater Restaurant.</h3>
                                    <p><strong>Dear '. $fullname .',</strong></p>
                                    <p>We\'re happy to let you know that we are reviewing your booking.</p>
                                    <p>
                                        <strong>Rates and Inclusions</strong><br/>
                                        <strong>Location: </strong>'. $name .'<br/>
                                        <strong>Price: PHP </strong>'. $price .' per pax<br/>
                                        <strong>Venue: </strong>'. $venue .'<br/>
                                        <strong>Inclusions: </strong>'. $inclusions .'<br/>
                                        <strong>Remarks: </strong>'. $remarks .'
                                    </p>
                                    <p>We enforce righteousness and legality of each transaction we process.</p>
                                    <img style="display: block;margin: 0 auto; width: 120px;height: auto;" src="https://media.idownloadblog.com/wp-content/uploads/2016/04/52ff0e80b07d28b590bbc4b30befde52.png" />
                                    <a style="display: block;width: 100%; text-align: center;" target="_blank" href="'. $path_contract .'" download>Download Booking contract</a>
                                    <br/>
                                    <img style="display: block;margin: 0 auto; width: 120px;height: auto;" src="https://media.idownloadblog.com/wp-content/uploads/2016/04/52ff0e80b07d28b590bbc4b30befde52.png" />
                                    <a style="display: block;width: 100%; text-align: center;" target="_blank" href="'. $path_details .'" download>Download Booking details</a>
                                    <br/>
                                    <p style="text-align: center;">
                                        Please download the attached Booking Contract and carefully review it.<br/>
                                        After you review the contract, please sign it and send to us in this email.
                                    </p>
                                    <br/>
                                    <p>Thank you for choosing UnderCater Restaurant.<br/>We look forward to serving you!</p>
                                    <p>Warm regards,<br>The UnderCater Restaurant Team</p>
                                </div>
                                
                            </div>
                        </div>';
            Mail::html($content, function ($message) use($email, $subject) { $message->to($email)->subject($subject); });
            return [
                "success"   => true,
                "message"   => "Booking Contract sent"
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
