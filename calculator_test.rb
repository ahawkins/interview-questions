# Source: Karat.io
# Date: 2018-04-04
#
# Implement a simple calculator given a string like:
#
# "6+9-12" => 3
# "1+2-3+4-5+6-7" => -2
#
# There are multiple solutions to this problem. They all involve
# parsing the string in some way or another. My simple solution,
# which I embarrasingly didn't get working, involves parsing the
# string piece by piece. It looks something like:
#
# initialize counter
# initialize operation
#
# while something to evaluate
#   if counter unset
#     set counter to first digits in expression
#     remove first digits from expression
#   else if the expressions starts with '+'
#     set operation to addition
#     remove the first character from expression
#   else if the expression starts with -
#     set operation to subtraction
#     remove the first character from expression
#   else if operation is set
#     set number to the first digits in expression
#     remove the first digits from expression
#     if operation is addition
#       set counter to counter plus number
#     else if operation is subtraction
#       set counter to counter minus number
#     unset operation
#
# return counter
#
# This solution only fits the following contraints:
#
# - operations are addition and subtraction
# - no nested operations; e.g. (foo + bar)
#
# This is an ideal solution by no means. An abstract syntax (AST) is a better
# solution to this problem. AST's are how programming languages are implemented
# or anything with a proper grammer. Mathematical expressions are no different.
# AST also supports nested operations and operator ordering.

require 'minitest/autorun'

class CalculatorTest < MiniTest::Test
  def evaluate(string)
    counter = nil
    operation = nil

    expression = string.dup

    while expression.length > 0
      if counter.nil?
        counter = expression.slice!(/^\d+/).to_i
      elsif expression[0] == '+'
        operation = :add
        expression.slice!(0)
      elsif expression[0] == '-'
        operation = :subtract
        expression.slice!(0)
      elsif operation
        number = expression.slice!(/^\d+/).to_i

        if operation == :add
          counter = counter + number
        elsif operation == :subtract
          counter = counter - number
        end

        operation = nil
      end
    end

    counter
  end

  def test_examples
    assert_equal 4, evaluate('2+2')
    assert_equal 3, evaluate('6+9-12')
    assert_equal -2, evaluate('1+2-3+4-5+6-7')
  end
end
