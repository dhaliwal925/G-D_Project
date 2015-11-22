# Run Analysis on Tracker Data
The script contained with this project retrives data relating to [Human Activity Tracking](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) in order to clean data for further use.

The script first reads in tracker data from file `test` dataset and subsets based on columns
containing data relating to `mean()` and `std()` measures for each type tracker data. It then
combines `subject` and `activity_type` data with subset tracker data - renaming the
`activity_type` obervations with appropriate activities. The script adds an additional column to
to define dataset from which the data were obtained. Appropriate headers are also assigned to all
columns.

The above activities are repeated for data containted in the `train` dataset. After which the
script combines the two datasets into one table - `final_set`.

Using data in `final_set` the script then finds the mean of tracker data by subject and activity
and ouputs table `final_mean`.