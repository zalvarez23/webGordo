<?php
header("Access-Control-Allow-Origin: *");
/*Incluimos el fichero de la clase2*/
require_once '../Conexion/conexion.php';


/*Creamos una query sencilla*/
$objDatos = json_decode(file_get_contents("php://input"));

$idtipo= $objDatos->idtipo;
$idOrigen= $objDatos->idOrigen;
$idDestino= $objDatos->idDestino;
$fechaP= $objDatos->fechaP;
$fechaR= $objDatos->fechaR;

$sql    =  "call sp_listViajes('$idtipo','$idOrigen','$idDestino','$fechaP','$fechaR')";
            $objc   =   new ConexionAsistencia();
            $cn     =   $objc->getConexionBD();
            $rs     = mysql_query($sql, $cn);

if (mysql_num_rows($rs)){
/*Realizamos un bucle para ir obteniendo los resultados*/

    while($row = mysql_fetch_assoc($rs))
    {  
        $records[]=array_map('utf8_encode',$row );
       
    }
    echo  json_encode($records);
} else {
     $records[]='ERROR';
    echo json_encode($records);
}

?>