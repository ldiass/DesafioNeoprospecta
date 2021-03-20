#!/bin/bash
conda_install () {
  if ! type "conda" > /dev/null; then
  	echo "You must install conda!"
  	xdg-open "https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html"
  else
  	 conda install -c bioconda $1 
  fi  	 
}

if ! type "fastqc" > /dev/null; then
   echo " You must install fastQC!"
   conda_install "fastqc"
else
   echo " fastQC installed!"
fi

if ! type "trimmomatic" > /dev/null; then
   echo " You must install trimmomatic!"
   conda_install "trimmomatic"
else
   echo "trimmomatic installed!"
fi


