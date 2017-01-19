<?php 

header("Access-Control-Allow-Origin: *");
/*Incluimos el fichero de la clase*/
require_once '../Conexion/conexion.php';


/*Creamos una query sencilla*/
$objDatos = json_decode(file_get_contents("php://input"));

$usu= $objDatos->usu;
$pass= $objDatos->pass;

$sql    =  "SELECT * FROM `tbl_usuario` WHERE usu = '$usu' and pass = '$pass'";
            $objc   =   new ConexionAsistencia();
            $cn     =   $objc->getConexionBD();
            $rs     = mysql_query($sql, $cn);

if (mysql_num_rows($rs)){
/*Realizamos un bucle para ir obteniendo los resultados*/

    while($row = mysql_fetch_assoc($rs))
    {  
        $records[]=array_map('utf8_encode',$row );
       
    }
    echo $_GET['jsoncallback'].  json_encode($records);
} else {
     $records[]='ERROR';
    echo $_GET['jsoncallback'].json_encode($records);
}

?>