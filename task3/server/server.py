import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM, socket.IPPROTO_TCP)
sock.bind(('', 5252))
sock.listen(1)
conn, addr = sock.accept()

print('connected client:', addr)

while True:
    client_data = conn.recv(1024)
    if not client_data:
        break
    conn.sendall(bytes(str(client_data) + "consectetuer adipiscing elit.", 'utf-8'))
conn.close()
