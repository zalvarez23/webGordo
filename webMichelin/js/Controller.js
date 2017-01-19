var urlApi = "http://167.250.205.67/Controladores/";
function getVariables(){

	var datos = location.search; 
	datos = datos.substr(1,datos.length); 
	var arrVariables = datos.split("|"); 
	return arrVariables
}
function getDateHoy(){
  var hoy = new Date();
var dd = hoy.getDate();
var mm = hoy.getMonth()+1; //hoy es 0!
var yyyy = hoy.getFullYear();
if(dd<10) {
    dd='0'+dd
} 

if(mm<10) {
    mm='0'+mm
} 
  hoy = yyyy+'-'+mm+'-'+dd;
  return hoy;
}


angular.module('MyApp', ['ngMap'])

.controller('ctrlIndex',function($scope,$http,$timeout,NgMap,$rootScope,$timeout){

	setTimeout(function () {
        $(document).ready(function () {
           
            $('input.FormatoFecha').datepicker({
                language: "es",
                format: "dd/mm/yyyy",
                autoclose: true
            });
        });
    }, 100);
	var dataUser = JSON.parse(localStorage.getItem('dataUser'))[0];
	$scope.userName = dataUser.NOMBRE_PERSONA + ' ' + dataUser.APELLIDOS_PERSONA;
	$scope.dataUser = dataUser;
	$scope.reservaShow = true;
	$scope.atrasShow = false;
	$scope.nuevaReserva = function(){
		$scope.reservaShow = false;
		$scope.atrasShow = true;
	}
	 $scope.paramsReserva = {
	    idOrigen : '',
	    idDestino : '',
	    idtipo : '',
	    fechaP : '',
	    fechaR : '',
	  }	
    $scope.listSalidas = [
      {id : 1, des: 'Ida'},
      {id : 2, des: 'Ida / Retorno'},
    ]
	$scope.volver= function(){
		$scope.reservaShow = true;
		$scope.atrasShow = false;
	}
	$scope.changeValueSalida  = function(){
		console.log($scope.paramsReserva.idtipo)
		if ($scope.paramsReserva.idtipo == 1) {
			$scope.showFechaRetorno = false;
		}else{
			$scope.showFechaRetorno = true;
		}
	}
	$scope.getCiudades = function(){

	    var url = urlApi + 'listCiudades.php';    
	    $http.get(url,{
	              headers : {
	             'Content-Type' : 'application/x-www-form-urlencoded; charset=UTF-8'
	            }}).success(function(result){  
	            console.log(result)            
	              $scope.listCiudades = result;
	            })  
	            .error(function(err){
	              console.log(err)
	            }) 
	  }
    $scope.getHistorial = function(){
     var url = urlApi + 'listHistorial.php';
     var params = {
      pesona : dataUser.ID_PERSONA
    }
    
    $http.post(url,params,{
              headers : {
                'Content-Type' : 'application/x-www-form-urlencoded; charset=UTF-8'
            }}).success(function(result){
              if (result[0] == "ERROR") {
                $scope.cantidadReservas = 0;
                $scope.puntosRealizados = 0;
                return;
              }          
              $scope.cantidadReservas = result.length;
              $scope.puntosRealizados = 100 * parseInt(result.length);
            }).error(function(err){
               $ionicPopup.alert({
                  title : 'Error . .',
                  template : 'Ocurrio un problema con la conexión..'
                })
            })
    }	  

  	$scope.getReservas = function(){
  	var fechaP = $scope.paramsReserva.fechaP.split('/').reverse().join('-');
  	var fechaR = $scope.paramsReserva.fechaR.split('/').reverse().join('-');  	
  	var params = {
  	    idOrigen : $scope.paramsReserva.idOrigen,
	    idDestino : $scope.paramsReserva.idDestino,
	    idtipo : $scope.paramsReserva.idtipo,
	    fechaP : fechaP,
	    fechaR : fechaR
  	}
    var url = urlApi + 'listViajes.php';    
	    $http.post(url,params,{
	              headers : {
	             'Content-Type' : 'application/x-www-form-urlencoded; charset=UTF-8'
	            }}).success(function(result){
	            	console.log(result)
	            	if (result[0] == "ERROR") {
	            		$scope.listViajes = [];
	            		return;
	            	}
					console.log(result);
					$scope.listViajes = result;
	            })  
	            .error(function(err){
	              console.log(err)
	            })    		
  	}

  	$scope.getCiudades();
  	$scope.getHistorial();


})

