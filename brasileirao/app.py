from fastapi import FastAPI
import pandas as pd
import requests

app = FastAPI()

@app.get("/")
async def root():
    return { 'message' : 'Hello world!' }


@app.get("/brasileirao")
async def brasileirao():
    header = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"}
    url = "https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a"
    request = requests.get(url, headers=header)

    tables = pd.read_html(request.text)
    df = tables[0]

    #removendo colunas indesejadas
    df.drop("Próx", axis = 1, inplace=True)
    df.drop("%", axis = 1, inplace=True)

    #dividindo a coluna posição em 3: Ranking, variação de posição e nome do time
    posi = df["Posição"].str.split("  ", n = 3, expand=True)
    df.insert(column='Ranking', value=posi[0], loc=0)
    df.insert(column='Variação de Posição', value=posi[1], loc=1)
    df.insert(column='Time', value=posi[2], loc=2)
    #deletando a coluna Posição, original
    del df['Posição']

    # divide a coluna Recentes em 3 usando regex com grupos nomeados
    # a expressão (?P<antepenultima>[A-Z]{1}) significa que estamos a procura de um caracter maiúsculo do alfabeto (de A a Z) e apenas 1
    # a primeira ocorrencia que safistaça essa condição, se chamará "antepenultima"
    # em seguinda, usamos a expressão \s* que significa 0 ou mais caracteres de espaço e continuamos com uma expressão semelhante a anterior.
    # e depois repetimos mais 1 vez, dado que sabemos que são exibidos somente os 3 últimos resultados
    recent_results = df["Recentes"].str.extract('(?P<antepunultima>[A-Z]{1})\s*(?P<penultima>[A-Z]{1})\s*(?P<ultima>[A-Z]{1})', expand=True)
    df.insert(column="Antepenúltimo", value=recent_results["antepunultima"], loc=df.shape[1])
    df.insert(column="Penúltimo", value=recent_results["penultima"], loc=df.shape[1])
    df.insert(column="Último", value=recent_results["ultima"], loc=df.shape[1])

    #  remove a coluna 'Recentes'
    del df["Recentes"]

    # aplicamos a função get_dummies para converter as colunas categóricas em variáveis dummy
    # https://pandas.pydata.org/docs/reference/api/pandas.get_dummies.html
    df = pd.get_dummies(df, columns=["Antepenúltimo", "Penúltimo", "Último"])

    return df.to_dict(orient='records')