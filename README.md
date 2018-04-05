# Tidy-Project
Merges multiple files for test and training sets, producing one tidy detailed file and one summary file

To run this code, only source() and the run_analysis.R's file location need to be entered into the console. The user may also need to
change the setwd commands within the script to a pathway that matches their needs more, but otherwise the function will download the zip
file, combine the files within it, and export the summary and detailed text files on its own

This code pulls from 3 R libraries: dplyr, tidyr, and reshape2. Tidyr and reshape2 are used for the separate and melt functions
respectively, while dplyr is used for several other table modifying functions

The test and training sets are read into R, combined, and moulded in the combineTables_inSet function. This function takes the file 
locations of the ID, X, and Y files, as well as a string representing the type of set (test or train), and reads each file. The X set is
given the given the column names from the features table (as these names represent each column in order), and the set ID file,
representing the subjects, is titled "SubjectID". The type variable is then amended onto the ID set, the class label variable is taken
from the Y set, which will be used to get the activity name, and the first 6 columns are taken from the X set (being the mean and st dev 
variables for the 3 axes) and added to the ID set. The ID set is then merged with the activity labels table on the ClassLabel field, 
which both share (the resulting file then needs to be rearranged). The final step is the set_sep pipeline, which melts the measurement
columns from set X into 2 columns: a variable column representing the column's original name and a value column for their respective
values (titled MeasurementValue). The variable column is separated into 3 columns: first being the signal source (which are all take from
body acceleration signals here), the function applied on these values, and the axis. ClassLabel is then removed as it's redundant.
The resulting dataset is returned to the program

The main body of the script sets the wd and downloads and unzips the zip file from the internet. All relevant files to this analysis
(the activity labels, features, test files, and training files) are assigned pathways. The test and training data are run through
combineTables_inSet function and merged, converted to a tibble, grouped on the SubjectID adn ActivityName, and summarized on the mean. 
The resulting summary table is exported to a text file, along with the ungrouped tibble file with full details
