

angular.module('appLogin' , [])

.controller('ctrlLogin',function($scope,$http){
	$scope.params = {
		usu : '',
		pass : ''
	}
	$scope.Iniciarsesion = function(){	
	
		if ($scope.params.usu.length == 0) {
			     new PNotify({
                title: 'Alerta',
                text: 'Ingresar usuario . . ',
                type: 'info'
            });
			return;
		}else if ($scope.params.pass.length == 0){
				     new PNotify({
                title: 'Alerta',
                text: 'Ingresar contraseña . . ',
                type: 'info'
            });
			return;
		};
	$scope.showLoad = true;	
		
		var params = {
			usu : $scope.params.usu,
			pass : $scope.params.pass
		}
		
		var url = "http://167.250.205.67/Controladores/LogIn.php";
	    $http.post(url,params,{
	              headers : {
	                'Content-Type' : 'application/x-www-form-urlencoded; charset=UTF-8'
	            }}).success(function(result){

	            	$scope.showLoad = false;
	            	if (result[0] == "ERROR") {
	            			     new PNotify({
                title: 'Alerta',
                text: 'Datos ingresados incorrectos ! !',
                type: 'error'
            });
	            		return;
	            	};
	            	localStorage.setItem('dataUser', JSON.stringify(result));
	            	var urlUsu = result[0].NOMBRE_PERSONA + ' ' + result[0].APELLIDOS_PERSONA + '|' + result[0].ID_PERSONA

	            	location.href = "menu.html?" + urlUsu
	            	
	            }).error(function(err){
	            	
	            })
	}
})