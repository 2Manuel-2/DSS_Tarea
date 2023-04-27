<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\EditorialesController;

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

Route::get('/Hola ', function () {
    return 'Hola mundo';
});

Route::get('/Hola/en', function () {
    return "Hello world";
});

Route::get('/Hola/{nombre}', function ($nombre) {
    return "Hola $nombre";
});




Route::controller(EditorialesController::class)->group(function () {
    Route::get('/editoriales/create', 'create');
    Route::get('/editoriales/edit/{id}', 'edit');
    Route::get('/editoriales', 'index');
});

