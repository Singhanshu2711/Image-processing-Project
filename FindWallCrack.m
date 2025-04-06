% Read the image
originalImage = imread('download.jpg');
% Convert the image to grayscale
grayImage = rgb2gray(originalImage);

% Apply Gaussian smoothing to reduce noise
smoothedImage = imgaussfilt(grayImage, 2);

% Use the Canny edge detector to find edges
edgeImage = edge(smoothedImage, 'Canny');

% Morphological operations to enhance and clean up edges
se = strel('line', 3, 90);
dilatedImage = imdilate(edgeImage, se);

% Fill gaps in the edges
filledImage = imfill(dilatedImage, 'holes');

% Remove small objects (potential noise)
cleanedImage = bwareaopen(filledImage, 100);

% Display the original and processed images
figure;
subplot(1, 2, 1);
imshow(originalImage);
title('Original Image');

subplot(1, 2, 2);
imshow(cleanedImage);
title('Crack Detection');

% Optional: Overlay detected cracks on the original image
overlayedImage = imoverlay(originalImage, cleanedImage, [1, 0, 0]); % Red overlay
figure;
imshow(overlayedImage);
title('Cracks Overlayed on Original Image');
