<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['prefix' => 'util_query'], function () {
    Route::get('insertGetID', [App\Http\Controllers\util_query\InsertGetID::class, 'insertGetID']);
    Route::get('fetchSingle', [App\Http\Controllers\util_query\FetchSingle::class, 'fetchSingle']);
    Route::get('fetchAll', [App\Http\Controllers\util_query\FetchAll::class, 'fetchAll']);
    Route::get('fetchPaginate', [App\Http\Controllers\util_query\FetchPaginate::class, 'fetchPaginate']);
    Route::get('delete', [App\Http\Controllers\util_query\Delete::class, 'delete']);
    Route::get('update', [App\Http\Controllers\util_query\Update::class, 'update']);
});

Route::group(['prefix' => 'activity'], function () {
    Route::get('fetchAll', [App\Http\Controllers\activity\FetchAll::class, 'fetchAll']);
    Route::get('delete', [App\Http\Controllers\activity\Delete::class, 'delete']);
    Route::get('notifyAllActivity', [App\Http\Controllers\activity\NotifyAll::class, 'notifyAllActivity']);
});

Route::group(['prefix' => 'add_ons'], function () {
    Route::get('fetchAll', [App\Http\Controllers\add_ons\FetchAll::class, 'fetchAll']);
    Route::get('fetchDiscounted', [App\Http\Controllers\add_ons\FetchDiscounted::class, 'fetch']);
    Route::get('update', [App\Http\Controllers\add_ons\Update::class, 'update']);
    Route::get('create', [App\Http\Controllers\add_ons\Create::class, 'create']);
    Route::get('delete', [App\Http\Controllers\add_ons\Delete::class, 'delete']);
});

Route::group(['prefix' => 'blog'], function () {
    Route::get('fetchAll', [App\Http\Controllers\blog\FetchAll::class, 'fetchAll']);
    Route::get('create', [App\Http\Controllers\blog\Create::class, 'create']);
    Route::get('delete', [App\Http\Controllers\blog\Delete::class, 'delete']);
    Route::get('update', [App\Http\Controllers\blog\Update::class, 'update']);
});

Route::group(['prefix' => 'booking'], function () {
    Route::get('profile', [App\Http\Controllers\booking\Profile::class, 'profile']);
    Route::get('initBooking', [App\Http\Controllers\booking\Book::class, 'init']);
    Route::get('themeAndPacks', [App\Http\Controllers\booking\Book::class, 'themeAndPacks']);
    Route::get('placeReservation', [App\Http\Controllers\booking\Book::class, 'placeReservation']);
    Route::get('fetchAll', [App\Http\Controllers\booking\FetchAll::class, 'fetchAll']);
    Route::get('approve', [App\Http\Controllers\booking\Approve::class, 'approve']);
    Route::get('decline', [App\Http\Controllers\booking\Decline::class, 'decline']);
    Route::get('delete', [App\Http\Controllers\booking\Delete::class, 'delete']);
    Route::get('cancel', [App\Http\Controllers\booking\Cancel::class, 'cancel']);
    Route::get('report', [App\Http\Controllers\booking\Report::class, 'report']);
    Route::get('reportPDF', [App\Http\Controllers\booking\ReportPDF::class, 'print']);
    Route::get('calendar', [App\Http\Controllers\booking\FetchAll::class, 'calendar']);
    Route::get('fetchByDataID/{dataid}', [App\Http\Controllers\booking\FetchAll::class, 'fetchByDataID']);
    Route::get('fetchByUser/{user_dataid}', [App\Http\Controllers\booking\FetchAll::class, 'fetchByUser']);
    Route::get('getDraft/{user_dataid}', [App\Http\Controllers\booking\Draft::class, 'get']);
    Route::get('updatePaymentReceipt', [App\Http\Controllers\booking\Book::class, 'updatePaymentReceipt']);
    Route::get('sendContract', [App\Http\Controllers\booking\SendContract::class, 'send']);
});

Route::group(['prefix' => 'booking_activity'], function () {
    Route::get('fetchAll', [App\Http\Controllers\booking_activity\FetchAll::class, 'fetchAll']);
    Route::get('add', [App\Http\Controllers\booking_activity\Add::class, 'add']);
    Route::get('delete', [App\Http\Controllers\booking_activity\Delete::class, 'delete']);
    Route::get('update', [App\Http\Controllers\booking_activity\Update::class, 'update']);
    Route::get('sendTask', [App\Http\Controllers\booking_activity\SendTask::class, 'send']);
});

Route::group(['prefix' => 'booking_addons'], function () {
    Route::get('add', [App\Http\Controllers\booking_addons\Add::class, 'add']);
    Route::get('remove/{dataid}', [App\Http\Controllers\booking_addons\Remove::class, 'remove']);
});

Route::group(['prefix' => 'booking_foods'], function () {
    Route::get('add', [App\Http\Controllers\booking_foods\Add::class, 'add']);
    Route::get('remove/{dataid}', [App\Http\Controllers\booking_foods\Remove::class, 'remove']);
    Route::get('verify', [App\Http\Controllers\booking_foods\Add::class, 'verify']);
});

Route::group(['prefix' => 'categories'], function () {

});

Route::group(['prefix' => 'dashboard'], function () {
    Route::get('counter', [App\Http\Controllers\dashboard\FetchAll::class, 'counter']);
    Route::get('chart', [App\Http\Controllers\dashboard\FetchAll::class, 'chart']);
});

