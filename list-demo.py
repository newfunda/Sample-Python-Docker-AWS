list = ['Manish', 39, '''
ITM Gwalior
MP
''']
list.append(5.5)
#list.remove('Manish')
del list[0]
list.insert(0, 'Manish')
list.insert(1, 'Kumar')

for data in list:
    print(data)