# crud_users_php

Este proyecto es un CRUD (Create, Read, Update, Delete) para el almacenamiento de usuarios utilizando PHP, MySQL, JavaScript y CSS. Permite realizar operaciones básicas de gestión de usuarios a través de una interfaz web.

* FrontEnd: HTML, CSS, JavScript

* Backend: PHP, MariaDB & MySQL

## Demostración
Demostración con imágenes del proyecto en funcionamiento:
<div align="center">
    <img src="/docs/14-2-2025_141048_localhost.jpeg" alt="Vista 1">
    <img src="/docs/14-2-2025_143931_localhost.jpeg" alt="Vista 2">
</div>


## Estructura del Proyecto
El proyecto se divide en las siguientes carpetas y archivos:

```bash
master/
├── favicon.ico
├── index.html
├── LICENSE
├── README.md
├── css/
│    └── estilos.css
├── db/
│    ├── crud.php
│    └── globales.css
├── js/
│    ├── ajax.js
│    ├── crud.js
│    └── crudUI.js
└── php/
     ├── BD.php
     ├── globales.php
     ├── respuesta.php
     ├── servicios.php
     └── usuarios.php
``` 

### Archivos y Directorios

- **css/**: Contiene los archivos de estilos CSS.
  - `estilos.css`: Archivo principal de estilos.

- **db/**: Contiene los scripts SQL para la base de datos.
  - `crud.sql`: Script para la creación y manipulación de la base de datos `crud`.
  - `globales.sql`: Script para la creación y manipulación de la base de datos `globales`.

- **js/**: Contiene los archivos JavaScript.
  - `ajax.js`: Maneja las solicitudes AJAX.
  - `crud.js`: Contiene la lógica del CRUD.
  - `crudUI.js`: Maneja la interfaz de usuario del CRUD.

- **php/**: Contiene los archivos PHP.
  - `BD.php`: Clase para la conexión a la base de datos.
  - `globales.php`: Clase para manejar las constantes y mensajes globales.
  - `respuesta.php`: Clase para manejar las respuestas del servidor.
  - `servicios.php`: Clase principal que maneja los servicios del CRUD.
  - `usuarios.php`: Clase para manejar las operaciones de usuarios en la base de datos.

- `favicon.ico`: Icono del sitio web.
- `index.html`: Página principal del CRUD.
- `LICENSE`: Licencia del proyecto.
- `README.md`: Documentación del proyecto.

## Instalación

1. Clona el repositorio:
   ```sh
   git clone https://github.com/adrianbl1/crud_users_php.git 
   ```

2. Configura la base de datos:
   - Importa los archivos `crud.sql` y `globales.sql` en tu servidor MariaDB.

3. Configura el servidor web:
   - Asegúrate de que tu servidor web (por ejemplo, Apache) esté configurado para servir el proyecto.

4. Abre el archivo `index.html` en tu navegador.

## Uso
### Interfaz de Usuario

La interfaz de usuario permite realizar las siguientes operaciones:

- Crear: Agregar un nuevo usuario.
- Leer: Consultar los usuarios almacenados.
- Actualizar: Editar la información de un usuario existente.
- Eliminar: Eliminar un usuario.

### Funcionalidades

- Formulario CRUD: Permite ingresar y editar la información de los usuarios.
- Tabla de Usuarios: Muestra la lista de usuarios almacenados.
- Paginación: Navegar entre las páginas de usuarios.
- Notificaciones: Muestra mensajes de éxito o error.

## Licencia
Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo LICENSE para obtener más detalles.

## Contribuciones
Las contribuciones son bienvenidas. Si deseas contribuir, por favor sigue los siguientes pasos:

1. Haz un fork del proyecto.
2. Crea una rama para tu nueva funcionalidad (*git checkout -b feature/nueva-funcionalidad*).
3. Realiza tus cambios y haz commit (*git commit -am 'Agrega nueva funcionalidad'*).
4. Sube tus cambios a tu fork (*git push origin feature/nueva-funcionalidad*).
5. Abre un Pull Request.

## Contacto
Para cualquier consulta o sugerencia, por favor contacta a [Adrian BL](https://github.com/adrianbl1).