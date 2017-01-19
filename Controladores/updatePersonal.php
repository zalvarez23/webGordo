<?php 

header("Access-Control-Allow-Origin: *");
/*Incluimos el fichero de la clase*/
require_once '../Conexion/conexion.php';


/*Creamos una query sencilla*/
$objDatos = json_decode(file_get_contents("php://input"));

$nombres= $objDatos->nombres;
$apellidos= $objDatos->apellidos;
$edad= $objDatos->edad;
$sexo= $objDatos->sexo;
$direccion= $objDatos->direccion;
$idpersona= $objDatos->idpersona;

$sql    = "UPDATE `PERSONA` SET `NOMBRE_PERSONA`='$nombres',`APELLIDOS_PERSONA`='$apellidos',`EDAD`='$edad',`SEXO`='$sexo', `DIRECCION`='$direccion' WHERE `ID_PERSONA` = '$idpersona'";
            $objc   =   new ConexionAsistencia();
            $cn     =   $objc->getConexionBD();
            mysql_query("set names 'utf8'");
            $rs     = mysql_query($sql, $cn);

      echo 'success';

?>