<?php 

header("Access-Control-Allow-Origin: *");
/*Incluimos el fichero de la clase*/
require_once '../Conexion/conexion.php';


/*Creamos una query sencilla*/
$objDatos = json_decode(file_get_contents("php://input"));

$codTarea = $objDatos->codTarea;
$src = $objDatos->src;
$comentario = $objDatos->comentario; 
$no_marc = $objDatos->no_marc;
$nu_ip = $objDatos->nu_ip;
$ms_red = $objDatos->ms_red;
$no_mode = $objDatos->no_mode;
$pu_enla = $objDatos->pu_enla;
$st_tran = $objDatos->st_tran;
$nu_seri = $objDatos->nu_seri;
$st_grab = $objDatos->st_grab;
$no_mac = $objDatos->no_mac;
$no_desc = $objDatos->no_desc;
$no_reco = $objDatos->no_reco;

$sql    = "UPDATE `tdfoto_tare` SET `de_come_foto`='$comentario',`no_marc`='$no_marc',`nu_ip`='$nu_ip',`ms_red`='$ms_red',`no_mode`='$no_mode',`pu_enla`='$pu_enla',`st_tran`='$st_tran',`nu_seri`='$nu_seri',`st_grab`='$st_grab',`no_mac`='$no_mac',`no_desc`='$no_desc',`no_reco`='$no_reco' WHERE co_tare = '$codTarea' and no_foto = '$src'";

            $objc   =   new ConexionAsistencia();
            $cn     =   $objc->getConexionBD();
            mysql_query("set names 'utf8'");
            $rs     = mysql_query($sql, $cn);

      echo 'success';



?>