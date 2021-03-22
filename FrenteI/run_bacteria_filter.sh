#!/bin/bash
if ! pip3 list | grep biopython > /dev/null; then
   echo "You must install biopython"
   pip3 install biopython
else
   echo "biopython installed"
fi

if ! pip3 list | grep pandas > /dev/null; then
   echo "You must install pandas"
   pip3 install pandas
else
   echo "pandas installed"
fi

#Check if file type exists to avoid error
count=`ls -1 *.fasta 2>/dev/null | wc -l`
if [ $count != 0 ]
	then
		for i in *.fasta; do
		    python3 bacteria_filter.py "$i" 		    
		done
fi

count=`ls -1 *.fa 2>/dev/null | wc -l`
if [ $count != 0 ]
	then
		for i in *.fa; do
		    python3 bacteria_filter.py "$i" 
		    echo $i
		done
fi

