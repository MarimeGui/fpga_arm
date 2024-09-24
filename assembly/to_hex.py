import sys

binary_file = open(sys.argv[1], 'rb')
textual_file = open(sys.argv[2], 'w')

while True:
    data = binary_file.read(1)
    if not data:
        break
    textual_file.write(f'{data[0]:02x}\n')

binary_file.close()
textual_file.close()
