<?php

namespace App\Controllers;

use App\Models\Cliente;
use App\Models\Producto;
use System\Core\Controller;
use System\Core\View;

class HomeController extends Controller{

    private $cliente;
    private $producto;

    public function __construct(){
        $this->cliente = new Cliente;
        $this->producto = new Producto;
    }

    public function index(){

        return View::getView('Home.index', [
            'clientes' => $this->cliente->contar('clientes'),
            'productos' => $this->producto->contar('productos')
        ]);
    }
}