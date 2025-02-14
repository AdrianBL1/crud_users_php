<?php
require_once("BD.php");

class globales extends BD {
	public function __construct(){
		try { parent::__construct("localhost", "globales", "root", ""); }
		catch (Exception $e) { $this->ok = false; }
	}

	public function CONSTANTES(){
		return "CALL CONSTANTES_CONSULTAS();";
	}

	public function MENSAJES($datos){
		return "CALL MENSAJES_CONSULTAS($datos->modulo);";
	}
}
?>