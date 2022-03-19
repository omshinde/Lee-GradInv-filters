[![View Lee and GradInv filters for Image Processing on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://in.mathworks.com/matlabcentral/fileexchange/108259-lee-and-gradinv-filters-for-image-processing)

# Lee-GradInv-filters
This project implements Lee and Gradient-inverse filters which are used in image processing applications. It is a Matlab project completed towards the fulfilment of Satellite Image Processing project in my institute.

### Description
The pre-processing operations of an image include smoothing, averaging, noise-reduction _et cetera_.
This operation can be performed on:
 * Full image i.e. Global operation
 * Sub-part of image i.e. local operation
 
The local operations are performed using Kernels. These kernels are pre-defined.
To obtain output, kernel is convolved with input image. This project processes input image using:
 * **Lee filter**
 * **Gradient-Inverse filter**


### How to run the code?
Open _SIP_Project.m_ using **MATLAB** in your personal computer. A graphical-user interface will appear. Perform the required operations
on the desired image. The code can be further modified using **MATLAB Editor**. The implementation algorithm of the project can be obtained at _Algorithm.pdf_ and flowchart can be obtained at _Flowchart.jpg_.

### Examples:
The _Test Outputs_ folder contains the results obtained by executing code with two different input images. The input images are also available inside the same folder.
