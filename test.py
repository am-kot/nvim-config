def printer(number_of_rows: int, array: list):
    string = ''
    for i in array:
        string += str(i) + ' '

    print(' '*int( (2*number_of_rows - len(string)) / 2 ) + string)


def array_creator(row_number: int, array: list) -> list:
    new_array = [ 1 for i in range(row_number) ]

    if row_number > 2:
        for index in range(1, row_number-1):
            new_array[index] = array[index-1] + array[index]

    return new_array


def main():
    number_of_rows = int(input(' -> '))

    array = []

    for row_number in range(1, number_of_rows):
        array = array_creator(row_number, array)
        printer(number_of_rows, array)



if __name__ ==  "__main__":
    try:
        main()
    except KeyboardInterrupt:
        exit()
