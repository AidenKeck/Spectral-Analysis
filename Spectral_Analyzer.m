%{ 
Spectral Analyzer (with comprehensible comments)
    This code takes the a file and analyzes the middle row of pixels to
    plot the intensity of the pixel versus its corresponding wavelength.
    This code has been calibrated specifically to the right-hand-side of
    our apparatus.
%}
% Name of the image file
img = '4_13_H.jpg';

% Set to true if you want the top peak to be at 100%
% Else the plot will just be the raw intensity values
normalize = true;

% Set to true if you want to save the plot as a png automatically
save = false;

% Color for the plot
color = 'blue';
% Line size for the plot
line_thickness = 2.5;
% Only pixels greater than `left_border` will be plotted
left_border = 150;

% Read in image and convert to greyscale
myImage = imread(img);
lineIMG = rgb2gray(myImage);

% Find width and height of image in pixels
width = length(lineIMG(1,:));
height = length(lineIMG(:,1));

% Which horizontal line we want to sample
r1 = floorDiv(height,2);

% Find intensity (0,255) for each pixel across line
for i = 1:width
    intensity_value(i) = lineIMG(r1, i); 
end

% Scale and offset values we calculated using the gas lamps
scale = 831.6504 / width;
offset = 10825.86685 / width;

% Scaling & offsetting the x-axis
independent_axis = scale:scale:width*scale;
independent_axis = independent_axis + offset;

if normalize
    maxim = double(max(intensity_value(left_border:width)));
    intensity_value = double(intensity_value) / maxim * 100;
end

plt = plot(independent_axis(left_border:end), ...
    intensity_value(left_border:width), ...
    Color = color);

% Setting the title & axes
title('Intensity vs. Wavelength');
xlabel('Wavelength (nm)')
ylabel('Relative Intensity (%)');
plt.LineWidth = line_thickness;
if save
    saveas(fig,strcat(strrep(img,'.jpeg',''),'_graph.png'),'png')
end
