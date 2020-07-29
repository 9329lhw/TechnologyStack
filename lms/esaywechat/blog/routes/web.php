<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});


Route::get('wxcode','WeChateController@wxcode');
Route::get('wxtoken','WeChateController@wxtoken');

 Route::get('wechat/auth', function(){
   $wechat = session('wechat.oauth_user.default'); //拿到授权用户资料
   dd($wechat); //打印出授权用户资料
 })->middleware('Auth.WeChat');

Route::get('products','ProductController@index')->name('products.index');
Route::any('WeChat','WeChateController@auth')->middleware('Auth.WeChat')->name('Login.WeChat');
