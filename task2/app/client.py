import socket
import time

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM, socket.IPPROTO_TCP)
sock.connect(('server', 5252))
try:
    while True:
        sock.sendall(b'Lorem ipsum dolor sit amet')
        server_data = sock.recv(1024)

        print(server_data)
        time.sleep(2)
except KeyboardInterrupt:
    sock.close()
