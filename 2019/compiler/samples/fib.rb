def fib(n)
  if n < 1
    # fib(0) is 0
    return 0
  elsif n==1
    # fib(1) is 1
    return 1
  else
    return fib(n-1)+fib(n-2)
  end
end

print '0' + fib(3)
