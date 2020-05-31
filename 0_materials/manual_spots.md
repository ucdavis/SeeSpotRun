### Manual spot calling

* To begin, copy three timepoints (for triplicate measurements) from the movie into `example_folder/7_manonetwo/`.
	* If the [VidCod3 commands](0_materials/VidCod3.txt) were used, then `multi_T00_MIP.tiff`, `multi_T04_MIP.tiff`, and `multi_T09_MIP.tiff`, can be transferred.
	* Prepare a z-MIP of each of the timepoints; `stack0.tif`, `stack4.tif`, and `stack9.tif`.
* Open the `*_viewpost.png` figure and the first stack timepoint, find the location of each cropped cell and determine by eye whether one or two spots are apparent, recording the results in a [spreadsheet](0_materials/video_onetwo_rep0.xlsx).
* Once the three timepoints have been scored, run the [spot obs rep script](0_sheets/spotobsreps_4.R) to combine the manual scores with the cell observations.
* The [spotobsrep_comb script](0_materials/spotobsrep_comb6.R) can be used to combine the manual scores from multiple experiments.
* The [obsspotreps_conf_comb script](0_materials/obsspotreps_conf_comb_6exp.R) can be used to combine the pooled manual scores with the confirmed distances, for a comparison of manual vs computational spot calling.
	* The [confdist_comb script](0_materials/confdist_comb5.R) can be used to pool the distances from the manually confirmed computational spot calling.
