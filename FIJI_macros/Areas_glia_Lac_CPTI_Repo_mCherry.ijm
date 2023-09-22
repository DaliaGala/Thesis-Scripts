// Define directories
input = getDirectory("Choose Source Directory ");
output = getDirectory("Choose output Directory "); 
outputROI = getDirectory("Choose Destination Directory for ROI ");
outputCh = getDirectory("Choose Destination Directory for split channels ");

// Get the list of files
list = getFileList(input);

// Split channels, save

for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	if (endsWith(list[i], ".tif")) {
		path = input + list[i];
		run("Bio-Formats Importer", "open=[" + path + "] autoscale color_mode=Composite rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_1");
		fileName = substring(list[i],0,lengthOf(list[i])-4);
		run("Select None");
		do	{
		waitForUser("Interactive ROI selelect", "Circle around the synapse");
		type = selectionType();
			} while (type ==-1);
		run("Duplicate...", "duplicate");
		setBackgroundColor(0, 0, 0);
		run("Clear Outside");
		run("Select None");
		saveAs("Tiff", outputROI+"ROI_"+fileName+".tif");
		run("Split Channels");
		close();
		saveAs("Tiff", outputCh+fileName+"_C3.tif");
		close();
		saveAs("Tiff", outputCh+fileName+"_C2.tif");
		close();
		run("Close All");
	}
}
//setBatchMode(false);
close("*");
