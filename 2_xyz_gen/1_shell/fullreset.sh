#!/bin/bash

echo -e "\n\nBASH: rm 5_ipy";
cd ../5_ipy;
find . -type f ! \( -name '*.' \) -exec rm {} \;

echo -e "\n\nBASH: rm 6_int";
cd ../6_int;
find . -type f ! \( -name '*.' \) -exec rm {} \;

echo -e "\n\nBASH: rm 7_out";
cd ../7_out;
find . -type f ! \( -name '*.' \) -exec rm {} \;

echo -e "\n\n"

echo -e "~~~ Reset ~~~"

echo -e "\n\n\n"

