#!/bin/bash
#set -o nounset
set -o errexit
readonly script_name=$0
readonly parameter1=$1
#echo "***************************************************************"
#echo "*                                                             *"
#echo "*            https://github.com/igorsapozhnikov               *"
#echo "*                                                             *"
#echo "***************************************************************"
#echo "For correct work this script needs:"
#echo "Image Magick pack (sudo apt-get install imagemagick)"
#echo "Edit POLYCY (sudo nano /etc/ImageMagick-6/policy.xml)"
#echo 'Add the next line: '
#echo '<policy domain="module" rights="read|write" pattern="{PS,PDF,XPS}" />"'
#echo 'Comment the next lines: 
#<!--
#  <policy domain="coder" rights="none" pattern="PS" />
#  <policy domain="coder" rights="none" pattern="PDF" />
#  <policy domain="coder" rights="none" pattern="XPS" />
#-->'
#
#echo "***************************************************************"
#echo ""
echo "==============================================================="
echo "[START] You run script with name $script_name and parameter $parameter1"
echo "---------------------------------------------------------------"
src=$(pwd)
src2=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
echo "You run SUPER script in " $src
echo "You run THIS script in "$src2
echo "---------------------------------------------------------------"
echo "Machine name: "$HOSTNAME
echo "Parent process ID: "$PPID
echo "PATH: "$PATH
echo "---------------------------------------------------------------"

case $parameter1 in

-pdftojpg)
	START_TOTAL_TIME=$(date +%s)
	rm -rf out_pages
	mkdir -p out_pages
	IFS='\n'
	files_e=`find ./ -maxdepth 1 -name '*.pdf' -type f`;
	read -r -a files <<< "$files_e"
	countfiles=`find ./ -maxdepth 1 -name '*.pdf' -type f|wc -l`;
	echo "Found $countfiles files (in this directory):"
	echo $files_e
#	echo "${files_e[1]}"
	i=1
	for file_l in "${files[@]}";
	do
	START_TIME=$(date +%s)
	filename="${file_l##*/}"
	del_name="out_pages/$filename"
	rm -rf $del_name
	mkdir -p $del_name
	make_filename="$del_name/$filename-%04d.jpg"
	echo -n "[$i/$countfiles] Runing for "$file_l;
	sudo convert $file_l +adjoin $make_filename
	END_TIME=$(date +%s)
	DIFF=$(($END_TIME - $START_TIME))
	echo "-->[OK-$DIFF sec.] "
	i=$((i=i+1))
	done
	END_TOTAL_TIME=$(date +%s)
	DIFF_TOTAL=$(($END_TOTAL_TIME - $START_TOTAL_TIME))
	echo "[TOTAL TIME:$DIFF_TOTAL sec.] "
;;

-cut)
	START_TOTAL_TIME=$(date +%s)
	rm -rf out_images
	mkdir -p out_images
	files=`find ./ -maxdepth 1 -name '*.jpg' -type f`;
	countfiles=`find ./ -maxdepth 1 -name '*.jpg' -type f|wc -l`;
	echo "Found $countfiles files (in this directory):";
	echo $files
	i=1
	for file in $files
	do
	START_TIME=$(date +%s)
	echo -n "[$i/$countfiles] Runing for "$file;
	filename="${file##*/}"
	make_filename="out_images/$filename-%02d.jpg"
	convert -sample 1000% -crop 1x3@ -scene 1 $file $make_filename;
	END_TIME=$(date +%s)
	DIFF=$(($END_TIME - $START_TIME))
	echo "-->[OK-$DIFF sec.] "
	i=$((i=i+1))
	done
	END_TOTAL_TIME=$(date +%s)
	DIFF_TOTAL=$(($END_TOTAL_TIME - $START_TOTAL_TIME))
	echo "[TOTAL TIME: $DIFF_TOTAL sec.] "
;;

*)
	echo "Parametr not found!"
	echo "Please use:"
	echo "-pdftojpg for convert PDF to JPG"
	echo "-cut for cut JPG into equal parts"
;;
esac

echo "==============================================================="
echo "[STOP] The end of script was reached."
exit 0