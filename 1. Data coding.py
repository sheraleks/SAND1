import pandas as pd

# Загрузка данных
df = pd.read_csv('V2.csv', encoding='utf-8', delimiter=';')
del df[df.columns[0]]
# Составим словарь для кодирования на основе данных из документа "german.doc"
replace_map = {
    "Status" :
    {
        "<0 DM": 1,
        "0-200 DM": 2,
        ">=200 DM": 3,
        "no checking account": 4
    },

    "Credit.history":
    {
        "no credits taken/all credits paid back duly": 1,
        "all credits at this bank paid back duly": 2,
        "existing credits paid back duly till now": 3,
        "delay in paying off in the past": 4,
        "critical account/other credits existing (not at this bank)": 5
    },

    "Purpose":
    {
        "car (new)": 1,
        "car (used)": 2,
        "furniture/equipment": 3,
        "radio/television": 4,
        "domestic appliances": 5,
        "repairs": 6,
        "education": 7,
        "(vacation - does not exist?)": 8,
        "retraining": 9,
        "business": 10
    },

    "Savings.account":
    {
        "<100 DM": 1,
        "100-500 DM": 2,
        "500-1000 DM": 3,
        ">=1000 DM": 4,
        "unknown/ no savings account": 5
    },

    "Personal.status.and.sex":
    {
        "male: divorced/separated": 1,
        "female: divorced/separated/married": 2,
        "male: single": 3,
        "male: married/widowed": 4
    },

    "Job":
    {
        "unemployed/ unskilled  - non-resident": 1,
        "unskilled - resident": 2,
        "skilled employee / official": 3,
        "management/ self-employed/highly qualified employee/ officer": 4
    },

    "foreign.worker":
    {
        "yes": 1,
        "no": 2
    }
}

# Проведем кодирование качественных данных на основе replace_map
df_coded = df.copy()
df_coded.replace(replace_map, inplace=True)
df_coded.to_excel("1. Coded data.xlsx", index=False)
