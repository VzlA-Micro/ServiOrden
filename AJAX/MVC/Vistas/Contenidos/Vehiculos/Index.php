<div id="contenido-principal">
    <div class="container-fluid">
        
      
        <div class="container-fluid">
            <div class="row">
                <a href="?controlador=Vehiculo&accion=RegistroVehiculo" class="btn btn-success btn-lg m-3 font-weight-light"><i class="fas fa-car"></i> Registrar Vehiculo </a>
                <a href="?controlador=Vehiculo&accion=RegistroCaja" class="btn btn-primary btn-lg m-3 font-weight-light"><i class="fas fa-box"></i> Registrar Caja </a>
                <a href="?controlador=Vehiculo&accion=InicioMarca" class="btn btn-info btn-lg m-3 font-weight-light"> <i class="fas fa-trademark"></i> Marcas</a>
                <!-- <a href="?controlador=cliente&accion=RegistroCliente" class="btn btn-success btn-lg m-3">Registrar Modelo <i class="fas fa-user-plus"></i></a> -->
            </div>
        </div>
        <hr class="bg-danger">
        
        <table class="table shadow table-striped">
            <thead class="thead-dark">
                <tr>
                    <th colspan="7" class="text-center bg-primary"><h4 class="font-weight-normal">Vehiculos</h4></th>
                </tr>
                <tr>
                    <th>#</th>
                    <th>Placa</th>
                    <th>Marca | Modelo | Año</th>
                    <th>Ordenes</th>
                    <th>Actualizar</th>
                    <th>Eliminar</th>
                    <th>Propietario</th>
                </tr>
            </thead>
            <tbody>
            <?php
                $orden = 0;
//                var_dump($this->modeloVehiculo->listarVehiculos());
                foreach ( $this->modeloVehiculo->listarVehiculos() as $vehiculo):
                    $orden++;
            ?>
                <tr>
                    <td><?= $orden;?></td>
                    <td><?= $vehiculo->placa;?></td>
                    <td><?= $vehiculo->marca . " - " .$vehiculo->modelo . " - " . $vehiculo->anio;?></td>
                    <td>
                        <a href="#" class="text-dark"><i class="fas fa-search fa-lg "></i></a>
                        <a href="#" class="text-success"><i class="fas fa-plus-circle fa-lg pl-1"></i></a>
                    </td>
                    <td><a href="?controlador=Vehiculo" class="text-info"><i class="fas fa-sync fa-lg pl-4"></i></a></td>
                    <td><a href="?controlador=Vehiculo" class="text-danger"><i class="fas fa-trash-alt fa-lg pl-4"></i></a></td>
                    <td><?= $vehiculo->nombre . " " . $vehiculo->apellido;?></td>
                </tr>    
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <div class="container-fluid">

        <hr class="bg-danger">
        
       <?php
            if(isset($alerta)){
                echo $alerta;
            }
       ?>
        <table class="table">
            <thead class="thead-dark">
                <tr>
                    <th colspan="7" class="text-center bg-danger"><h4 class="font-weight-normal">Cajas</h4></th>
                </tr>
                <tr>
                    <th>#</th>
                    <th>Propietario</th>
                    <th>Marca</th>
                    <th>Modelo</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                

            </tbody>
        </table>
    </div>
</div>