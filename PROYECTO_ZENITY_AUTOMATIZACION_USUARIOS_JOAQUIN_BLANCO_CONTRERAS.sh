#!/bin/bash

function OP1 {
    ###########################################################################################################################################################################################
    : '
    Esta función se encargará de asignar contraseñas a los usuarios. 
    Metemos zenity en una variable, en este caso "archivo_usuarios" La cual contendrá el comando de zenity apto para la recogida de ficheros .csv, gracias a la asignación del filtro "filter".
    '
    ##########################################################################################################################################################################################
    archivo_usuarios=$(zenity --file-selection --title="Selecciona el Archivo de Usuarios" --file-filter="Archivos CSV (csv) | *.csv")
    ##########################################################################################################################################################################################
    : '
    Una vez seleccionado el fichero, me aseguro de que esto sea así, en el caso de que, si sea un fichero, pues directamente entrará en el condicional asignándole con ello un valor, el cual
    contendrá el comando zenity para asignar dos opciones. 
    Estas serán "Contraseña "Por Defecto" y "Personalizar". 
    Ambas opciones están asignadas a un menú "case" el cual recoge la información de salida para trabajar en cada opción lo necesario para su ejecución.
    '
    ##########################################################################################################################################################################################
    if [[ -f "$archivo_usuarios" ]]; then
        opcion_contrasenia=$(zenity --title="CONFIGURACIÓN DE CONTRASEÑA" --list --column="OPCIÓN" \
        --column "DESCRIPCION" --width=300 --height=200 \
        1 "POR DEFECTO" \
        2 "PERSONALIZAR")

        case $opcion_contrasenia in
        1)
        ##################################################################################################################################################################################################
        : '
        En este apartado, trabajaremos con la opción 1 , "Por defecto", lo que hago es implementar un bucle "While" al cúal le asigno los campos que contendrá dicho fichero. Este será el que escogeremos
        en formato .csv, en la variable "archivo_usuarios" que tenemos arriba y cogimos en un principio. Este bucle recorrerá todo el fichero, y seleccionará los campos indicados.
        Tenemos que tener en cuenta, que, por motivos de redundancia, o para evitar fallos en la ejecución del código debido a un nombre de usuario repetido, pero con distintos atributos, 
        este no podrá ser creado, así que mi solución fue asignarle un numero incremental a cada usuario creado. 
        Por ejemplo, joaquin1, joaquin2, ambos se llaman igual, pero los campos serán distintos (atributos). 
        Por lo que, creo que sería una medida de solución al problema de: "Joaquin" "Joaquin", ya que
        nuestro sistema nos dirá que el usuario esta repetido y no podríamos crearlo, por eso la implementación de un número que se autoincremente en la creación del usuario. 
        Por defecto le pongo que comience en 1, y automáticamente se incrementará tantas veces como usuarios haya en el fichero.  
        Personalice el usuario de la siguiente manera, lo que hago es implementar una variable llamada nombre_usuario en el cual cogemos el campo "nombre" del bucle while
        y le asigno de seguido el número de usuario. Que es la variable declarada en un principio.
        Personalice la contraseña por defecto de la siguiente manera, escogiendo así la primera letra del nombre y su primer apellido. 
        En este caso, lo que hago es crear una variable llamada "Primero_letra" la cual contendrá el campo nombre, pero a su vez con el comando "cut" corto el primer carácter, después lo que hago es 
        juntar el primer carácter y su apellido que está sería su contraseña. 
        '
        #################################################################################################################################################################################################
            numero_usuario=1
            while IFS=: read -r nombre apellido1 apellido2 ciudad provincia cp fecha; do
                nombre_usuario="${nombre}${numero_usuario}"
                primera_letra=$(echo "$nombre" | cut -c 1)
                contrasenia=$(perl -e 'print crypt("${primera_letra}${apellido1}", "encripta"), "\n"')

                sudo useradd -m -s /bin/bash -p "$contrasenia" "$nombre_usuario"
                ########################################################################################################################################################################################
                : '
                Aquí lo que hago es guardar todos los usuarios creados que se autoincrementan numéricamente y los guardo a un fichero, para después poder ejecutarlo con la función 8, 
                ya que si nos damos cuenta, cuando ejecutemos la función 8 y seleccionemos el fichero .csv vendrán los usuarios por defectos que venían en el fichero, pero esto no nos sirven
                porque se han ido autoincrementando, entonces sus nombres cambiarán por lo que no podrán ser borrados desde el fichero, directamente lo que hago, es que cuando va creando los usuarios 
                y estos se autoincrementan con el numero le doy como salida un fichero que luego seleccionaremos con la funcion8 la cual ahora sí, se podrá ejecutar correctamente.
                '
                ########################################################################################################################################################################################
                echo "$nombre_usuario" >> usuarios_creados.csv
                ((numero_usuario++))
            done < "$archivo_usuarios"
        ;;
        2)
            ###################################################################################################################################################################################################
            : '
            En esta opción tendremos que tener en cuenta que es una contraseña personalizada, pero de igual manera funciona igual que el paso anterior, solo que, en este apartado, he decidido personalizar
            y lo que hago básicamente es crearla según ordenan las opciones elegidas con el comando "cut" y eligiendo los campos del bucle while, prácticamente, calcado al anterior, pero con sus diferencias.
            '
            ###################################################################################################################################################################################################

            opcion_personalizada=$(zenity --title="CONFIGURACIÓN DE CONTRASEÑA" --list --column="OPCIÓN" \
            --column "DESCRIPCION" --width=500 --height=200 \
            1 "ELEGIR 2 LETRAS DEL NOMBRE Y 3 DEL APELLIDO" \
            2 "LOS 4 ÚLTIMOS CARACTERES, AÑO DE NACIMIENTO" \
            3 "ELEGIR 3 LETRAS DEL NOMBRE Y 2 DEL APELLIDO" \
            4 "SALIR")

            if [[ $opcion_personalizada == "4" ]]; then
                zenity --info --text="Hasta la próxima"
                exit
            fi

            numero_usuario=1
            while IFS=: read -r nombre apellido1 apellido2 ciudad provincia cp fecha; do
                nombre_usuario="${nombre}${numero_usuario}"

                case $opcion_personalizada in
                1)
                    dos_letras_nombre=$(echo "$nombre" | cut -c 1-2)
                    tres_letras_apellido=$(echo "$apellido1" | cut -c 1-3)
                    contrasenia=$(perl -e 'print crypt("${dos_letras_nombre}${tres_letras_apellido}", "encripta"), "\n"')
                ;;
                2)
                    ultimos_cuatro_año=$(echo "$fecha" | cut -c 1-4)
                    contrasenia=$(perl -e 'print crypt("$ultimos_cuatro_año", "encripta"), "\n"')
                ;;
                3)
                    tres_letras_nombre=$(echo "$nombre" | cut -c 1-3)
                    dos_letras_apellido=$(echo "$apellido1" | cut -c 1-2)
                    contrasenia=$(perl -e 'print crypt("${tres_letras_nombre}${dos_letras_apellido}", "encripta"), "\n"')
                ;;
                esac

                sudo useradd -m -s /bin/bash -p "$contrasenia" "$nombre_usuario"
                echo "$nombre_usuario" >> usuarios_creados.csv
                ((numero_usuario++))

            done < "$archivo_usuarios"
        ;;
        *)
            echo "Opción no válida"
            exit
        ;;
        esac
    else
        zenity --error --text="No se seleccionó un archivo válido."
    fi
}


