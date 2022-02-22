from asyncio.windows_events import NULL
from genericpath import exists
from pydoc import doc
from time import sleep
import wget
var = " "
arq = open("lista.txt")

linhas = arq.readlines()

for x in (linhas):
    var = var + x

print("Baixando pacotes:",var)




    




