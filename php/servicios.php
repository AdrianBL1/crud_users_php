<?php
spl_autoload_register(function ($class){
	if(file_exists("$class.php"))
		require_once("$class.php");
});

class servicios {
	protected $datos;

	public function __construct($DATA) {
		$respuesta = new stdClass();

		if(array_key_exists("datos", $DATA)) { // Verifico que en el paquete recibido venga el dato: datos
			try { $this->datos = json_decode($DATA["datos"]); } // Recupero datos y convierto a objeto PHP
			catch(Exception $e) { $this->datos = NULL; }; // Falló la conversión de JSON a objeto PHP

			if(!is_null($this->datos)){
				// Verifico que el servicio venga indicado y que sea conocido:
				if(property_exists($this->datos, "servicio") && method_exists($this, $this->datos->servicio)){
					// Verifico que los parámetros sean correctos
					if($this->parametros_ok($this->datos)) {
						$servicio =  $this->datos->servicio;

						try {$respuesta->resultado = $this->$servicio($this->datos);}
						catch(Exception $e) { "Error de procesamiento. ". $respuesta->resultado = $e->getMessage();}
					}
					else $respuesta->resultado = "Parámetros incorrectos";
				}
				else $respuesta->resultado = "Servicio desconocido";
			}
			else $respuesta->resultado = "Formato de datos incorrecto";
		}
		else $respuesta->resultado = "Error en los datos";
		echo json_encode($respuesta); // Devuelvo la respuesta al cliente
	}

	private function parametros_ok($datos) {
		$parametros = $this->parametros($datos->servicio);
		foreach ($parametros as $parametro => $tipo)
			if(!property_exists($datos, $parametro) || gettype($datos->$parametro) != $tipo)
				return false;
		return true;
	}

		public function parametros($servicio) {
			switch($servicio) {
				case "ALTAS":
				case "CAMBIOS":
						return ["id" => "string", "nombre" => "string", "pApellido" => "string",
					"sApellido" => "string", "login" => "string", "pwd" => "string"];
				case "BAJAS":
				case "CONSULTAS_ID":
					return ["id" => "string"];
				case "CONSULTAS":
					return ["pagina" => "integer"];
				case "MENSAJES":
					return ["modulo" => "integer"];
				default: return [];
			}
		}

	private function ALTAS($datos) {
		return (new usuarios())->CONSULTAR($datos);
	}

	private function BAJAS($datos) {
		return (new usuarios())->CONSULTAR($datos);
	}

	private function CAMBIOS($datos) {
		return (new usuarios())->CONSULTAR($datos);
	}

	private function CONSULTAS($datos) {
		return (new usuarios())->CONSULTAR($datos);
	}

	private function CONSULTAS_ID($datos) {
		return (new usuarios())->CONSULTAR($datos);
	}

	private function CONSTANTES($datos) {
		return (new globales())->CONSULTAR($datos);
	}

	private function MENSAJES($datos) {
		return (new globales())->CONSULTAR($datos);
	}
}
if(count($_POST)) new servicios($_POST);
else {
	$handle = fopen('php://input','r');
	$POST = fgets($handle);
	new servicios(["datos" => $POST]);
}
?>