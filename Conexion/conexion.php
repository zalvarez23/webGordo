<?php

class ConexionAsistencia {
    const SERVER    ="localhost";
    const USER      ="root";
    const PASS      ="";
    const DATABASE  ="tesis";
    private $cn     =null;
    
    public function getConexionBD(){
        
        try {
        
            $this->cn=
                     @mysql_connect(self::SERVER, self::USER, self::PASS) or die('no conecto a la base de datos');
                     @mysql_select_db(self::DATABASE, $this->cn) or die('no se selecciono la base de datos');
                  
        } catch (Exception $exc) {
            echo $exc->getTraceAsString();
        }
        return $this->cn;
            
    }
            
}

?>