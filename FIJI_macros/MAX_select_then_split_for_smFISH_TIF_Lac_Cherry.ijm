// Define directories
input = getDirectory("Choose Source Directory ");
// output = getDirectory("Choose output Directory "); 
outputCh_C4 = getDirectory("Choose Destination Directory for split channels ");
outputCh_C3_C2 = getDirectory("Choose Destination Directory for csvs ");

// Get the list of files
list = getFileList(input);

// Produce MAX project, split channels

setBatchMode(true);

for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	if (endsWith(list[i], ".tif")) {
		path = input + list[i];
		run("Bio-Formats Importer", "open=[" + path + "] autoscale color_mode=Composite rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_1");
		fileName = substring(list[i],0,lengthOf(list[i])-4);
		run("Select None");
//		do	{
//		waitForUser("Interactive ROI select", "Circle around the glial area");
//		type = selectionType();
//			} while (type ==-1);
		run("Duplicate...", "duplicate");
		run("Split Channels");
		saveAs("Tiff", outputCh_C4 +fileName+"_C4.tif");
		close();
		run("Z Project...", "projection=[Max Intensity]");
		saveAs("Tiff", outputCh_C3_C2+fileName+"_C3.tif");
		close();
		close();
		run("Z Project...", "projection=[Max Intensity]");
		saveAs("Tiff", outputCh_C3_C2+fileName+"_C2.tif");
		run("Close All");
	}
}

setBatchMode(false);
close("*");
