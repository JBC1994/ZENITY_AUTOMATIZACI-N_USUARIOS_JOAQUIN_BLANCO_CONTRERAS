## <p align="center">Índice</p> 
### <p align="right">ZENITY_AUTOMATIZACIÓN_USUARIOS_JOAQUIN_BLANCO_CONTRERAS Curso: ASIR2_IES_ALBARREGAS</p>

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

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/b8f88202-04ef-476e-bac1-2374dac5e6e6)


Tendrás a elegir 8 opciones bastante potentes entre las que destacan la opción1, entre otras, debido a que dependiendo del fichero que te proporcionen para la automatización de usuarios, podrás modificar el bucle a tu antojo.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/bf8547ef-623b-478f-974b-b8e98d5763da)


Este sería un breve ejemplo, vemos que como carácter de separación tienes “:” pero podrías modificarlo a tu antojo según el fichero que tengas, después en la opción “Done” del bucle, cargarías el fichero que te dieron y ya estaría el trabajo hecho. En este caso, este sería el fichero de prueba:

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/28376e87-6fd3-462e-b25f-ac3363b05c33)


## Creación de Grupo
Este apartado será muy simple, la herramienta te pedirá el nombre del grupo a crear y automáticamente este se creará.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/464d6d7f-705c-4b4a-92b9-c48f445a3e86)

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/28258ff5-50a3-42c8-8387-960270c62ea6)


## Asociar un Usuario a un Grupo
Este apartado te permitirá asociar un usuario a un grupo, en este caso la herramienta te pedirá el nombre de un grupo y luego el nombre del usuario al que quieres que pertenezca a un grupo.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/7486639a-b828-4b04-8fbb-aba1f9ae23dc)

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/bcb40cfb-bc59-44f8-b8cd-8f00220b54af)

De igual manera serían las opciones dos y tres. Diferenciando que en la opción dos entrarás en un bucle en el que te permitirá asignar tantos usuarios como quieras a un grupo, hasta que tú decidas salir.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/27d269f5-6a00-4293-86f4-0e985bc0931a)

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/15d000de-74d0-40a9-ba88-d92c1fd08191)

La opción tres te permitirá borrar a un usuario de un grupo, te pedirá el nombre del usuario y después el nombre del grupo, y automáticamente se borrará.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/5e51a002-d56c-422a-b94d-dd61690be1cc)

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/e84f9a6b-8297-475d-9d7e-46af66dc3e43)

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/db373619-2d73-4404-ad7d-6866505b120d)


## Modificar /home de Usuarios
Esta opción te pedirá el nombre de un usuario al que quieres modificar su /home, en este caso una vez lo insertes podrás modificar su /home donde desees. 

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/0b20b64c-b9ac-490d-a745-3bb538e1904c)
![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/9c3034d4-dd6a-4e0a-9928-bc8b9b8c803e)

Como vemos este usuario, “usuario1” tendrá como /home/user1.

## Modificación de Password de Usuarios
En este apartado tendremos la opción de poder modificar el password de aquel usuario al que queramos modificar su contraseña.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/f37f22df-8cdb-43e4-8575-17ad0e030485)

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/4c58f188-5aa8-41ad-8a4e-80d3682b3623)

## Modificación de Máscara de Permisos Umask en Usuarios
Insertaremos el nombre de usuario al que queramos cambiar los permisos de UMASK. En este caso, introduciremos el nombre de usuario y seguidamente nos pedirá el número que queremos tener como UMASK en ese usuario.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/5381aaf6-95b6-4b3e-9821-5ec5cdb22ab5)

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/c33f1100-fab4-4dab-89d4-6e675aee9098)

## Crear una Carpeta Compartida para un Grupo
En este apartado nos pedirá el nombre del grupo, una vez dado el nombre del grupo, pediremos seguidamente la ruta de la carpeta que queramos compartir con ese grupo.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/3e47c54f-823b-4008-9fec-0ca7b7b21ce9)

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/061817bc-50b6-4991-8547-1a4bd0dace40)

## Borrado de Usuario Individual o Masivo por Fichero
Este apartado es un apartado muy útil para la eliminación de usuarios creados en el sistema, de igual manera teniendo en cuenta la función 1, veremos que se creará un fichero llamado usuarios_creados.csv. Este fichero almacenará aquellos usuarios que en un principio agregamos, de igual manera, aquel usuario que se borre se mudará su /home a un directorio en la raíz “/” del sistema que los almacenará por si en un futuro ese usuario vuelve y se decide recuperar su información.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/b6262402-5e91-46ee-a95a-e6e9ab60f494)

Como vemos, si elegimos el usuario1, se nos eliminará, pero su /home correspondiente se mudará a un directorio raíz llamado /.home_usuarios_eliminados, en este caso es un directorio oculto donde se encontrará información de su /home.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/f001bc5f-5ce6-4f94-a5fa-c78909403be4)

Si elegimos la opción “borrar usuario masivamente”, borraremos aquellos que hemos creado anteriormente en la opción1, ten en cuenta que en la opción1 si miramos el código los usuarios añades desde un principio desde un fichero dejan de ser esos mismos debido a que al nombre le sigue un número auto incremental, por lo que una vez creados todos los usuarios en la opción1 se creará otro fichero automáticamente con los usuarios creados.

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/3d77c314-3954-455b-a623-86b311265a1e)

![image](https://github.com/JBC1994/ZENITY_AUTOMATIZACI-N_USUARIOS_JOAQUIN_BLANCO_CONTRERAS/assets/120668110/f4ebd0ea-a78f-4ce4-8dbf-878a5edb4dfc)


