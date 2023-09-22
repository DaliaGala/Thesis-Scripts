// Define directories
input = getDirectory("Choose Source Directory ");
output = getDirectory("Choose output Directory "); 

// Get a list of all files in the directory with a specific file extension (e.g., .tif)
list = getFileList(input);

// Set the cropping dimensions (in pixels)
topCrop = 20;
bottomCrop = 20;


setBatchMode(true);

// Loop through each file in the list
for (i = 0; i < list.length; i++) {
	showProgress(i+1, list.length);
	path = input + list[i];
	title = substring(list[i],0,lengthOf(list[i])-4);
	open(path);

    // Get the image width and height
    width = getWidth();
    height = getHeight();
    
    // Set the cropping region (20 pixels from the top and 20 pixels from the bottom)
    makeRectangle(0, topCrop, width, height - topCrop - bottomCrop);
    run("Crop");

    // Save the cropped image with a new name
    saveAs("Tiff", output + title + "_cropped.tif");

    // Close the original image without saving changes
    close();
}

setBatchMode(false);
close("*");

