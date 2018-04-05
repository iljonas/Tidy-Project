# Code Book

## Subject and Activity Summary.txt
SubjectID - the ID of the subject from the raw data

ActivityName - name of the activity the subject was engaged in when the data was recorded

AverageMeasurement - average measurement, across the mean and st dev, for all axes. Broken down by the SubjectID and ActivityName

## Tidy Detailed Data.txt
SubjectID - the ID of the subject from the raw data

Set - The learning set this data was taken from, either from TEST or TRAINING

ActivityName - name of the activity the subject was engaged in when the data was recorded

SignalSource - the source of the data signal that the measurement was taken from; either gyroscopic or acceleration

Function - the function applied to the data collected

Axis - the axis of movement that the measurement was taken on (X, Y, Z)

MeasurementValue - actual value of the measurement. All measurements are either means or st devs of patient information collected as 
described in the previous 3 variables. These values were already calculated in the raw data I retrieved them from
