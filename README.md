# ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS

## Índice
1. [Introducción](#introducción)
2. [Utilización de la Herramienta](#utilización-de-la-herramienta)
3. [Creación de Grupo](#creación-de-grupo)
4. [Asociar un Usuario a un Grupo](#asociar-un-usuario-a-un-grupo)
5. [Modificar /home de Usuarios](#modificar-home-de-usuarios)
6. [Modificación de Password de Usuarios](#modificación-de-password-de-usuarios)
7. [Modificación de Máscara de Permisos Umask en Usuarios](#modificación-de-máscara-de-permisos-umask-en-usuarios)
8. [Crear una Carpeta Compartida para un Grupo](#crear-una-carpeta-compartida-para-un-grupo)
9. [Borrado de Usuario Individual o Masivo por Fichero](#borrado-de-usuario-individual-o-masivo-por-fichero)

## Introducción
En este apartado tendremos que tener en cuenta que este manual actúa sobre una aplicación de automatización de usuarios creada en bash, apta para distribuciones Ubuntu/Debian. Como administrador tendrás el poder de utilizarla a tu antojo o modificarla como creas conveniente, esta herramienta se diferencia de otras en que ganarás mucho tiempo en la automatización de usuarios o modificación de los mismos.

## Utilización de la Herramienta
Bien, como hemos comentado anteriormente deberás tener en cuenta que para que esta aplicación se ejecute correctamente al ser una herramienta para administradores deberás de ser root. Dicho esto, tendrás el siguiente menú para poder interactuar con él.

Tendrás a elegir 8 opciones bastante potentes entre las que destacan la opción1, entre otras, debido a que dependiendo del fichero que te proporcionen para la automatización de usuarios, podrás modificar el bucle a tu antojo.

Este sería un breve ejemplo, vemos que como carácter de separación tienes “:” pero podrías modificarlo a tu antojo según el fichero que tengas, después en la opción “Done” del bucle, cargarías el fichero que te dieron y ya estaría el trabajo hecho. En este caso, este sería el fichero de prueba:

## Creación de Grupo
Este apartado será muy simple, la herramienta te pedirá el nombre del grupo a crear y automáticamente este se creará.

## Asociar un Usuario a un Grupo
Este apartado te permitirá asociar un usuario a un grupo, en este caso la herramienta te pedirá el nombre de un grupo y luego el nombre del usuario al que quieres que pertenezca a un grupo. De igual manera serían las opciones dos y tres. Diferenciando que en la opción dos entrarás en un bucle en el que te permitirá asignar tantos usuarios como quieras a un grupo, hasta que tú decidas salir.

La opción tres te permitirá borrar a un usuario de un grupo, te pedirá el nombre del usuario y después el nombre del grupo, y automáticamente se borrará.

## Modificar /home de Usuarios
Esta opción te pedirá el nombre de un usuario al que quieres modificar su /home, en este caso una vez lo insertes podrás modificar su /home donde desees. Como vemos este usuario, “usuario1” tendrá como /home/user1.

## Modificación de Password de Usuarios
En este apartado tendremos la opción de poder modificar el password de aquel usuario al que queramos modificar su contraseña.

## Modificación de Máscara de Permisos Umask en Usuarios
Insertaremos el nombre de usuario al que queramos cambiar los permisos de UMASK. En este caso, introduciremos el nombre de usuario y seguidamente nos pedirá el número que queremos tener como UMASK en ese usuario.

## Crear una Carpeta Compartida para un Grupo
En este apartado nos pedirá el nombre del grupo, una vez dado el nombre del grupo, pediremos seguidamente la ruta de la carpeta que queramos compartir con ese grupo.

## Borrado de Usuario Individual o Masivo por Fichero
Este apartado es un apartado muy útil para la eliminación de usuarios creados en el sistema, de igual manera teniendo en cuenta la función 1, veremos que se creará un fichero llamado usuarios_creados.csv. Este fichero almacenará aquellos usuarios que en un principio agregamos, de igual manera, aquel usuario que se borre se mudará su /home a un directorio en la raíz “/” del sistema que los almacenará por si en un futuro ese usuario vuelve y se decide recuperar su información.

Como vemos, si elegimos el usuario1, se nos eliminará, pero su /home correspondiente se mudará a un directorio raíz llamado /.home_usuarios_eliminados, en este caso es un directorio oculto donde se encontrará información de su /home. Si elegimos la opción “borrar usuario masivamente”, borraremos aquellos que hemos creado anteriormente en la opción1, ten en cuenta que en la opción1 si miramos el código los usuarios añades desde un principio desde un fichero dejan de ser esos mismos debido a que al nombre le sigue un número auto incremental, por lo que una vez creados todos los usuarios en la opción1 se creará otro fichero automáticamente con los usuarios creados.
