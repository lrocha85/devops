import threading
import wget
from threading import Thread
import time
import multiprocessing as mp
from multiprocessing import Process

arq = open("lista.txt")

lista = arq.readlines()

i = 0

def process_fn():

    print("Nome processo e", mp.current_process())
    wget.download(lista[i])
    print("Nome processo e", mp.current_process())
    wget.download(lista[i+1])

    
def main_fn():

    proc = Process(target=process_fn, name="Donwload")
    proc.start()

    proc.join()
    print ("DOne")

if __name__ == "__main__":
    main_fn()



