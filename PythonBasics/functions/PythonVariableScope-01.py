# variable scope
# outside the function
total = 10

def add_nums(arg1, arg2):
    # inside the function
    total = arg1 + arg2
    print(total)

add_nums(total, 2)
