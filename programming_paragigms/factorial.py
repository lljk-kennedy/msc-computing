def factorial(n):
	if n == 1 or n == 0:
		return 1

	return n * factorial(n-1)

def factorial2(n):
	total = 1

	for x in range(1, n+1):
		total = total * x

	return total


print factorial(4)
print factorial2(0)