# Analyzing Respirometry with Multiplexer (MUX)
## Steps for analyzing MUX data:
1. Save individual .exp files from ExpeData software to your local computer
2. Convert .exp files to .xlsx files manually. Sadly this must be done by hand using the expedata software
3. Once you have converted all of your files to .xlsx you can use this python code [MUX_convert_XLSX_to_CSV.py](https://github.com/NaugLab/Respirometry_MUX/blob/main/MUX_convert_XLSX_to_CSV.py) to a) convert these .xlsx files to .csv files WHILE b) splitting them into seperate files depending on the MUX value (or bee ID). Note: Each file created will also contain the baseline data taken during that party. 
    - Here is how this works:
         1) Start with three ['Group' CSV files](https://colostate.sharepoint.com/:f:/s/Naug-Lab/Eh85-u6ZhrNKuVfMDuVg7I0B_709_xjHMGcVSdY00JHJlQ?e=c5cIVd)
         2) Run Python code to turn group data into ['Individual' CSV Files](https://colostate.sharepoint.com/:f:/s/Naug-Lab/Enh0bHOebvdBr_CpBy64vNgBaVKoKC9PuPIYOAL4V_R_CQ?e=cJqTZ8).  
5. To analyze and view respirometry files INDIVIDUALLY use [MR_Raw_MUX_Single_File.Rmd](https://github.com/NaugLab/Respirometry_MUX/blob/main/MR_Raw_MUX_Single_File.Rmd). This allows you to visualize the data and double check that everything looks good. 
6. Once you are sure the data looks good, use this r script [MR_Raw_MUX_All_Files.r](https://github.com/NaugLab/Respirometry_MUX/blob/main/MR_Raw_MUX_All_Files.r) to run respirometry analyses on ALL of your individual bee files at once. Note: this should spit out one master CSV
     - Here is how this works:
          1) This r code will take all [Individual CSV files](https://colostate.sharepoint.com/:f:/s/Naug-Lab/Enh0bHOebvdBr_CpBy64vNgBaVKoKC9PuPIYOAL4V_R_CQ?e=cJqTZ8), analyze the date and report one ['Master' CSV file](https://colostate.sharepoint.com/:x:/s/Naug-Lab/EfFEcR0dkaRKkHAxy8GMU7cBBC1zizYvsi0Cz_WgHO7YQg?e=fnDE0q) with date from each bee. 





######################################################
Here is the link to google drive folder with individual bee csv files. You will need to seperate the Rest from the Shake files. Let me know if you want me to do that.
https://drive.google.com/drive/folders/1DGB_V8t1LpRI21lD5ABtLKJ5qFg8o2M7?usp=share_link