function OP2 {
        ######################################################################################################################################
        : '
        En esta función lo que ahcemos es crear un grupo, cuando la ejecutemos nos dará la opción de dar nombre a un grupo y esté se creará.
        '
        #####################################################################################################################################

        zenity --info --title="Creación de Grupo" --text="Has elegido creación de grupo."

        nombre_grupo=$(zenity --entry --title="Nombre Del Grupo" --text="Inserta el nombre del grupo.")

    if [[ -n $nombre_grupo ]]; then

        ########################################################################################################################################################################################
        : '
        Aquí lo que hago es verificar si la cadena esta vacía o no, quiero decir, si el usuario ha insertado algo en el campo, si ha insertado una cadena "nombre del grupo" pues esté entrará
        en el condicional, de forma dará error. 
        Lo que hago también es implementar una opción que tiene zenity para quedarlo estoicamente más bonito para la interfaz de usuario. 
        '
        ########################################################################################################################################################################################

         (
            echo "10" ; sleep 0.5
            echo "# Creando grupo $nombre_grupo..." ; sleep 1
            echo "100"

         ) | zenity --progress --title="Creando Grupo" --text="Procesando..." --percentage=0 --auto-close --no-cancel

        sudo addgroup $nombre_grupo
        
        if [[ $? -eq 0 ]]; then

            zenity --info --text="Grupo $nombre_grupo Ha sido creado exitosamente."
        else
         
            zenity --error --text="Error al crear el grupo, posiblemente ya existe uno con ese nombre."
        fi
    else
        zenity --warning --text="Se requiere que ingreses un nombre para continuar."
    fi
    
}

