# Respirometry_MUX
## Steps for analyzing MUX data:
1. Save individual .exp files from ExpeData software to your local computer
2. Convert .exp files to .xlsx files manually. Sadly this must be done by hand using the expedata software
3. Once you have converted all of your files to .xlsx you can use python code ([MUX_convert_XLSX_to_CSV.py]([url](https://github.com/NaugLab/Respirometry_MUX/blob/main/MUX_convert_XLSX_to_CSV.py))) to a) convert these .xlsx files to .csv files WHILE b) splitting them into seperate files depending on the MUX value (or bee ID). Note: This each file created will also contain the baseline data taken during that party. 
4. In R, use r script ([MR_Raw_Exp1_MUX_All_Files.r]([url](https://github.com/NaugLab/Respirometry_MUX/blob/main/MR_Raw_Exp1_MUX_All_Files.r))) to run respirometry analyses on all of you undividual bee files at once. Note: this should spit out one master CSV
