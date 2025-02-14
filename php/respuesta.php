<?php
	class respuesta {
		public $ok = 1;
		public $resultado;

		public function error($mensaje) {
			$this->ok = 0;
			$this->resultado = $mensaje;
		}
	}
?>