function OP3 {
        ####################################################################################################################################################################################################
        : '
        En esta función hice un menú como conocemos de zenity con varias opciones, recalco que hay una opción nueva no implementada en el pdf por error, debido a que han ido surgiendo ideas mientras 
        se desarrollaba la herramienta. 
        Las cuales serían la de eliminar un usuario de un grupo, ya que me parecía muy poco la idea de 2 opciones ya que se agregaban usuarios pero estos no se borraban.. Lo correcto creo que sería tener
        la opción de borrado de usuarios de un grupo.
        '
        ###################################################################################################################################################################################################

        usuario_grupo=$(zenity --title="ASIGNAR USUARIO A GRUPO/OS" --list --column="OPCIÓN" \
            --column "DESCRIPCION" --width=500 --height=200 \
            1 "ASOCIAR UN USUARIO A UN GRUPO" \
            2 "ASOCIAR VARIOS USUARIOS A UN GRUPO" \
            3 "BORRAR USUARIO DE UN GRUPO" \
            4 "SALIR")
        
         #################################################################################################################################################################################################
            : '
            En esta opción básicamente lo que hago es pedir un nombre de grupo y después el nombre del usuario. 
            Luego verifico si el usuario ha introducido una cadena o lo que es lo mismo si ha introducido texto, si esto es correcto entrará en el condicional, y agregaremos ese usuario a ese grupo
            Personalizo un poco la interfaz para que no se vea tan simple e implemento gráficamente un proceso con zenity simulando la creación del grupo.
            '
         #################################################################################################################################################################################################
            
        case $usuario_grupo in                  
            
            1)
            
                grupo=$(zenity --entry --title="Nombre Grupo" --text="Inserta el nombre del grupo")
                usuario=$(zenity --entry --title="Nombre Usuario" --text="Inserta el usuario")

                if [[ -n $grupo && -n $usuario ]]; then

                    (
                    echo "10" ; sleep 0.5
                    echo "# Asociando usuario a grupo $grupo..." ; sleep 1
                    echo "100"
                    ) | zenity --progress --title="Agregando usuario a Grupo" --text="Procesando..." --percentage=0 --auto-close --no-cancel

                    sudo usermod -a -G "$grupo" "$usuario"

                #Aquí si se ha creado correctamente el grupo y el usuario lo notifico. 

                    if [[ $? -eq 0 ]]; then
                        zenity --info --text="Usuario $usuario añadido correctamente al grupo: $grupo"
                    else
                        zenity --info --text="Error, el grupo o el usuario no existe."
                    fi
                else
                    zenity --error --text="Se requiere que ingreses un nombre para continuar."
                fi
            ;;
            2)
                ###################################################################################################################################################################################################
                : '
                Esta opción es la misma que la 1 pero en este caso como diferencia asigno un bucle while para que siga introduciendo usuarios dentro del grupo, despues lo que hago es que una vez se creen ambos, 
                siga pidiendo usuarios o directamente que diciendo terminar se salga del bucle y finalizaría la entrada de usuarios.
                '
                ##################################################################################################################################################################################################
                grupo=$(zenity --entry --title="Nombre Grupo" --text="Inserta el nombre del grupo")

                if [[ -n $grupo ]]; then
                while true; do
                usuario=$(zenity --entry --title="Nombre Usuario" --text="Inserta el nombre del usuario")

                    if [[ -n $usuario ]]; then

                        sudo usermod -a -G "$grupo" "$usuario"
                        if [[ $? -eq 0 ]]; then
                            zenity --info --text="Usuario $usuario añadido correctamente al grupo: $grupo"
                        else
                            zenity --error --text="Error, el grupo o el usuario no existe."
                        fi
                    else
                        zenity --error --text="Se requiere que ingreses un nombre de usuario para continuar."
                        continue
                    fi

                    finalizar=$(zenity --question --text="¿Quieres seguir ingresando usuarios al grupo $grupo?" --extra-button="Terminar")

                    if [[ $finalizar == "Terminar" ]]; then
                        break
                    fi
                    done
                else

                    zenity --error --text="Se requiere que ingreses un nombre de grupo para continuar."

                fi
            ;;

            3)
                ########################################################################################################################################################################################
                : '
                Esta opción ha sido la implementada opcionalmente, que seria la de eliminar a un usuario de un grupo  
                '
                ########################################################################################################################################################################################
                nombre_usuario=$(zenity --entry --title="Nombre de Usuario" --text="Inserta el nombre del usuario")
                nombre_grupo=$(zenity --entry --title="Nombre de Grupo" --text="Inserta el nombre del grupo del cual se eliminará al usuario")

                if [[ -n $nombre_usuario && -n $nombre_grupo ]]; then
                    #Confirmación antes de eliminar al usuario del grupo
                    confirmar=$(zenity --question --text="¿Estás seguro de que quieres eliminar al usuario $nombre_usuario del grupo $nombre_grupo?" --extra-button="Cancelar")

                    if [[ $confirmar == "Cancelar" ]]; then
                        zenity --info --text="Operación cancelada."
                        exit 0 
                    fi

                    #Eliminamos el usuario del grupo, le implemento una opcion gráfica de zenity para que visualmente sea mas estetico. 
                    (
                    echo "10" ; sleep 0.5
                    echo "# Eliminando usuario de grupo $nombre_grupo..." ; sleep 1
                    echo "100"
                    ) | zenity --progress --title="Eliminando usuario del Grupo" --text="Procesando..." --percentage=0 --auto-close --no-cancel

                    sudo gpasswd -d "$nombre_usuario" "$nombre_grupo"
                    if [[ $? -eq 0 ]]; then
                        zenity --info --text="Usuario $nombre_usuario eliminado del grupo $nombre_grupo correctamente."
                    else
                        zenity --error --text="Error al eliminar al usuario del grupo. Puede que el usuario o el grupo no exista, o que necesites permisos adicionales."
                    fi
                else
                    zenity --error --text="Se requieren el nombre del usuario y del grupo para continuar."
                fi
                ;;

            *)
                zenity --error --text="Opción no válida."
                ;;
        esac
}

