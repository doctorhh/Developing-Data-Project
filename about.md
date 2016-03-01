---
output: html_document
---

## About
In line with the Self-Quantified trends, and the Fitbit, Nike and Jawbone connected devivce, this  application is a prototype to validate the idea of collecting information from MyFitnessPal, the Sleep Cycle iOS and Withing application in order to study the potential correlation of food intake and Sleep Quality measure as well as Resting Heart rate. Future version will include predictive performance model.

This application reads a consolidated and cleaned version of (3) csv file(namely the MyFitnessPal, Sleep Cycle and Withing .csv). The clean_tidy_data.R file is located in the GitHub repo.

The application exposes the Carbs, Fat and Protein consumption in gram for everyday where a measurement was taken and heart rate measurement exist.

Regression Graphic Tab
- Select the required macronutriment;
- Select the desired dependent variable;

Finally, the Histogram shows the consumption of either Carbs, Fat or Protein consummed over the days and the dataset represent the content of the consolidate .csv file.

Histogram of consumption
- Select the required macronutriement (only);
- The desired dependent variable doesn't have any effect.

Since the author of this application just recently started to use the Sleep Cycle iOS application, there is not substantial data yet to benefit from this application.

Source code for ui.R and server.R files are available on the https://github.com/doctorhh/Developing-Data-Project.

