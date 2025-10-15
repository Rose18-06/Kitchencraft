<?php

namespace App\Http\Controllers\booking;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Codedge\Fpdf\Fpdf\Fpdf;
use Illuminate\Support\Facades\DB;

/**
 * booking/reportPDF?month=12&year=2024
 */

class ReportPDF extends Controller
{
    public static function print(Request $request) {
        
        $fpdf = new Fpdf();
        $fpdf->AddPage();

        $month  = $request['month'];
        $year   = $request['year'];

        ReportPDF::header($fpdf);
        ReportPDF::counter($fpdf, $month, $year);
        ReportPDF::bookings($fpdf, $month, $year);
        ReportPDF::footer($fpdf);

        $fpdf->Output();
        exit;
    }

    public static function bookings($fpdf, $month, $year) {
        $fpdf->SetFont('Arial', 'B', 9);
        $border = 1;
        $fpdf->Ln();
        $fpdf->setY(95);
        $fpdf->Cell(10, 6, "No.", $border, 0, 'C');
        $fpdf->Cell(20, 6, "Date", $border, 0, 'C');
        $fpdf->Cell(18, 6, "Start Time", $border, 0, 'C');
        $fpdf->Cell(18, 6, "End Time", $border, 0, 'C');
        $fpdf->Cell(30, 6, "Customer", $border, 0, 'C');
        $fpdf->Cell(45, 6, "Email", $border, 0, 'C');
        $fpdf->Cell(25, 6, "Grand Total", $border, 0, 'C');
        $fpdf->Cell(22, 6, "Status", $border, 0, 'C');
        $fpdf->Ln();

        $source = DB::table('booking')
                ->where('status', '>', 0)
                ->whereMonth('event_date', $month)
                ->whereYear('event_date', $year)
                ->orderBy('event_date', 'asc')
                ->get();
        $number = 0;
        $sum    = 0;

        $fpdf->SetFont('Arial', '', 9);
        foreach($source as $booking) {
            $number = $number + 1;
            $sum    = $sum + $booking->total_price;
            $fpdf->Cell(10, 6, $number, $border, 0, 'C');
            $fpdf->Cell(20, 6, $booking->event_date, $border, 0, 'C');
            $fpdf->Cell(18, 6, $booking->event_start_time, $border, 0, 'C');
            $fpdf->Cell(18, 6, $booking->event_end_time, $border, 0, 'C');
            $fpdf->Cell(30, 6, $booking->first_name . ' ' . $booking->last_name, $border, 0, 'C');
            $fpdf->Cell(45, 6, $booking->email, $border, 0, 'L');
            $fpdf->Cell(25, 6, 'PHP ' . $booking->total_price, $border, 0, 'C');
            $fpdf->Cell(22, 6, \App\Http\Controllers\booking\Translate::bookingStatus($booking->status)['value'], $border, 0, 'L');
            $fpdf->Ln();
        }

        $fpdf->Ln();

        $fpdf->Cell(30, 6, "Total Sale", $border, 0, 'L');
        $fpdf->Cell(30, 6, "PHP " . $sum, $border, 0, 'L');
    }

    public static function counter($fpdf, $month, $year) {

        $border = 1;
        $fpdf->Cell(37.6, 6, "All Booking", $border, 0, 'C');
        $fpdf->Cell(37.6, 6, "Pending", $border, 0, 'C');
        $fpdf->Cell(37.6, 6, "Approved", $border, 0, 'C');
        $fpdf->Cell(37.6, 6, "Cancelled", $border, 0, 'C');
        $fpdf->Cell(37.6, 6, "Completed", $border, 0, 'C');
        $fpdf->Ln();

        $all = DB::table('booking')
                ->where('status', '>', 0)
                ->whereMonth('event_date', $month)
                ->whereYear('event_date', $year)
                ->count();

        $pending = DB::table('booking')
                ->where('status', 1)
                ->whereMonth('event_date', $month)
                ->whereYear('event_date', $year)
                ->count();

        $confirmed = DB::table('booking')
                ->where('status', 2)
                ->whereMonth('event_date', $month)
                ->whereYear('event_date', $year)
                ->count();
        
        $completed = DB::table('booking')
                ->where('status', 4)
                ->whereMonth('event_date', $month)
                ->whereYear('event_date', $year)
                ->count();
        
        $cancelled = DB::table('booking')
                ->where('status', 3)
                ->whereMonth('event_date', $month)
                ->whereYear('event_date', $year)
                ->count();

        $fpdf->SetFont('Arial', '', 16);
        $fpdf->Cell(37.6, 14, $all, $border, 0, 'C');
        $fpdf->Cell(37.6, 14, $pending, $border, 0, 'C');
        $fpdf->Cell(37.6, 14, $confirmed, $border, 0, 'C');
        $fpdf->Cell(37.6, 14, $cancelled, $border, 0, 'C');
        $fpdf->Cell(37.6, 14, $completed, $border, 0, 'C');
        $fpdf->Ln();

    }

    public static function header($fpdf) {
        $border = 0;
        $fpdf->Image("https://student.jlipreso.com/undercater-assets/logo.png", 10, 5, 40, 40);
        $fpdf->SetFont('Arial', 'B', 16);
        $fpdf->Cell(40, 6, "", $border, 0);
        $fpdf->Cell(140, 10, "UnderCater Restaurant", $border, 0);
        $fpdf->Ln();
        $fpdf->SetFont('Arial', '', 10);
        $fpdf->Cell(40, 6, "", $border, 0);
        $fpdf->Cell(20, 6, "Address", $border, 0);
        $fpdf->Cell(120, 6, ": Nice Place Compound Nancasayan 2428 Urdaneta, Philippines", $border, 0);
        $fpdf->Ln();
        $fpdf->Cell(40, 6, "", $border, 0);
        $fpdf->Cell(20, 6, "Phone", $border, 0);
        $fpdf->Cell(120, 6, ": 0915 305 7747", $border, 0);
        $fpdf->Ln();
        $fpdf->Cell(40, 6, "", $border, 0);
        $fpdf->Cell(20, 6, "Email", $border, 0);
        $fpdf->Cell(120, 6, ": loretoskitchenette@gmail.com", $border, 0);
        $fpdf->Ln();
        $fpdf->Ln();
        $fpdf->SetFont('Arial', 'B', 16);
        $fpdf->Cell(188, 10, "Monthly Inventory Report", 1, $border, 'C');
        $fpdf->Ln();
        $fpdf->SetFont('Arial', 'B', 9);
        $fpdf->Cell(188, 6, "For month of December 2024", 1, $border, 'C');

        $fpdf->Ln();
        $fpdf->Ln();
    }

    public static function footer($fpdf) {
        $border = 0;
        $fpdf->SetY(258);
        $fpdf->Image("https://student.jlipreso.com/undercater-assets/logo.png", 10, 248, 30, 30);
        $fpdf->Cell(30, 6, "", $border, 0, 'L');
        $fpdf->Cell(120, 6, "UnderCater Restaurant", $border, 0, 'L');
        $fpdf->Ln();
        $fpdf->Cell(30, 6, "", $border, 0, 'L');
        $fpdf->Cell(120, 6, "This is a system generate report", $border, 0, 'L');
        $fpdf->Ln();
        $fpdf->Cell(30, 6, "", $border, 0, 'L');
        $fpdf->Cell(120, 6, "Page No.:" . $fpdf->PageNo(), $border, 0, 'L');
    }

    public static function numPad($sum) {
        return str_pad($sum, 6, '0', STR_PAD_LEFT);
    }
}