function OP4 {
                 ################################################################################################################################################################################################################
                : '
                En esta opción solo me enfoco en la creación de una nueva ruta para cambiar su directorio, esto nos podría servir por si queremos que este usuario este ubicado una zona distinta o para proteger su información.
                '
                #################################################################################################################################################################################################################

                nombre_usuario=$(zenity --entry --title="Nombre del Usuario" --text="Inserta el nombre del usuario")
                nuevo_home=$(zenity --entry --title="Nuevo Directorio Home" --text="Inserta la ruta del nuevo directorio home para el usuario $nombre_usuario")

                if [[ -n $nombre_usuario && -n $nuevo_home ]]; then
                    # Confirmación antes de realizar el cambio
                    confirmar=$(zenity --question --text="¿Estás seguro de que quieres cambiar el directorio home de $nombre_usuario a $nuevo_home?" --extra-button="Cancelar")

                    if [[ $confirmar == "Cancelar" ]]; then
                        zenity --info --text="Operación cancelada."
                        exit 0 
                    fi

                    # Cambiar el directorio home del usuario
                    if sudo usermod -d "$nuevo_home" -m "$nombre_usuario"; then
                        zenity --info --text="Directorio home de $nombre_usuario cambiado a $nuevo_home correctamente."
                    else
                        zenity --error --text="Error al cambiar el directorio home. Asegúrate de que el usuario existe y de que tienes los permisos necesarios."
                    fi
                else
                    zenity --error --text="Se requieren el nombre del usuario y el nuevo directorio home para continuar."
                fi
}


