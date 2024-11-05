import socket

socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM, socket.IPPROTO_TCP)
socket.connect(('192.168.0.3', 5252))

try:
    socket.sendall(b'GET / HTTP/1.1\nHost: ya.ru\nConnection: close\n')
    socket.shutdown(socket.SHUT_WR)
    reply = b''
    while True:
        buf = socket.recv(1024)
        if (len(buf) == 0):
            break
        reply += buf

    print(reply.decode('utf-8'))
except KeyboardInterrupt:
    socket.close()
