// Define directories
input = getDirectory("Choose Source Directory ");
// output = getDirectory("Choose output Directory "); 
outputCh = getDirectory("Choose Destination Directory for split channels ");
outputROI = getDirectory("Choose Destination Directory for csvs ");

// Get the list of files
list = getFileList(input);

// Produce MAX project, split channels

//setBatchMode(true);

for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	if (endsWith(list[i], ".tif")) {
		path = input + list[i];
		run("Bio-Formats Importer", "open=[" + path + "] autoscale color_mode=Composite rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_1");
		fileName = substring(list[i],0,lengthOf(list[i])-4);
		run("Select None");
		do	{
		waitForUser("Interactive ROI select", "Circle around the glial area");
		type = selectionType();
			} while (type ==-1);
		run("Duplicate...", "duplicate");
		run("Split Channels");
		saveAs("Tiff", outputCh+fileName+"_C4.tif");
		close();
		close();
		close();
		run("Z Project...", "projection=[Max Intensity]");
		redirectImageTitle = "MAX_C1-" + fileName + "-1.tif";
		selectWindow(redirectImageTitle);
		rename("MaxProject");
		run("Median...", "radius=2");
		run("Select None");
		run("Auto Threshold", "method=Triangle ignore_black ignore_white white");
		setOption("BlackBackground", true);
		run("Set Measurements...", "area mean min integrated limit display redirect=MaxProject decimal=3");
		run("Analyze Particles...", "size=2-Infinity show=Masks display include");
		saveAs("Tiff", outputROI+"ROI_"+fileName+".tif");
		run("Close All");
		selectWindow("Results");
		close("Results");
	}
}

//setBatchMode(false);
close("*");
