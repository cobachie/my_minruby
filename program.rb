# p 1 + 2
# p 6 * 7
# p 40 + 2
# x = 1
# y = x + 2
# p y

# if 0 == 0
#   p(42)
# else
#   p(43)
# end

# i = 0
# while i < 10
#   p(i)
#   i = i + 1
# end

# i = 10
# begin
#   p(i)
#   i = i - 1
# end while i > 0

# case 42
# when 0
#   p(0)
# when 1
#   p(1)
# else
#   p(2)
# end

# FizzBuz
i = 1
while i <= 100
  if i % 15 == 0
    p 'FizzBuzz'
  elsif i % 3 == 0
    p 'Fizz'
  elsif i % 5 == 0
    p 'Buzz'
  else
    p i
  end
  i = i + 1
end

# 組み込み関数
# p(1)
# p(2, 3)

# ユーザー定義関数
# def add(x, y)
#   x + y
# end
#
# p(add(1, 2))
#
# def foo()
#   x = 0
#   p(x)
# end
#
# x = 1
# foo()
# p(x)

# 8.6.1 フィボナッチ数列
# def fib(x)
#   if x <= 1
#     x
#   else
#     fib(x - 1) + fib(x - 2)
#   end
# end
#
# i = 1
# while i <= 10
#   pp fib(i)
#   i = i + 1
# end

# 8.6.2 相互再起
# def even?(n)
#   if n == 0
#     true
#   else
#     odd?(n - 1)
#   end
# end
#
# def odd?(n)
#   if n == 0
#     false
#   else
#     even?(n - 1)
#   end
# end
#
# pp even?(2)
# pp even?(3)

# 配列
# ary = [1, 2, 3, 6 * 7]
# p ary[0]
# ary[0] = 42
# p ary

# Hash
# h = { 1 => 10, 2 => 20, 3 => 30 }
# p(h[1])

