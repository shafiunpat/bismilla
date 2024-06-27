def is_prime(num):
    if num <= 1:
        return False
    for i in range(2, int(num**0.5) + 1):
        if num % i == 0:
            return False
    return True

def print_primes(start, end):
    print("Prime numbers between", _start, "and", end, "are:")
    for num in range(start, end + 1):
        if is_prime(num):
            print(num)

start_num = int(input("Enter the start of the range: "))
end_num = int(input("Enter the end of the range: "))
print_primes(start_num, endnum)
