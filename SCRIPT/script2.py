from asyncio.windows_events import NULL
from genericpath import exists
from pydoc import doc
from time import sleep
import wget
lista = [
"http://ftp.de.debian.org/debian/pool/main/liba/libaacs/libaacs-dev_0.7.1-1+b1_amd64.deb",
"http://ftp.de.debian.org/debian/pool/main/liba/libaacs/libaacs-dev_0.7.1-1+b1_armel.deb",
"http://ftp.de.debian.org/debian/pool/main/liba/libaacs/libaacs-dev_0.7.1-1+b1_armhf.deb",
"http://ftp.de.debian.org/debian/pool/main/liba/libaacs/libaacs-dev_0.7.1-1+b1_i386.deb",
"http://ftp.de.debian.org/debian/pool/main/liba/libaacs/libaacs-dev_0.8.1-2_amd64.deb"
]

i = 0

wget.download(lista[i])
wget.download(lista[i+1])
wget.download(lista[i+2])
wget.download(lista[i+3])
wget.download(lista[i+4])


#/prlist <> NULL:
#    print("Fazendo donwload de arquivos")
#    sleep = 2
#    wget.download(lista[i])
#   
