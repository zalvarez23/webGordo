<?php 

header("Access-Control-Allow-Origin: *");
/*Incluimos el fichero de la clase*/
require_once '../Conexion/conexion.php';


/*Creamos una query sencilla*/
$objDatos = json_decode(file_get_contents("php://input"));

$ID_USUARIO= $objDatos->ID_USUARIO;
$ID_DESTINO= $objDatos->ID_DESTINO;
$FECHA_RESERVA = $objDatos->FECHA_RESERVA;
$HORA_RESERVA = $objDatos->HORA_RESERVA;
$CANTIDAD = $objDatos->CANTIDAD;
$PRECIO_TOTAL = $objDatos->PRECIO_TOTAL;
$ESTADO_RESERVA = $objDatos->ESTADO_RESERVA;
$ASIENTOS_RESERVADOS = $objDatos->ASIENTOS_RESERVADOS;
$ID_PERSONA = $objDatos->ID_PERSONA;



$sql    = "INSERT INTO `tesis`.`reservas` (`ID_RESERVAS`, `ID_USUARIO`, `ID_PERSONA`, `ID_DESTINO`, `FECHA_RESERVA`, `HORA_RESERVA`, `CANTIDAD`, `PRECIO_TOTAL`, `ESTADO_RESERVA` , `ASIENTOS_RESERVADOS`) VALUES (NULL, '$ID_USUARIO', '$ID_PERSONA', '$ID_DESTINO', '$FECHA_RESERVA', '$HORA_RESERVA', '$CANTIDAD', '$PRECIO_TOTAL', '$ESTADO_RESERVA', '$ASIENTOS_RESERVADOS');";
            $objc   =   new ConexionAsistencia();
            $cn     =   $objc->getConexionBD();
            mysql_query("set names 'utf8'");
            $rs     = mysql_query($sql, $cn);

      echo 'success';

?>