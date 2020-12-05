import pandas as pd
import csv

def get_descriptores():
    descriptores = {}
    descriptores_df = pd.read_csv('../datasets/encoded/DEV_Descriptores_2020.csv', engine="c")

    for index, row in descriptores_df.iterrows():
        descriptores[str(row['Variable'])] = str(row['Etiqueta'])
    return descriptores

def get_valores():
    valores = {}
    valores_df = pd.read_csv('../datasets/encoded/DEV_Valores_2020.csv', engine="c")

    for index, row in valores_df.iterrows():
        if row['Variable'] not in valores: valores[row['Variable']] = {}
        valores[str(row['Variable'])][str(row['Valor'])] = str(row['Etiqueta'])
    return valores

def decode(df, descriptores, valores):
    df = df.applymap(str)
    cols = df.columns

    for index, row in df.iterrows():
        for col in cols:
            if str(col) in valores and str(row[col]) in valores[str(col)]:
                df.at[index, col] = valores[str(col)][str(row[col])]

    df.columns = [descriptores[c] for c in cols]

    return df
        

def main():
    descriptores = get_descriptores()
    valores = get_valores()

    devueltos_df = pd.read_csv('../datasets/encoded/devueltos_2020.csv', engine="c")

    envueltos_decoded_df  = decode(devueltos_df, descriptores, valores)

    envueltos_decoded_df.to_csv(r'../datasets/decoded/devueltos_2020.csv', index=False, header=True, sep=',', quoting=csv.QUOTE_NONNUMERIC)

main()