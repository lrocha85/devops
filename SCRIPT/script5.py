import os
import wget
from multiprocessing import Process, Lock

lista = [
"http://ftp.de.debian.org/debian/pool/main/liba/libaacs/libaacs-dev_0.7.1-1+b1_amd64.deb",
"http://ftp.de.debian.org/debian/pool/main/liba/libaacs/libaacs-dev_0.7.1-1+b1_armel.deb",
"http://ftp.de.debian.org/debian/pool/main/liba/libaacs/libaacs-dev_0.7.1-1+b1_armhf.deb",
"http://ftp.de.debian.org/debian/pool/main/liba/libaacs/libaacs-dev_0.7.1-1+b1_i386.deb",
"http://ftp.de.debian.org/debian/pool/main/liba/libaacs/libaacs-dev_0.8.1-2_amd64.deb"
]

n = 0

def process_fn(label, lock):
    msg = "%s: nome:%s, pid:%s"
    with lock:
        print(msg % (label, __name__, os.getpid()))

if __name__ == "__main__":
    lock = Lock()
    process_fn("Chamada", lock)
    p = Process(target=process_fn, args=("Outro processo criado", lock))
    p.start()
    p.join
    for i in range(5):
        Process(target=process_fn, args=((("Processo rodando %s" %i, (lista[n]),)), lock)).start()
        wget.download(lista[n])
        n = n +1
        
    