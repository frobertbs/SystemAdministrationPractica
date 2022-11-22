#!/bin/bash
echo "ASO 22/23 - Assignment 6"
echo "Student Name : Fabian Robert Banu"

echo -e "\n"
echo "Practical Assignment Management"
echo "------------------------------"

echo "Menu"
case=10
while [ $case != "4" ]
do 
	echo -e "\n"
	echo -e "\t 1) Program collection of assignment solution"
	echo -e "\t 2) Pack course assignments"
	echo -e "\t 3) See size and date of a course backup file"
	echo -e "\t 4) End program"

	echo -e "\n \t Option:"
	read case
	case $case in 
	1)
		echo "Menú 1 - Programar recogida de prácticas"
		echo "Asignatura cuyas prácticas desea recoger: "
		read asignatura
		echo "Ruta con las cuentas de los alumnos: "
		read rutaCuentasAlumnos
		echo "Ruta para almacenar prácticas: "
		read rutaAlmacenamientoPrac
		echo "Se va a programar la recogida de las prácticas de ASO para mañana a las 8.00. Origen:$rutaCuentasAlumnos. Destino: $rutaAlmacenamientoPrac "
		echo "Está de acuerdo (s/n)?"
		read confirmacion
		;;
	2)
		echo "Menú 2 - Empaquetar prácticas en la asignatura"
		echo "Asignatura cuyas prácticas se desea empaquetar: "
		read asignaturaEmpaq
		echo "Ruta absoluta del directorio de prácticas: "
		read rutaAbsDirPrac
		echo "Se van a empaquetar las prácticas de la asignatura $asignaturaEmpaq presentes en el directorio $rutaAbsDirPrac"
		echo "¿Está de acuerdo? (s/n)"
		read confirmacionEmpaquetado
		;;
		
	3)
		echo "Menú 3 – Obtener tamaño y fecha del fichero"
		echo "Asignatura sobre la que queremos información: "
		read infoAsignatura
		echo "El fichero generado es aso-221013.tgz y ocupa <n> bytes"
	esac
done
