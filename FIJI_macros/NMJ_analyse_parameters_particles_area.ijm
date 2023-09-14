// Define directories
input = getDirectory("Choose Source Directory ");
output = getDirectory("Choose output Directory "); 

// Get the list of files
list = getFileList(input);

// Produce MAX project, split channels

setBatchMode(true);

for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	path = input + list[i];
	fileName = substring(list[i],0,lengthOf(list[i])-4);
	open(path);
	run("Median...", "radius=2");
	run("Select None");
	run("Auto Threshold", "method=Triangle ignore_black ignore_white white");
	setOption("BlackBackground", true);
	run("Set Measurements...", "area mean min integrated limit display redirect=None decimal=3");
	run("Analyze Particles...", "size=2-Infinity show=Masks display include");
	saveAs("Tiff", output+"ROI_"+fileName+".tif");
	run("Close All");
}

selectWindow("Results");
saveAs("Results", output + "Results_Area" + ".csv");
close("Results");

setBatchMode(false);
close("*");
