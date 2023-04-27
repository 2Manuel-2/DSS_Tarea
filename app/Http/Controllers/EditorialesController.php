<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PhpParser\Node\Expr\FuncCall;

class EditorialesController extends Controller
{
    //
    public function index(){
        return view('editoriales.index');
    }

    public function create(){
        return view('editoriales.create');
    }

    public function edit($id){
        $datos=['id'=>$id,'nombre'=>'Clasicos Roxsil'];
        return view('editoriales.edit',$datos);
    }
}
