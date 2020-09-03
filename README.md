# SpinWaveDispRelMumax3
This Julia script transforms individual CSV files obtained directly from Mumax3 and constructs a 2D matrix of one component of the magnetization where the rows are the time steps and the columns are the space steps. 

The magnetization component recorded in the *.ovf files from mumax3 must be unidimensional, along the component of propagation of the spin wave. The recorded magnetization component must be perpendicular to the transient field used to excite the system. 

Four files are obtained from this Julia script. 

1. The magnetization component as a function of space and time
2. The magnetization component as a function of wavevector and frequency (a Contour Plot of this csv file gives the dispersion relation)
3. The magnetization component as a function of space and frequency
4. The magnetization component as a function of wavevector and time

