class crud {
    guardar() {
        var datos = UI.recuperar("id", "nombre", "pApellido", "sApellido", "login", "pwd")
        // console.log(datos)
        if (self.validar(datos) == true) {
            datos.servicio = "ALTAS"
            console.log(datos)

            ajax.post(datos, this.resultado)
            console.log("Enviado: ", datos)
        }
    }

    editar(){
        var datos = UI.recuperar("id", "nombre", "pApellido", "sApellido", "login", "pwd")
        // console.log(datos)
        if (self.validar(datos) == true) {
            datos.servicio = "CAMBIOS"
            console.log(datos)
            ajax.post(datos, this.resultado)
        }
    }

    eliminar(id_r){
        var peticion = UI.recuperar("id")

        if (peticion.id === ""){
            peticion.id = id_r
        }
        
        peticion.servicio = "BAJAS"
        console.log(peticion)
        ajax.post(peticion, this.resultado)
    }

    consultarDatos(numPagina) {
        var peticion = new Object();
        
        peticion.servicio = "CONSULTAS"
        peticion.pagina = parseInt(numPagina)
        console.log(peticion)

        ajax.post(peticion, this.resultadoDatos)
    }

    consultarDatosID(id_r){
        var peticion = UI.recuperar("id")

        if (peticion.id === ""){
            peticion.id = id_r
        }
        
        peticion.servicio = "CONSULTAS_ID"
        console.log(peticion)

        ajax.post(peticion, this.llenarFormulario)
    }

    resultado(r) {
        // Convierto el objeto json de la respuesta a un objeto Javascript
        var datosRecibidos = JSON.parse(r)

        // A consola para verificar
        console.log("Respuesta recibida: ", datosRecibidos.resultado.resultado);

        UI.mostrarNotificacion(`RESPUESTA RECIBIDA: ${datosRecibidos.resultado.resultado}`)

        //TODO: VERIFICAR RESPUESTAS RECIBIDAS DEL SERVIDOR
    }

    resultadoDatos(datosRecibidos) {
        limpiarTabla();

        var datos = JSON.parse(datosRecibidos)

        // Recorrer los datos recibidos y crear las filas de la tabla
        datos.resultado.forEach(function (usuario) {
            var fila = document.createElement("tr");

            var columnas = ["id", "nombre", "pApellido", "sApellido", "login"];
            columnas.forEach(function (columna) {
                var td = document.createElement("td");
                td.textContent = usuario[columna];
                fila.appendChild(td);
            });

            var tdAcciones = crearBotonesEditarEliminar(usuario.id);
            fila.appendChild(tdAcciones);

            UI.tablaContenido.appendChild(fila);
        });
    }

    llenarFormulario(datosRecibidos){

        var datos = JSON.parse(datosRecibidos)
        console.log(datos)

        UI.id.value             = datos.resultado.id
        UI.nombre.value         = datos.resultado.nombre
        UI.pApellido.value      = datos.resultado.papellido
        UI.sApellido.value      = datos.resultado.sapellido
    }

    validar(datos) {

        let mensaje = "";

        if (!datos.hasOwnProperty("id") || datos.id === "") {
            mensaje = "Falta ingresar el ID";
        } else if (!datos.hasOwnProperty("nombre") || datos.nombre === "") {
            mensaje = "Falta ingresar el nombre";
        } else if (!datos.hasOwnProperty("pApellido") || datos.pApellido === "") {
            mensaje = "Falta ingresar el primer apellido";
        } else if (!datos.hasOwnProperty("login") || datos.login === "") {
            mensaje = "Falta ingresar el login";
        } else if (!datos.hasOwnProperty("pwd") || datos.pwd === "") {
            mensaje = "Falta ingresar la contraseña";
        }

        if (mensaje !== "") {
            UI.mensaje(mensaje);
            return false;
        }

        return true;
    }
}

function crearBotonesEditarEliminar(id) {
    var btnEditar = document.createElement("button");
    btnEditar.innerText = "Editar";
    btnEditar.classList = "botonEditar";
    btnEditar.addEventListener("click", function () {
        console.log("Editar, ID:", id);
        UI.mostrarNotificacion(`Editar, ID: ${id}`);
        UI.accion_abrirModal();
        self.consultarDatosID(id);
    });

    var btnEliminar = document.createElement("button");
    btnEliminar.innerText = "Eliminar";
    btnEliminar.classList = "botonEliminar";
    btnEliminar.addEventListener("click", function () {
        console.log("Eliminar, ID:", id);
        // UI.mostrarNotificacion(`Eliminar, ID: ${id}`);
        if (confirm(`¿Desea ELIMINAR los datos de la fila seleccionada? \n ${id}`)){
            self.eliminar(id);
        } else {
            UI.mostrarNotificacion(`Acción Cancelada para Eliminar, ID: ${id}`);
        }
    });

    var td = document.createElement("td");
    td.appendChild(btnEditar);
    td.appendChild(btnEliminar);

    return td;
}

function limpiarTabla() {
    console.log("Tabla Actualizada")
    UI.mostrarNotificacion("Tabla Actualizada");
    UI.tablaContenido.innerHTML = '';
}

window.onload = () => {
    window.UI = new crudUI(true) // El objeto vista
    window.self = new crud() // El objeto controlador
    window.ajax = new Ajax("PHP/servicios.php")

    self.consultarDatos(1)
}

// Evento para cerrar el modal
window.onclick = function(e) {
    if (e.target == UI.modal) {
        UI.accion_cerrarModal();
    }
}