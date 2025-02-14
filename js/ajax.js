class Ajax {
	constructor(listener) {
		this.listener = listener
	}

	post(datos, funcion) {
		let xhttp = new XMLHttpRequest()

		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				// console.log(this.responseText);
				funcion(this.responseText);
			} else {
				// Mostrar mensaje en caso de no haber conexión con el servidor
				console.log("Status: ", this.status);
			}
				
		}
		xhttp.open("POST", this.listener, true)
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhttp.send("datos=" + JSON.stringify(datos))
	};

}