Route::group(['prefix' => 'events'], function () {
    Route::get('fetchAll', [App\Http\Controllers\events\FetchAll::class, 'fetchAll']);
    Route::get('checkAvailability', [App\Http\Controllers\events\CheckAvailability::class, 'check']);
    Route::get('add', [App\Http\Controllers\events\Add::class, 'add']);
    Route::get('update', [App\Http\Controllers\events\Update::class, 'update']);
    Route::get('delete', [App\Http\Controllers\events\Delete::class, 'delete']);
});

Route::group(['prefix' => 'inquiry'], function () {
    Route::get('send', [App\Http\Controllers\inquiry\Send::class, 'send']);
    Route::get('fetchAll', [App\Http\Controllers\inquiry\FetchAll::class, 'fetchAll']);
    Route::get('delete', [App\Http\Controllers\inquiry\Delete::class, 'delete']);
});

Route::group(['prefix' => 'inventory_stocks'], function () {
    Route::get('fetchAll', [App\Http\Controllers\inventory_stocks\FetchAll::class, 'fetchAll']);
    Route::get('update', [App\Http\Controllers\inventory_stocks\Update::class, 'update']);
    Route::get('create', [App\Http\Controllers\inventory_stocks\Create::class, 'create']);
    Route::get('delete', [App\Http\Controllers\inventory_stocks\Delete::class, 'delete']);
});

Route::group(['prefix' => 'location'], function () {
    Route::get('fetchAll', [App\Http\Controllers\location\FetchAll::class, 'fetchAll']);
});

Route::group(['prefix' => 'marketing'], function () {
    Route::get('fetchAll', [App\Http\Controllers\marketing\FetchAll::class, 'fetchAll']);
    Route::get('create', [App\Http\Controllers\marketing\Create::class, 'create']);
    Route::get('delete', [App\Http\Controllers\marketing\Delete::class, 'delete']);
    Route::get('update', [App\Http\Controllers\marketing\Update::class, 'update']);
    Route::get('sendMarketing', [App\Http\Controllers\marketing\Notification::class, 'send']);
});

Route::group(['prefix' => 'menu'], function () {
    Route::get('fetchAll', [App\Http\Controllers\menu\FetchAll::class, 'fetchAll']);
    Route::get('fetchAllByCategory', [App\Http\Controllers\menu\FetchAll::class, 'fetchAllByCategory']);
    Route::get('add', [App\Http\Controllers\menu\Add::class, 'add']);
    Route::get('delete', [App\Http\Controllers\menu\Delete::class, 'delete']);
    Route::get('update', [App\Http\Controllers\menu\Update::class, 'update']);
});

Route::group(['prefix' => 'menu_categories'], function () {
    Route::get('fetchAll', [App\Http\Controllers\menu_categories\FetchAll::class, 'fetchAll']);
    Route::get('update', [App\Http\Controllers\menu_categories\Update::class, 'update']);
    Route::get('delete', [App\Http\Controllers\menu_categories\Delete::class, 'delete']);
    Route::get('create', [App\Http\Controllers\menu_categories\Create::class, 'create']);
});

Route::group(['prefix' => 'notifications'], function () {

});

Route::group(['prefix' => 'photo'], function () {
    Route::post('upload', [App\Http\Controllers\photo\Upload::class, 'upload']);
    Route::post('uploadFunct', [App\Http\Controllers\photo\UploadFunct::class, 'upload']);
    Route::post('uploadFunctPDFContract', [App\Http\Controllers\photo\UploadFunct::class, 'uploadPDFContract']);
    Route::post('uploadFunctPDFDetails', [App\Http\Controllers\photo\UploadFunct::class, 'uploadPDFDetails']);
});

Route::group(['prefix' => 'ratings'], function () {

});

Route::group(['prefix' => 'room_images'], function () {

});

Route::group(['prefix' => 'room_type'], function () {

});

Route::group(['prefix' => 'themes'], function () {
    Route::get('fetchAll', [App\Http\Controllers\themes\FetchAll::class, 'fetchAll']);
    Route::get('add', [App\Http\Controllers\themes\Add::class, 'add']);
    Route::get('update', [App\Http\Controllers\themes\Update::class, 'update']);
    Route::get('delete', [App\Http\Controllers\themes\Delete::class, 'delete']);
});

Route::group(['prefix' => 'users_customer'], function () {
    Route::get('login', [App\Http\Controllers\users_customer\Login::class, 'login']);
    Route::get('register', [App\Http\Controllers\users_customer\Register::class, 'register']);
    Route::get('verify', [App\Http\Controllers\users_customer\Verify::class, 'verify']);
    Route::get('sendEmail/{email}/{token}', [App\Http\Controllers\users_customer\Register::class, 'sendEmail']);
});

Route::group(['prefix' => 'users_system'], function () {
    Route::get('login', [App\Http\Controllers\users_system\Login::class, 'login']);
    Route::get('fetchAll', [App\Http\Controllers\users_system\FetchAll::class, 'fetchAll']);
    Route::get('create', [App\Http\Controllers\users_system\Create::class, 'create']);
    Route::get('delete', [App\Http\Controllers\users_system\Delete::class, 'delete']);
    Route::get('update', [App\Http\Controllers\users_system\Update::class, 'update']);
});


