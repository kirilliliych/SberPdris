import socket

PORT = 5252
clients = {}

socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM, socket.IPPROTO_TCP)
socket.bind(('', PORT))
socket.listen(5)

try:
    while True:
        client_socket, client_addr = socket.accept()
        clients[client_addr] = client_socket

        while True:
            buf = client_socket.recv(1024)
            if (len(buf) == 0):
                break

        reply = 'Lorem ipsum dolor sit amet'
        client_socket.sendall(bytes(reply.encode('utf-8')))
        client_socket.shutdown(socket.SHUT_RDWR)
        client_socket.close()
except KeyboardInterrupt:
    socket.close()