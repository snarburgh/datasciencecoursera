---
title: "README"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Background
README for Sarah Narburgh's submission

Data is from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## How to Run the Code
1. Download data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip into your working directory in a file titled "getandcleandataproj
3. Open and run run_analysis.R

## Info on run_analysis
All code performed within the file.
Loads used libraries.
Loads necessary data.
Combines test and training data.
Updates dataset to use feature and acitivty names as well as subject IDs.
Keeps only mean and standard deviation measurements.
Updates column names to more human readable versions.
Aggregates the data into a mean per activity and subject.
Writes the aggregated data into .txt file in the folder set up in beginning.

