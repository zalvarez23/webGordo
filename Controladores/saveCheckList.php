<?php 

header("Access-Control-Allow-Origin: *");
/*Incluimos el fichero de la clase*/
require_once '../Conexion/conexion.php';


/*Creamos una query sencilla*/
$objDatos = json_decode(file_get_contents("php://input"));

$id_supervisor= $objDatos->id_supervisor;
$fecha= $objDatos->fecha;
$unidad= $objDatos->unidad;
$hora= $objDatos->hora;
$observacion= $objDatos->observacion;
$ubicacion= $objDatos->ubicacion;
$listCheck= $objDatos->listCheck;

$sql    = "call SP_SAVE_CHECKLIST('$id_supervisor','$fecha','$unidad','$hora','$observacion','$ubicacion','$listCheck')";
            $objc   =   new ConexionAsistencia();
            $cn     =   $objc->getConexionBD();
            mysql_query("set names 'utf8'");
            $rs     = mysql_query($sql, $cn);

      echo 'success';

?>