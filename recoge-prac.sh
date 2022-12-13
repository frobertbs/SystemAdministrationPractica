dirs=$(ls $1) # listar todos los directorios del directorio_origen 

for i in $dirs	# recorrer cada directorio (cada alumno)
	do
		aux=$(echo $i)	# aux es igual al nombre del directorio del alumno
		for j in $(ls $1/$aux)	# listar contenido del directorio directorio_origen/nombre_alumno
			do
				cp -rp $1/$aux/$j $2 # copiar fichero en el directorio_destino
				nombrePractica=$(echo "$aux.sh")
				mv "$2/$j" "$2/$nombrePractica"
		done
done
