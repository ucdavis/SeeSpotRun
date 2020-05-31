#!/bin/bash

#open 1_shell folder in terminal
# run ./bash1.sh

SECONDS=0

#convert jupyter notebook to py
echo -e "\n\nBASH: convert jupyter to py";
cd ../4_not;
jupyter nbconvert --output-dir='../5_ipy' *.ipynb --to script 2>>/dev/null;
# 2>>/dev/null prevents message in terminal

#run all python scripts
echo -e "\n\nBASH: run py";
cd ../5_ipy;
for a in *_run.py;
do ipython $a;
done;

##run all R scripts
#echo -e "\n\nBASH: R script";
#cd ../4_not;
#for a in *_run.R;
#do Rscript $a;
#done;


duration=$SECONDS


echo -e "\n\n"

echo -e "~~~ ComPyLaTor ~~~"

echo -e "\n"

echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."

echo -e "\n"

echo -e "~~~ *** ~~~"

echo -e "\n\n\n"





