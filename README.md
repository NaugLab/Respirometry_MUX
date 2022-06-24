# Analyzing Respirometry with Multiplexer (MUX)
## Steps for analyzing MUX data:
1. Save individual .exp files from ExpeData software to your local computer
2. Convert .exp files to .xlsx files manually. Sadly this must be done by hand using the expedata software
3. Once you have converted all of your files to .xlsx you can use python code (MUX_convert_XLSX_to_CSV.py) to a) convert these .xlsx files to .csv files WHILE b) splitting them into seperate files depending on the MUX value (or bee ID). Note: Each file created will also contain the baseline data taken during that party. 
    - Here is how this works:
         1) Start with three ['Group' CSV files](https://colostate.sharepoint.com/:f:/s/Naug-Lab/Enh0bHOebvdBr_CpBy64vNgBaVKoKC9PuPIYOAL4V_R_CQ?e=oDExBH)
         2) Run Python code to turn group data into ['Individual' CSV Files]([url](https://colostate.sharepoint.com/:f:/s/Naug-Lab/Enh0bHOebvdBr_CpBy64vNgBaVKoKC9PuPIYOAL4V_R_CQ?e=cJqTZ8)).  
5. To analyze and view respirometry files INDIVIDUALLY use (MR_Raw_MUX_Single_File.Rmd). This allows you to visualize the data and double check that everything looks good. 
6. Once you are sure the data looks good, use r dcript ([MR_Raw_MUX_All_Files.r]([url](https://github.com/NaugLab/Respirometry_MUX/blob/main/MR_Raw_MUX_All_Files.r))) to run respirometry analyses on ALL of your individual bee files at once. Note: this should spit out one master CSV
