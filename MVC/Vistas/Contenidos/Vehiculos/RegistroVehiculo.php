<div id="contenido-principal">
    <div class="container-fluid">
        <div class="row justify-content-md-center">
            <div class="col-md-12">
                <h3><center>Registro de Vehiculo</center></h3>
                <hr class="bg-danger">
<?php 
    if(isset($alerta)){
        echo $alerta;
    }
?>
                
                <form action="?controlador=Vehiculo&accion=GuardarVehiculo" method="POST">

                    <div class="row form-group">
                        <label for="propietario" class="col-form-label col-md-4"> <strong>Asignar Propietario:</strong></label>
                    </div>
                    <p class="text-secondary">Los campos que contengan (*) son obligatorios</p>
                    <div class="row form-group">
                        <label for="identificacion" class=" col-form-label col-md-1">Cliente*: </label>
                        
                        <div class="col-md-6 p-2">
                            <select class="selectorBusqueda form-control" name="id_cliente" required=>
                                <option value="">-</option>
                        <?php
                            foreach( $this->modeloCliente->Listar() as $cliente):
                        ?>
                            
                                <option value="<?= $cliente->id;?>"><?= $cliente->identificacion . " - " . $cliente->nombre . " ". $cliente->apellido ;?></option>
                                
                        <?php endforeach; ?>   

                            </select>
                        </div>
                    </div>
                    <hr class="bg-secondary">
                    <div class="row form-group">
                        <label for="marca" class="col-form-label col-md-2 pr-0">Marca | Modelo | Año*:</label>
                        <div class="col-md-5 pt-2">
                            <select class="selectorBusqueda form-control" required name="id_modelo">
                                <option value="" selected>-</option>
                                
                        <?php
                            foreach( $modelos as $modelo):
                        ?>
                            
                                <option value="<?= $modelo->id;?>"><?= $modelo->marca;?> - <?= $modelo->modelo;?> - <?= $modelo->anio;?></option>
                        <?php endforeach; ?>
                            </select>
                        </div>  
                    </div>

                    <div class="row form-group">
                        <label for="placa" class="col-form-label col-md-1">Placa*:</label>
                        <div class="col-md-3">
                            <input type="text" name="placa" class="form-control" pattern="[A-Za-z0-9]{7}" maxlength="7" minlength="7" title="La Placa debe contener 7 Caracteres" placeholder="XXXXXXX" required>
                        </div>

                        <label for="color" class="col-form-label col-md-1">Color*:</label>
                        <div class="col-md-2">
                            <input type="text" name="color" class="form-control" maxlength="15" required placeholder="Color Vehiculo">
                        </div>

                        <label for="s_motor" class="col-form-label col-md-1">S/Motor*:</label>
                        <div class="col-md-3">
                            <input type="text" name="serial_motor" class="form-control" pattern="[A-Za-z0-9]{10,20}" title="Debe Contener minimo 10 caracteres y maximo 20" placeholder="Serial del Motor" required>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label for="serial_carroceria" class="col-form-label col-md-1">S/Carroceria*:</label>
                        <div class="col-md-3">
                            <input type="text" name="serial_carroceria" class="form-control" pattern="[A-Za-z0-9]{17}" maxlength="17" title="El Serial de Contener 17 Caracteres" placeholder="XXXXXXXXXXXXXXXXX"  required>
                        </div>

                        <label for="serial_caja" class="col-form-label col-md-1">S/Caja:</label>
                        <div class="col-md-3">
                            <input type="text" name="serial_caja" class="form-control" pattern="[A-Za-z0-9]" placeholder="Opcional...">
                        </div>

                        <input type="text" name="estatus" value="ACTIVO" hidden>
                    </div>

                    

                    <hr class="btn-danger">

                    <div class="row justify-content-md-center">
                        <a href="javascript:history.back(-1);" class="btn btn-secondary m-2"><i class="fas fa-arrow-circle-left"></i> Atras</a>
                        <button type="submit" class="btn btn-success m-2">Enviar</button>
                        <button type="reset" class="btn btn-secondary m-2">Limpiar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>