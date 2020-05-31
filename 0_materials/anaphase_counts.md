### Anaphase counts

* Go to `example_folder/8_anaprog/` and make a new folder `selections`, and inside this folder:
	* Make a new folder called `anasel`.
	* In `anasel`, make a copy of the [selection combiner](0_materials/txtcomb1.R).
	* Make a new folder called `multi`.
	* Make a copy of the [animate script](0_materials/animate2.txt).
	* Make a copy of the [anaphase cell position video script](0_materials/cellpos_ana3v3bar_typ2_v2.R).

* Make a copy of the zt-MIP into `example_folder/8_anaprog/` and rename `*_anatet.tif`.
* Open `*_anatet.tif` in ImageJ/FIJI and set scale 512 to 833 (or 1996, see [ori info](0_materials/ori.txt)).
* Use free select to make a circle around each anaphase cell.
* Save the xy coordinates for each cell in the anasel folder.
	* Use `#-i.txt` name for an anaphase I cell
	* Use `#-ii.txt` name for an anaphase II cell.
	* \# is number of anaphase cells counted in field.
* Open the [selection combiner](0_materials/txtcomb1.R), change directory, and run.

* Go to `example_folder/4_dist_out/` and open the `*_viewpost.png` image in ImageJ/FIJI.
* Set the origins depending on image size (see [ori info](0_materials/ori.txt)).
* Click on each number with the multi-point tool.
* Press Cmd+m to gete measurements.
* Go to to `example_folder/3_cellobs/`, open observation spreadshet and paste the xy positions into `num`, `X`, and `Y`, columns, then save the spreadsheet as `*_xy.xlsx`.
* Copy the `*_xy.xlsx` spreadsheet into the `example_folder/8_anaprog/selections` folder.

* Copy the [mipjpg script](0_materials/mipjpg.txt) to `example_folder/2_vid_mip/2_vid/`.
* Open the `Stack.tif` in ImageJ/FIJI, auto adjust brightness and contrast, and save as `Stackbc.tif`.
* Open `mipjpg.txt`, change directory, and copy commands into terminal.
* Change file numbering to use leading zeros (01-09).
* Copy `jmip` folder to `example_folder/8_anaprog/selections/`.

* Open the [anaphase cell position video script](0_materials/cellpos_ana3v3bar_typ2_v2.R) and change directory.
* Change xy file name and run.
* Open the [animate script](0_materials/animate2.txt), change directory, and run in terminal.
