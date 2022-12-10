dirs=$(ls $1)	# guardamos todos los directorios de los alumnos

for i in $dirs
	do
		aux=$(echo $i)
		for j in $(ls $1/$aux)
			do
				cp -rp $1/$aux/$j $2
		done
done
