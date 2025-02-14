<?php
require_once("BD.php");

class usuarios extends BD {
	public function __construct(){
		try { parent::__construct("localhost", "crud", "root", ""); }
		catch (Exception $e) { $this->ok = false; }
	}

	public function ALTAS($datos){
		return "CALL ALTAS('$datos->id', '$datos->nombre', '$datos->pApellido', '$datos->sApellido',
			'$datos->login', '$datos->pwd');";
	}

	public function BAJAS($datos){
		return "CALL BAJAS('$datos->id');";
	}

	public function CAMBIOS($datos){
		return "CALL CAMBIOS('$datos->id', '$datos->nombre', '$datos->pApellido', '$datos->sApellido',
			'$datos->login', '$datos->pwd');";
	}

	public function CONSULTAS($datos){
		return "CALL CONSULTAS($datos->pagina);";
	}

	public function CONSULTAS_ID($datos){
		return "CALL CONSULTAS_ID('$datos->id');";
	}
}
?>