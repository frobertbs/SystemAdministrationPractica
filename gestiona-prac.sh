#!/bin/bash
echo "ASO 22/23 - Práctica 6"
echo "Fabian Robert Banu"

echo -e "\n"
echo "Gestión de prácticas"
echo "------------------------------"

echo "Menú"
opcion=10
while [ $opcion != "4" ]
do 
	echo -e "\n"
	echo -e "\t 1) Programar recogida de prácticas"
	echo -e "\t 2) Empaquetado de prácticas de una asignatura"
	echo -e "\t 3) Ver tamaño y fecha del fichero de una asignatura"
	echo -e "\t 4) Finalizar programa"

	echo -e "\n \t Opción:"
	read case
	case $case in 
	1)
		echo "Menú 1 - Programar recogida de prácticas"
		echo "Asignatura cuyas prácticas desea recoger: "
		read asignatura
		echo "Ruta con las cuentas de los alumnos: "
		read directorio_origen
		if [ ! -d "$directorio_origen" ]; then
			echo "El directorio_origen no existe $(date)" >> informe-prac.log 2>&1
			echo "Porfavor introduce un directorio que exista: "
			read directorio_origen
		fi
		echo "Ruta para almacenar prácticas: "
		read directorio_destino
		if [ ! -d $directorio_destino ]; then
			$(mkdir $directorio_destino)
		fi
		echo "Se va a programar la recogida de las prácticas de ASO para mañana a las 8.00. Origen:$directorio_origen. Destino: $directorio_destino"
		echo "Está de acuerdo (s/n)?"
		read acuerdo
		if [ $acuerdo == "s" ]; then
			cronjob="* 8 * * * /home/frobertbs/Documents/ASO/practica6/recoge-prac.sh $directorio_origen $directorio_destino"
			(crontab -u frobertbs -l; echo "$cronjob" ) | crontab -u frobertbs -
		fi

		;;
	2)
		echo "Menú 2 - Empaquetar prácticas en la asignatura"
		echo "Asignatura cuyas prácticas se desea empaquetar: "
		read asignaturaEmpaq
		echo "Ruta absoluta del directorio de prácticas: "
		read rutaAbsDirPrac
		echo "Se van a empaquetar las prácticas de la asignatura $asignaturaEmpaq presentes en el directorio $rutaAbsDirPrac"
		nombreArchivo=$asignatura-$(date '+%y%m%d')
		echo "¿Está de acuerdo? (s/n)"
		read confirmacionEmpaquetado
		if [ confirmacionEmpaquetado == "s" ]; then
			tar -cvzf $nombreArchivo.tgz $rutaAbsDirPrac
		fi
		;;
		
	3)
		echo "Menú 3 – Obtener tamaño y fecha del fichero"
		echo "Asignatura sobre la que queremos información: "
		read infoAsignatura
		nombreArchivo=$asignatura-$(date '+%y%m%d')
		echo "El fichero generado es aso-221013.tgz y ocupa <n> bytes"
		tar "$nombreArchivo.tar.tgz" 
		# date '+%y%m%d	// muestra 221209
	esac
done