function OP5 {
                ########################################################################################################################################################################################
                : '
                Esta función dará la opción de poder agregar una contraseña nueva a algún usuario especial al que nosotros queramos cambiar
                '
                ########################################################################################################################################################################################
            nombre_usuario=$(zenity --entry --title="Nombre del Usuario" --text="Inserta el nombre del usuario")
            nueva_contrasenia=$(zenity --password --title="Modificación de Contraseña" --text="Inserta la nueva contraseña para el usuario $nombre_usuario")

            if [[ -n $nombre_usuario && -n $nueva_contrasenia ]]; then
                # Confirmación antes de realizar el cambio
                confirmar=$(zenity --question --text="¿Estás seguro de que quieres cambiar la contraseña de $nombre_usuario?" --extra-button="Cancelar")

                if [[ $confirmar == "Cancelar" ]]; then
                    zenity --info --text="Operación cancelada."
                    exit 0 
                fi

                # Cambiar la contraseña del usuario
                echo -e "$nueva_contrasenia\n$nueva_contrasenia" | sudo passwd "$nombre_usuario"
                if [[ $? -eq 0 ]]; then
                    zenity --info --text="Contraseña de $nombre_usuario cambiada correctamente."
                else
                    zenity --error --text="Error al cambiar la contraseña. Asegúrate de que el usuario existe y de que tienes los permisos necesarios."
                fi
            else
                zenity --error --text="Se requieren el nombre del usuario y la nueva contraseña para continuar."
            fi
    }



function OP6 {

            : ' 
            Esta opción nos permitirá cambiar el umask del usuario que nosotros queramos, por así decirlo el añadiremos los permisos que nosotros queramos al usuario.
            '

            nombre_usuario=$(zenity --entry --title="Modificar Umask" --text="Inserta el nombre del usuario para cambiar su umask")
            nueva_umask=$(zenity --entry --title="Nueva Umask" --text="Inserta el nuevo valor de umask (ejemplo: 0022)")

            if [[ -n $nombre_usuario && -n $nueva_umask ]]; then
                # Confirmo antes de realizar el cambio de mascara
                confirmar=$(zenity --question --text="¿Estás seguro de que quieres cambiar el umask de $nombre_usuario a $nueva_umask?" --extra-button="Cancelar")

                if [[ $confirmar == "Cancelar" ]]; then
                    zenity --info --text="Operación cancelada."
                    return
                fi

                # Modificar el archivo .bashrc o .profile del usuario para cambiar el umask
                archivo_configuracion="/home/$nombre_usuario/.bashrc"  # Asumiendo que el usuario usa bash
                echo "umask $nueva_umask" >> "$archivo_configuracion"
                if [[ $? -eq 0 ]]; then
                    zenity --info --text="umask de $nombre_usuario cambiado a $nueva_umask."
                else
                    zenity --error --text="Error al modificar el umask. Asegúrate de que el usuario existe y tienes permisos necesarios."
                fi
            else
                zenity --error --text="Se requieren el nombre del usuario y el nuevo valor de umask para continuar."
            fi
}

function OP7 {
            ##############################################################################################################################################################################################################
            : '
            En esta función saco un mensaje por pantalla comentándole al usuario que me indique un nombre de grupo, en este caso una vez me dé el nombre del grupo le digo que donde quiere guardar la carpeta compartida 
            recordemos que está será con la que el usuario acceda y pueda interactuar con ella. 
            '
            #############################################################################################################################################################################################################

            nombre_grupo=$(zenity --entry --title="Crear Carpeta Compartida" --text="Inserta el nombre del grupo para la carpeta compartida")
            ruta_carpeta=$(zenity --entry --title="Ubicación de la Carpeta Compartida" --text="Inserta la ruta completa de la nueva carpeta compartida")

            if [[ -n $nombre_grupo && -n $ruta_carpeta ]]; then
                # Creo la carpeta
                sudo mkdir -p "$ruta_carpeta"
                
                # Cambio el grupo propietario de la carpeta al grupo especificado que me dio el usuario
                sudo chgrp "$nombre_grupo" "$ruta_carpeta"

                # Establezco los permisos de: lectura, escritura y ejecución para el grupo en el que este ese usuario.
                sudo chmod 2770 "$ruta_carpeta"

                if [[ $? -eq 0 ]]; then
                    zenity --info --text="Carpeta compartida creada en $ruta_carpeta para el grupo $nombre_grupo."
                else
                    zenity --error --text="Error al crear la carpeta compartida. Asegúrate de tener los permisos necesarios y de que la ruta y el grupo son correctos."
                fi
            else
                zenity --error --text="Se requieren el nombre del grupo y la ruta de la carpeta para continuar."
            fi
}


