import os
import wget
from multiprocessing import Process, Lock

arq = open("lista.txt")

lista = arq.readlines()

n = 0

def process_fn(label, lock):
    msg = "%s: nome:%s, pid:%s"
    with lock:
        print(msg % (label, __name__, os.getpid()))

if __name__ == "__main__":
    lock = Lock()
    p = Process(target=process_fn, args=("Iniciando Processo de Download Paralelo", lock))
    p.start()
    p.join
    for i in lista:
        Process(target=process_fn, args=((("Processo rodando:", (lista[n]))), lock)).start()
        wget.download(lista[n])
        n = n +1
        
    