#!/bin/bash

#funciones programa

recogida_de_practicas(){
		echo "Menú 1 - Programar recogida de prácticas"
		echo "Asignatura cuyas prácticas desea recoger: "
		read asignatura
		echo "Ruta con las cuentas de los alumnos: "
		read directorio_origen
		if [ ! -d $directorio_origen ]; then
			echo "$(date) El directorio_origen no existe" >> informe-prac.log 2>&1
			echo "Porfavor introduce un directorio que exista: "
			read directorio_origen
		fi
		echo "Ruta para almacenar prácticas: "
		read directorio_destino
		if [ ! -d $directorio_destino ]; then
			$(mkdir $directorio_destino)
			echo "$(date) Se ha creado el directorio destino porque no estaba creado" >> informe-prac.log 2>&1
		fi
		echo "Se va a programar la recogida de las prácticas de $asignatura para mañana a las 8.00. Origen:$directorio_origen. Destino: $directorio_destino"
		echo "Está de acuerdo (s/n)?"
		read acuerdo
		if [ $acuerdo == "s" ]; then
			cronjob="*0 8 * * * /home/frobertbs/Documents/ASO/practica6/recoge-prac.sh $directorio_origen $directorio_destino"
			(crontab -u frobertbs -l; echo "$cronjob" ) | crontab -u frobertbs -
		fi
}

empaquetar_archivo(){
		echo "Menú 2 - Empaquetar prácticas en la asignatura"
		echo "Asignatura cuyas prácticas se desea empaquetar: "
		read asignaturaEmpaq
		echo "Ruta absoluta del directorio de prácticas: "
		read rutaAbsDirPrac
		
		#Comprobamos si el directorio a salvar existe o no 
		if [ ! -d "$rutaAbsDirPrac" ]; then
			echo "$(date) El $rutaAbsDirPrac no existe" >> informe-prac.log 2>&1
			break;
		fi
		cd "$rutaAbsDirPrac"
		echo "Se van a empaquetar las prácticas de la asignatura $asignaturaEmpaq presentes en el directorio $rutaAbsDirPrac"
		
		nombreArchivo="$asignaturaEmpaq-$(date '+%y%m%d').tgz"
		
		echo "¿Está de acuerdo? (s/n)"
		read confirmacionEmpaquetado
		if [ $confirmacionEmpaquetado == "s" ]; then
			tar -czvf "$nombreArchivo" $rutaAbsDirPrac
		fi
}

tamanio_fecha_archivo(){
		echo "Menú 3 – Obtener tamaño y fecha del fichero"
		echo "Asignatura sobre la que queremos información: "
		read infoAsignatura
		cd $directorio_destino
		archivo=$(find . -name "*$infoAsignatura*" -print) # - saca por la salida el nombre completo del archivo
		echo "El fichero generado es $(echo $archivo | cut -c 3-) y ocupa $(wc -c $archivo | cut -d " " -f 1) bytes"
}

echo "ASO 22/23 - Práctica 6"
echo "Fabian Robert Banu"

echo -e "\n"
echo "Gestión de prácticas"
echo "------------------------------"

echo "Menú"
opcion=99
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
		recogida_de_practicas
		;;
	2)
		empaquetar_archivo
		;;
		
	3)
		tamanio_fecha_archivo
		;;
	4)
		opcion=4
		;;
		
	*)
		echo "Elige una opción válida"
		;;
	esac
done
