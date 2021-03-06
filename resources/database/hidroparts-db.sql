CREATE TABLE roles(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL UNIQUE,
    descripcion VARCHAR(255) DEFAULT NULL,
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_roles_pk PRIMARY KEY(id)
);

CREATE TABLE permisos(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL UNIQUE,
    descripcion VARCHAR(255) DEFAULT NULL,
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_permisos_pk PRIMARY KEY(id)
);

CREATE TABLE roles_con_permisos(
    rol_id INT NOT NULL,
    permiso_id INT NOT NULL,

    CONSTRAINT roles_con_permisos_id PRIMARY KEY(rol_id, permiso_id),

    CONSTRAINT fk_rol_id FOREIGN KEY(rol_id) REFERENCES roles(id),
    CONSTRAINT fk_permiso_id FOREIGN KEY(permiso_id) REFERENCES permisos(id)

);

CREATE TABLE usuarios(
	id INT AUTO_INCREMENT,
    rol_id INT,

    documento VARCHAR(15) UNIQUE NOT NULL,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(200),
    telefono VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    usuario VARCHAR(50) UNIQUE,
    password VARCHAR(150),
    -- imagen VARCHAR(255) DEFAULT NULL,
    -- remenber_token VARCHAR(255) DEFAULT NULL,
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT id_usuraios_pk PRIMARY KEY(id),
    CONSTRAINT rol_id_fk FOREIGN KEY(rol_id) REFERENCES roles(id) MATCH FULL
    ON UPDATE CASCADE
);

