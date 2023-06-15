# Flallery

Flallery es una red social de galería de arte que permite a los usuarios compartir y descubrir obras de arte. La aplicación se ha desarrollado en dos partes: el backend y el frontend, utilizando diversas tecnologías para garantizar su correcto funcionamiento.


## Tecnologías utilizadas

Backend: El backend de Flallery se ha desarrollado utilizando Spring, un framework de Java, y empleando PostgreSQL como base de datos en producción y H2 como base de datos en desarrollo. Además, en producción se ha utilizado Docker para garantizar que el despliegue de la base de datos de PostgreSQL sea lo más sencillo posible.

Frontend Usuario: El frontend de Flallery se ha desarrollado utilizando Dart y Flutter utilizando la arquitectura BloC, un framework de desarrollo de aplicaciones móviles multiplataforma. De esta forma, se ha conseguido un desarrollo ágil y sencillo, permitiendo que la aplicación pueda ser ejecutada en distintos sistemas operativos.

Frontend Administrador: desarrollado con Angular utilizando un diseño Material, para darle un toque sencillo e intuitivo a toda la aplicación
para mejorar el uso de esta.


### Versiones y Arranque

    • Flutter version 3.8.0-14.0.pre.10 CHANNEL MASTER
    • Dart version 3.0.0 (build 3.0.0-259.0.dev) 
    • DevTools version 2.21.1
    • Figma https://www.figma.com/file/h8ZaYhdXI0ZWnlIMYvZSTB/Flallery?type=design&node-id=0-1&t=vPo5WXPba1mz4VRG-0



    Para iniciar el proyecto es necesario realizar los siguientes pasos:
    
    1.  La apliciación se encuentra dockerizada prácticamente al completo, porlo que se hace muy sencillo ejecutarla, nos dirigimos a la carpeta raíz
        del repositorio /Flallery, en ella abrimos el terminal y ejecutamos el comando "docker-compose up -d" esto levantará tanto la base de datos como el cliente de administrador, el servidor y el cliente para gestionar la base de datos. 
        *Deberemos tener instalado docker desktop e iniciarlo para poder ejecutar correctamente el comando*

    2.  Para acceder a ellos una vez levantados los contenedores correspondientes, nos encontramos con los siguientes puertos:

        - http://localhost:4200/login Cliente Administrador en angular
        - http://localhost:5050/login Cliente Administrador de base de datos PgAdmin
        
    3.  Para acceder a la versión móvil deberemos tener android studio instalado y un dispositivo android para emular la app, una vez configurado
        esto, abrimos la carpeta /flallery_frontend/ en visual studio, seleccionamos nuestro dipositivo móvil y ejecutamos los siguientes comandos en el terminal: "flutter pub get" para obtener las dependencias y "flutter run" paciencia, puede tardar, tras esto tendremos nuestra móvil aplicación ejecutándose en nuestro emulador.

    
    Si todo va bien debemos tener nuestro proyecto funcionando correctamente en todas sus variantes.


### Usuarios:

- ADMIN     --> Username: mcampos           // Password: Salesianos123_ 
                Username: jcasanova         // Password: Salesianos123_ 

- USER      --> Username: lmlopez           // Password: Salesianos123_
                Username: anaranjo          // Password: Salesianos123_

- PgAdmin   --> Usermail: admin@admin.com   // Password: root


### Pruebas
- Swagger / Documentación de endpoints: http://localhost:8080/swagger-ui/index.html#/
- Colección de Postman agregada.


## Apuntes

-   Queda implementar un sistema de ventas en la interfaz de usuario para generar más ingresos con el 
    proyecto, un despliegue sólido de toda la aplicación en la nube, y posibles actualizaciones que vayan surgiendo.
