class crudUI {
    constructor(reset = false) {
        if (reset == true) {
            this.form = document.querySelector("form");
            
            // Entradas - formulario
            this.id             = document.getElementById("id");
            this.nombre         = document.getElementById("nombre");
            this.pApellido      = document.getElementById("apellido1");
            this.sApellido      = document.getElementById("apellido2");
            this.login          = document.getElementById("login");
            this.pwd            = document.getElementById("contrasena");

            // Acciones - formulario
            this.guardar    = document.getElementById("guardar");
            this.editar     = document.getElementById("editar");
            this.eliminar   = document.getElementById("eliminar");

            this.consultarID    = document.getElementById("consultarID");
            this.limpiar        = document.getElementById("limpiar")
            this.actualizar     = document.getElementById("actualizar");
            
            this.paginaA        = document.getElementById("paginaAnterior");
            this.paginaS        = document.getElementById("paginaSiguiente");
            this.paginaActualUI = document.getElementById("paginaActual");

            //Modal
            this.abrirModal     = document.getElementById("abrirModal");
            this.cerrarModal    = document.getElementById("cerrarModal");
            this.modal          = document.getElementById("ventanaModal");

            this.datos = document.querySelector("#datos");

            this.tablaContenido = document.getElementById("tablaContenido");

            this.fijarEventos();
        }
    }

    fijarEventos() {
        this.guardar.addEventListener("click", this.enviar_click_guardar);
        this.editar.addEventListener("click",this.enviar_click_editar);
        this.consultarID.addEventListener("click",this.enviar_click_consultarDatosID);
        this.limpiar.addEventListener("click",this.accion_limpiar_formulario)
        this.actualizar.addEventListener("click",this.enviar_click_actualizar);
        this.eliminar.addEventListener("click", this.enviar_click_eliminar);
        
        this.paginaA.addEventListener("click",this.paginaAnterior);
        this.paginaS.addEventListener("click",this.paginaSiguiente);
        
        this.abrirModal.addEventListener("click",this.accion_abrirModal);
        this.cerrarModal.addEventListener("click",this.accion_cerrarModal);
    }

    enviar_click_consultarDatosID(e){
        e.preventDefault();
        self.consultarDatosID();
    }

    enviar_click_guardar(e){
        e.preventDefault();
        self.guardar();
    }

    enviar_click_editar(e){
        e.preventDefault();
        self.editar();
    }

    enviar_click_actualizar(e){
        e.preventDefault();
        self.consultarDatos(1)
    }

    enviar_click_eliminar(e){
        if (confirm(`¿Desea ELIMINAR los datos?`))
            e.preventDefault();
            self.eliminar();
    }

    accion_limpiar_formulario(){
        this.form.reset()
    }

    accion_abrirModal() {
        UI.modal.style.display = "block";
    }

    accion_cerrarModal() {
        UI.form.reset()
        UI.modal.style.display = "none";
    }

    paginaAnterior() {
        let paginaActual = 1;

        if (paginaActual > 1) {
            paginaActual--;
            console.log(paginaActual)
            this.paginaActualUI.innerText = `Página: ${paginaActual}`
            self.consultarDatos(paginaActual)
        }
    }

    paginaSiguiente() {
        let paginaActual = 1;
        const totalPaginas = 10; // Suponiendo que se conoce el num de paginas

        if (paginaActual < totalPaginas) {
            paginaActual++;
            console.log(paginaActual)
            this.paginaActualUI.innerText = `Página: ${paginaActual}`
            self.consultarDatos(paginaActual)
        }
    }

    mostrarNotificacion(mensaje) {
        this.notificacion = document.getElementById("notificacion");
        notificacion.innerText = mensaje;
        notificacion.className = "toast show";

        // Asignación de tiempo al Toast
        setTimeout(function(){
            notificacion.className = "toast";
        }, 4000); // La notificación desaparecerá después de 4 segundos
    }

    recuperar(...args) {
        let datos = {};

        for (const arg of args) {
            console.log(arg)
            if (UI.hasOwnProperty(arg)) datos[arg] = UI[arg].value;
        }
        return datos;
    }

    mensaje(texto) {
        alert(texto);
    }
}