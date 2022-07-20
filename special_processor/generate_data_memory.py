#!/usr/bin/env python3

# Initialize to 0's
data = [0 for x in range(256)]

# Set some specific values
data[0] = 16
data[4] = 24
data[16] = 254
data[244] = 5

with open('data_mem.hex', 'w') as ofile:
	for d in data:
		ofile.write('{:02X}\n'.format(d))
