<?php 

header("Access-Control-Allow-Origin: *");
/*Incluimos el fichero de la clase*/
require_once '../Conexion/conexion.php';


/*Creamos una query sencilla*/
$objDatos = json_decode(file_get_contents("php://input"));

$id_reserva= $objDatos->id_reserva;
$puntaje= $objDatos->puntaje;


$sql    = "UPDATE `tesis`.`reservas` SET `puntaje` = '$puntaje' WHERE `reservas`.`ID_RESERVAS` = '$id_reserva';";
            $objc   =   new ConexionAsistencia();
            $cn     =   $objc->getConexionBD();
            mysql_query("set names 'utf8'");
            $rs     = mysql_query($sql, $cn);

      echo 'success';

?>