<?php 

header("Access-Control-Allow-Origin: *");
/*Incluimos el fichero de la clase*/
require_once '../Conexion/conexion.php';


/*Creamos una query sencilla*/
$objDatos = json_decode(file_get_contents("php://input"));

$nombres= $objDatos->nombres;
$apellidos= $objDatos->apellidos;
$dni= $objDatos->dni;
$edad= $objDatos->edad;
$direccion= $objDatos->direccion;
$usuario= $objDatos->usuario;
$pass= $objDatos->pass;


$sql    = "call sp_newUsuasrio('$nombres','$apellidos','$dni','$edad','$direccion','$usuario','$pass')";
            $objc   =   new ConexionAsistencia();
            $cn     =   $objc->getConexionBD();
            mysql_query("set names 'utf8'");
            $rs     = mysql_query($sql, $cn);

      echo 'success';

?>