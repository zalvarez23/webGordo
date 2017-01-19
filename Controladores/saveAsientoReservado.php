<?php 

header("Access-Control-Allow-Origin: *");
/*Incluimos el fichero de la clase*/
require_once '../Conexion/conexion.php';


/*Creamos una query sencilla*/
$objDatos = json_decode(file_get_contents("php://input"));

$id_destino= $objDatos->id_destino;
$asientos= $objDatos->asientos;


$sql    = "UPDATE `tesis`.`destinos` SET `ASIENTOS_RESERVADOS` = '$asientos' WHERE `destinos`.`ID_DESTINO` = '$id_destino';";
            $objc   =   new ConexionAsistencia();
            $cn     =   $objc->getConexionBD();
            mysql_query("set names 'utf8'");
            $rs     = mysql_query($sql, $cn);

      echo 'success';

?>