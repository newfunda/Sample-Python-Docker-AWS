# data types
x = 5
y = 5.5
name = 'Manish Kumar'.split()
college = "ITM"
address = '''
ITM Gwalior
M.P
'''.upper()
isManager = True

print(x)
print(y)
print(name)
print(college)
print(address)
print(isManager)

# for loop
for data in name:
    print(data)

# Slicing from start index 0 till end or next index
print(address[12:])
print(address[0:5])
sequence = '123456789'
print(sequence[::2]) # two steps at a time
print(sequence[::-2]) # reverse
print('End of program')
