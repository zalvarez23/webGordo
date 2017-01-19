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
var urls = "http://vmwaresis.com.pe/movil/Controladores/";

angular.module('MyApp', ['ngMap'])

.controller('ctrlIndex',function($scope,$http,$timeout,NgMap,$rootScope,$timeout){

	var dataUser = JSON.parse(localStorage.getItem('dataUser'))[0];
	$scope.userName = dataUser.NOMBRE_PERSONA + ' ' + dataUser.APELLIDOS_PERSONA;
	


	$scope.listaActividades = function(){		

		var params = {
			condicion : condicion,
			fe_ini : fechaini.value.split('/').reverse().join('-'),
			//fe_ini : '01-01-2015',
			fe_fin : fechafin.value.split('/').reverse().join('-'),
			co_tecn : co_tecn
		}
		var url = urls + "listaActividadesWeb.php";
		
		$http.post(url,params,{
	              headers : {
	                'Content-Type' : 'application/x-www-form-urlencoded; charset=UTF-8'
	            }}).success(function(result){

	            	$scope.listActividades = [];
	            	$scope.listActividades = result;

	            	angular.forEach(result, function(item, key) {
						    if (item.st_acti == 1) {
						    	if (item.status == 0) {
						    		item.estadoDes = 'Descartado';
						    	}else{
						    		item.estadoDes = 'Pendiente';
						    	}
						    }else if(item.st_acti == 2){
						      item.estadoDes = 'Proceso';
						    }else if(item.st_acti == 0){
						    	item.estadoDes = 'Concretado'
						    };	            		
	            	
	            	})            
	            	
	            	$scope.showLoadingAct= false
	            }).error(function(err){
	            	
	            })
	}

})