function OP8 {
                #################################################################################################################################################################################################################################
                : '
                En esta opción lo que hago antes que nada es crear una variable a la cual le indico un directorio oculto que será donde se guarden los homes de los usuarios eliminados por si en un futuro estos se añaden nuevamente y quieren
                volver a obtener sus ficheros o directorios creados. 
                '
                #################################################################################################################################################################################################################################
                directorio_homes_eliminados="/.homes_Usuarios_Eliminados"
                sudo mkdir -p "$directorio_homes_eliminados"

                opcion_borrado=$(zenity --list --title="Borrar Usuario" --column="Opción" --column="Descripción" \
                                1 "Borrar un usuario individual" \
                                2 "Borrar usuarios masivamente por fichero")

                case $opcion_borrado in
                # 
                    1)
                        nombre_usuario=$(zenity --entry --title="Borrar Usuario Individual" --text="Inserta el nombre del usuario a borrar")
                        if [[ -n $nombre_usuario ]]; then
                            if zenity --question --text="¿Estás seguro de que quieres borrar al usuario $nombre_usuario?" --default-cancel; then
                                if [[ -d "/home/$nombre_usuario" ]]; then
                                    sudo mv "/home/$nombre_usuario" "$directorio_homes_eliminados"
                                fi
                                sudo userdel "$nombre_usuario"
                                zenity --info --text="Usuario $nombre_usuario borrado. Su home se ha movido a $directorio_homes_eliminados."
                            else
                                zenity --info --text="Operación cancelada."
                            fi
                        else
                            zenity --error --text="No se ingresó un nombre de usuario."
                        fi
                        ;;
                    2)
                        archivo_usuarios=$(zenity --file-selection --title="Seleccionar Fichero de Usuarios" --file-filter="*.csv")
                        if [[ -f $archivo_usuarios ]]; then
                            while read -r usuario; do
                                echo "Preparándose para borrar usuario: $usuario"
                                if id "$usuario"; then
                                    echo "Usuario encontrado: $usuario. Procediendo a borrar..."
                                    if [[ -d "/home/$usuario" ]]; then
                                        echo "Moviendo /home/$usuario a $directorio_homes_eliminados"
                                        sudo mv "/home/$usuario" "$directorio_homes_eliminados"
                                    fi
                                    echo "Borrando usuario: $usuario"
                                    sudo userdel "$usuario"
                                else
                                    echo "Usuario no encontrado o ya eliminado: $usuario"
                                fi
                            done < "$archivo_usuarios"
                            zenity --info --text="Proceso de borrado completado."
                        else
                            zenity --error --text="Archivo no válido o no seleccionado."
                        fi
                        sudo rm $archivo_usuarios
                        ;;
                    *)
                        zenity --error --text="Opción no válida."
                        ;;
                esac
}

if [[ $USER == "root" ]]; then

while true;
do

menu=$(zenity --title "Automatización de usuarios" --list --column "OPCIONES" \
 --column "DESCRIPCION" --width=800 --height=400 \
1 "EJECUTAR FICHERO PARA AUTOMATIZACION DE USUARIOS" \
2 "CREACION DE UN GRUPO" \
3 "ASOCIAR UN USUARIO O VARIOS A UN GRUPO" \
4 "MODIFICAR /HOME DE USUARIO" \
5 "MODIFICAR PASSWORD DE USUARIOS" \
6 "MODIFICAR MASCARA (UMASK) DE GRUPO AL QUE ESTEN ASOCIADOS USUARIOS" \
7 "CREAR UNA CARPETA COMPARTIDA PARA UN GRUPO" \
8 "BORRAR USUARIO, INDIVIDUAL O MASIVO POR FICHERO" \
9 "SALIR")

case $menu in

1) OP1
;;
2) OP2
;;
3) OP3
;;
4) OP4
;;
5) OP5
;;
6) OP6
;;
7) OP7
;;
8) OP8
;;
9) 
        echo "Hasta la próxima"
        
        break
    ;;

esac


done
    else
        zenity --info --text="Lo siento no eres root, por lo que no puedes ejecutar esta herramienta, ponte en contacto con el root para escalar privilegios"
        exit
fi
