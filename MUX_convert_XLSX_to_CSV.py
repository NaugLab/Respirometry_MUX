# Importing the required libraries
import openpyxl
import pandas as pd
import glob
import math

cols = ["Seconds", "Barometric_Pressure", "O2", "FlowSet", "Flow_Rate", "CO2", "Mux__Aux1_", "Temp__Aux2_", "FoxBoxTemp"]

# Loop through xml files in directory
for filepath in glob.iglob('*.xlsx'):
    sheet = openpyxl.load_workbook(filepath).active
    dict = {}

    # Skip the row with column names, then iterate through each row
    for row in sheet.iter_rows(min_row=2):
        key = math.floor(row[6].value)
        if ( not dict.get(key) ):
            dict.update({key: []})
        dict.get(key).append({"Seconds": row[0].value,
                    "Barometric_Pressure": row[1].value,
                    "O2": row[2].value,
                    "FlowSet": row[3].value,
                    "Flow_Rate": row[4].value,
                    "CO2": row[5].value,
                    "Mux__Aux1_": key,
                    "Temp__Aux2_": row[7].value,
                    "FoxBoxTemp": row[8].value})

    # Add the baseline data to each of the other tables
    for key in dict.keys():
        if ( not key == 8 ):
            newTable = dict.get(8).copy()
            newTable.extend(dict.get(key))
            dict.update({key: newTable })

    # Remove the baseline table
    dict.pop(8)

    # Create a data frame for each Mux__Aux1_ value
    for key in dict.keys():
        df = pd.DataFrame(dict.get(key), columns=cols)
        # Writing dataframe to csv
        df.to_csv('./Output/'+filepath.removesuffix('.xlsx')+'_'+str(key)+'.csv', index=False)