CREATE TABLE bitacora(
    id INT AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modulo VARCHAR(50),
    accion VARCHAR(100),

    CONSTRAINT id_bitacora_pk PRIMARY KEY(id),
    CONSTRAINT usuario_id_bitacora_fk FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE clientes(
    id INT AUTO_INCREMENT,
    documento VARCHAR(15) UNIQUE NOT NULL,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(200),
    telefono VARCHAR(15),
    email VARCHAR(100),
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_clientes_pk PRIMARY KEY(id)
);

CREATE TABLE empleados(
    id INT AUTO_INCREMENT,
    documento VARCHAR(15) UNIQUE NOT NULL,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(200),
    telefono VARCHAR(15),
    email VARCHAR(100),
    cargo VARCHAR(25),
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_empleados_pk PRIMARY KEY(id)
);

CREATE TABLE marcas(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(40) UNIQUE,
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_marcas_pk PRIMARY KEY(id)
);

CREATE TABLE modelos(
    id INT AUTO_INCREMENT,
    id_marcas INT,
    nombre VARCHAR(25),
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_modelos_pk PRIMARY KEY(id),

    CONSTRAINT id_marcas_fk FOREIGN KEY(id_marcas) REFERENCES marcas(id) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE vehiculos(
    id INT AUTO_INCREMENT,
    id_modelos INT,
    id_clientes INT,
    placa VARCHAR(25),
    serial_motor VARCHAR(25),
    serial_carroceria VARCHAR(25),
    serial_caja VARCHAR(25),
    color VARCHAR(20),
    anio VARCHAR(10),
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_vehiculos_pk PRIMARY KEY(id),
    
    CONSTRAINT id_modelos_fk FOREIGN KEY(id_modelos) REFERENCES modelos(id) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT id_clientes_fk FOREIGN KEY(id_clientes) REFERENCES clientes(id) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ordenes(
    id INT AUTO_INCREMENT,
    codigo VARCHAR(15) UNIQUE NOT NULL,
    id_vehiculos INT,
    descripcion TEXT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_anulacion DATETIME,
    fecha_cierre DATETIME,
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_ordenes_pk PRIMARY KEY(id),

    CONSTRAINT id_vehiculos_fk FOREIGN KEY(id_vehiculos) REFERENCES vehiculos(id) MATCH FULL
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE observaciones(
    id INT AUTO_INCREMENT,
    id_ordenes INT,
    descripcion TEXT,
    imagen VARCHAR(500),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_observaciones_pk PRIMARY KEY(id),

    CONSTRAINT id_ordenes_fk FOREIGN KEY(id_ordenes) REFERENCES ordenes(id) MATCH FULL
    ON DELETE CASCADE on UPDATE CASCADE
);

CREATE TABLE accesorios(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_accesorios_pk PRIMARY KEY(id)
);


-- TABLAS PUENTE

CREATE TABLE ordenes_empleados(
    id_ordenes INT,
    id_empleados INT,

    CONSTRAINT ordenes_empleados_pk PRIMARY KEY (id_ordenes,id_empleados),

    CONSTRAINT id_ordenes1_fk FOREIGN KEY (id_ordenes) REFERENCES ordenes(id) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT id_empleados1_fk FOREIGN KEY (id_empleados) REFERENCES empleados(id) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE ordenes_accesorios(
    id_ordenes INT,
    id_accesorios INT,

    CONSTRAINT ordenes_accesorios_pk PRIMARY KEY(id_ordenes, id_accesorios),

    CONSTRAINT id_ordenes2_fk FOREIGN KEY(id_ordenes) REFERENCES ordenes(id) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT id_accesorios2_fk FOREIGN KEY(id_accesorios) REFERENCES accesorios(id) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);
-- -----------------------




/* INVENTARIO Y FACTURACION */

/* Tablas Padre */

CREATE TABLE categorias(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE,
    descripcion VARCHAR(255) DEFAULT 'N/A',
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_categorias_pk PRIMARY KEY(id)
);

CREATE TABLE unidades(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE,
    abreviatura VARCHAR(5),
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_categorias_pk PRIMARY KEY(id)    
);

CREATE TABLE productos(
    id INT AUTO_INCREMENT,
    categoria_id INT,
    unidad_id INT,
    codigo VARCHAR(15) UNIQUE,

    nombre VARCHAR(50) UNIQUE,
    descripcion VARCHAR(255) DEFAULT NULL,
    precio_venta DECIMAL(10,2),
    precio_porcentaje DECIMAL(4,2),
    stock INT DEFAULT '0',
    stock_min INT DEFAULT '0',
    stock_max INT DEFAULT '0',
    -- imagen VARCHAR(255) DEFAULT NULL,
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_productos_pk PRIMARY KEY(id),
    
    CONSTRAINT categoria_id_fk FOREIGN KEY(categoria_id) REFERENCES categorias(id) MATCH FULL
    ON UPDATE CASCADE ON DELETE SET NULL,

    CONSTRAINT unidad_id_fk FOREIGN KEY(unidad_id) REFERENCES unidades(id) MATCH FULL
    ON UPDATE CASCADE ON DELETE SET NULL
);


CREATE TABLE proveedores(
    id INT AUTO_INCREMENT,
    documento VARCHAR(15) UNIQUE,
    razon_social VARCHAR(50),
    direccion VARCHAR(255),
    telefono VARCHAR(15),
    email VARCHAR(100),
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_proveedores_pk PRIMARY KEY(id)
);

CREATE TABLE compras(
    id INT AUTO_INCREMENT,
    proveedor_id INT,
    -- usuario_id INT,
    num_compra VARCHAR(12) UNIQUE,
    num_documento_referencia VARCHAR(50) DEFAULT "N/A",
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_compras_pk PRIMARY KEY(id),
    
    CONSTRAINT proveedor_id_fk FOREIGN KEY(proveedor_id) REFERENCES proveedores(id) MATCH FULL
    ON DELETE SET NULL ON UPDATE CASCADE

    -- CONSTRAINT usuarioCompra_id_fk FOREIGN KEY(usuario_id) REFERENCES usuarios(id) MATCH FULL
    -- ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE entradas(
    id INT AUTO_INCREMENT,
    compra_id INT,
    producto_id INT,

    cantidad INT,
    precio DECIMAL(10,2),
    estatus VARCHAR(15) DEFAULT 'ACTIVO',


    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_detalle_compras_pk PRIMARY KEY(id, compra_id),
    
    CONSTRAINT compra_id_fk FOREIGN KEY(compra_id) REFERENCES compras(id) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT producto_detalleCompra_id_fk FOREIGN KEY(producto_id) REFERENCES productos(id) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE ventas(
    id INT AUTO_INCREMENT,
    cliente_id INT,
    usuario_id INT,
    num_venta VARCHAR(12) UNIQUE,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    impuesto DECIMAL(3,2) DEFAULT NULL,
    total DECIMAL(10,2),
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_compras_pk PRIMARY KEY(id),
    
    CONSTRAINT cliente_id_fk FOREIGN KEY(cliente_id) REFERENCES clientes(id) MATCH FULL
    ON DELETE SET NULL ON UPDATE CASCADE,

    CONSTRAINT usuarioVenta_id_fk FOREIGN KEY(usuario_id) REFERENCES usuarios(id) MATCH FULL
    ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE salidas(
    id INT AUTO_INCREMENT,
    venta_id INT,
    producto_id INT,

    cantidad INT,
    precio DECIMAL(10,2),
    descuento DECIMAL(3,2) DEFAULT '0.00',
    estatus VARCHAR(15) DEFAULT 'ACTIVO',


    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_detalle_ventas_pk PRIMARY KEY(id, venta_id),
    
    CONSTRAINT venta_id_fk FOREIGN KEY(venta_id) REFERENCES ventas(id) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT producto_detalleVenta_id_fk FOREIGN KEY(producto_id) REFERENCES productos(id) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE impuestos(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE,
    valor DECIMAL(4,2) NOT NULL,
    estatus VARCHAR(15) DEFAULT 'ACTIVO',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT id_impuestos PRIMARY KEY(id)
);

/* Disparadores */

CREATE TRIGGER actualizar_precio_producto 
AFTER INSERT ON entradas FOR EACH ROW
	UPDATE productos SET precio_venta = (NEW.precio * (precio_porcentaje / 100)+ NEW.precio) WHERE id = NEW.producto_id;

/* Vistas*/

CREATE VIEW v_entradas AS SELECT p.id, p.codigo, p.nombre, IF(e.estatus = 'ACTIVO', SUM(e.cantidad),0) as total_entrada FROM
productos p
	LEFT JOIN
entradas e
    ON p.id = e.producto_id AND e.estatus = 'ACTIVO'
WHERE p.estatus = 'ACTIVO'
GROUP BY p.id, p.codigo, p.nombre;

CREATE VIEW v_salidas AS SELECT p.id, p.codigo, p.nombre, IF(s.estatus = 'ACTIVO', SUM(s.cantidad),0) as total_salida FROM
productos p
	LEFT JOIN
salidas s
    ON p.id = s.producto_id AND s.estatus = 'ACTIVO'
WHERE p.estatus = 'ACTIVO'
GROUP BY p.id, p.codigo, p.nombre;

CREATE VIEW v_inventario AS SELECT p.id, p.codigo, p.nombre, c.nombre AS categoria, p.precio_venta, IFNULL(e.total_entrada - s.total_salida,0) AS stock, p.stock_min, p.stock_max, p.estatus FROM
productos p
	LEFT JOIN
v_entradas e
	ON p.id = e.id
    LEFT JOIN
v_salidas s 
	ON p.id = s.id
    JOIN
categorias c 
	ON p.categoria_id = c.id
WHERE p.estatus = 'ACTIVO'
GROUP BY p.id, p.codigo, p.nombre, p.precio_venta, p.stock_min, p.stock_max
ORDER BY p.created_at DESC;



/* Insertar Registros Iniciales */

/* (IMPORTANTE) Registrar Accesorios */
INSERT INTO accesorios(nombre, estatus) VALUES
('REPRODUCTOR','ACTIVO'),
('LIMPIA PARABRISAS','ACTIVO'),
('CAUCHO DE RECUESTO','ACTIVO'),
('ANTENA','ACTIVO'),
('TAPIZ INTERIOR','ACTIVO'),
('EXTINTOR','ACTIVO'),
('CINTURONES','ACTIVO'),
('ALFOMBRAS','ACTIVO'),
('ENCENDEDOR','ACTIVO'),
('TRIANGULO DE SEGURIDAD','ACTIVO'),
('PARASOLES','ACTIVO'),
('CAJA DE HERRAMIENTAS','ACTIVO'),
('AIRE ACONDICIONADO','ACTIVO'),
('GPS','ACTIVO'),
('ALARMA','ACTIVO');


-- USUARIO
INSERT INTO usuarios(documento, nombre, apellido, direccion, telefono, email, usuario, password, estatus)
VALUES ('V-00000000', 'ADMINISTRADOR', 'ADMINISTRADOR', 'HIDROPARTS','000-0000000', 'administrador@email.com', 'administrador', 'bWxzUFhsenNNTERQQUdXY21odG0rdz09', 'ACTIVO');

-- CLIENTES
INSERT INTO clientes(documento, nombre, apellido, direccion, telefono, email, estatus) VALUES
('V-26945214', 'JOSNERY', 'DIAZ', 'LOS CREPUSCULOS', '000-1234567', 'josnery@gmail.com', 'ACTIVO'),
('V-27025411', 'MARIA', 'BETANCOURT', 'DON AURELIO', '000-1234567', 'maria@gmail.com', 'ACTIVO'),
('V-26540950', 'JESUS', 'ARRIECHE', 'DUACA', '000-1234567', 'jesus@gmail.com', 'ACTIVO');

-- EMPLEADOS
INSERT INTO empleados(documento, nombre, apellido, direccion, telefono, email, cargo, estatus) VALUES
('V-26945214', 'JUAN', 'DIAZ', 'LOS CREPUSCULOS', '000-1234567', 'josnery@gmail.com', 'ADMINISTRADOR', 'ACTIVO'),
('V-27025411', 'PEDRO', 'BETANCOURT', 'DON AURELIO', '000-1234567', 'maria@gmail.com', 'MECANICO', 'ACTIVO'),
('V-26540950', 'CARLOS', 'ARRIECHE', 'DUACA', '000-1234567', 'jesus@gmail.com', 'AYUDANTE MECANICO', 'ACTIVO');

-- MARCAS
INSERT INTO marcas(nombre, estatus) VALUES
('FORD', 'ACTIVO'),
('FIAT', 'ACTIVO'),
('TOYOTA', 'ACTIVO');

-- MODELOS
INSERT INTO modelos(id_marcas, nombre, estatus) VALUES
('1','FIESTA', 'ACTIVO'),
('1','F-150', 'ACTIVO'),
('1','FOCUS', 'ACTIVO'),
('2','PALIO', 'ACTIVO'),
('2','TUCAN', 'ACTIVO'),
('2','SIENA', 'ACTIVO'),
('3','COROLLA', 'ACTIVO'),
('3','4RUNNER', 'ACTIVO'),
('3','FORTUNER', 'ACTIVO');



/* Inventario */

INSERT INTO impuestos(nombre, valor) VALUES ('iva', '12.00'), ('iva2', '16.00');

INSERT INTO proveedores(documento, razon_social, direccion, telefono, email) VALUES
('J-26540950', 'MICROTECH', 'BARQUISIMETO', '0424-5294781', 'microtech@gmail.com'),
('J-26543456', 'CARFORD', 'CARACAS', '0424-5294781', 'Cardford@gmail.com'),
('J-26523234', 'SUPER CAR', 'BARINAS', '0424-5294781', 'supercar@gmail.com');


INSERT INTO unidades(nombre, abreviatura) VALUES
('PIEZA', 'pza'),
('METRO', 'm'),
('LITRO', 'l');

INSERT INTO categorias(nombre, descripcion) VALUES
('RODAMIENTOS', 'RODAMIENTOS EN GENERAL'),
('CAJAS', 'CAJAS EN GENERAL'),
('MOTORES', 'MOTORES EN GENERAL');

INSERT INTO productos(categoria_id, unidad_id, codigo, nombre, precio_porcentaje) VALUES 
('3', '1', 'P456125', 'MOTOR V6', '30'),
('3', '1', 'P456123', 'MOTOR V4', '30'),
('3', '1', 'P456154', 'MOTOR V10', '30'),
('2', '1', 'P456165', 'CAJA VR56', '30'),
('2', '1', 'P456187', 'CAJA RX34', '30');

/* Roles */
INSERT INTO roles(nombre, descripcion) VALUES ('super admin', 'todos los permisos del sistema');

/* Cargando Permisos */
INSERT INTO permisos(nombre) VALUES 
('usuarios'),
('registrar usuarios'),
('editar usuarios'),
('eliminar usuarios'),

('clientes'),
('registrar clientes'),
('editar clientes'),
('eliminar clientes'),

('empleados'),
('registrar empleados'),
('editar empleados'),
('eliminar empleados'),

('vehiculos'),
('registrar vehiculos'),
('editar vehiculos'),
('eliminar vehiculos'),

('ordenes'),
('registrar ordenes'),
('editar ordenes'),
('anular ordenes'),

('inventario'),

('categorias'),
('registrar categorias'),
('editar categorias'),
('eliminar categorias'),

('productos'),
('registrar productos'),
('editar productos'),
('eliminar productos'),

('proveedores'),
('registrar proveedores'),
('editar proveedores'),
('eliminar proveedores'),

('compras'),
('registrar compras'),
('anular compras'),

('ventas'),
('registrar ventas'),
('anular ventas'),

('reportes'),

('roles'),
('registrar roles'),
('editar roles'),
('eliminar roles');

/* Roles con permisos*/
INSERT INTO roles_con_permisos(rol_id, permiso_id) VALUES 
('1','1'),
('1','2'),
('1','3'),
('1','4'),
('1','5'),
('1','6'),
('1','7'),
('1','8'),
('1','9'),
('1','10'),
('1','11'),
('1','12'),
('1','13'),
('1','14'),
('1','15'),
('1','16'),
('1','17'),
('1','18'),
('1','19'),
('1','20'),
('1','21'),
('1','22'),
('1','23');
