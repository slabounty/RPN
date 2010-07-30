# Implement an RPN calculator that takes an expression like 19 2.14 + 4.5 2 4.3
# / - * which is usually expressed as (19 + 2.14) * (4.5 - 2 / 4.3) and responds
# with 85.2974. The program should read expressions from standard input and
# print the top of the stack to standard output when a newline is encountered.
# The program should retain the state of the operand stack between expressions.


# Open up the Array class so we can add a 
# method to look at the "top of the stack".
class Array
    alias :peek :last
end

# Create the stack we'll use for processing.
stack = Array.new
while true

    # Print the prompt.
    print ">> "

    # Get the line to process and remove the trailing \n.
    line = gets.chomp

    while line.size > 0

        # Check for a number first so that we don't grab a +/- 
        # and use it for an operator.
        if line =~ /^\s*([-+]?[0-9]*\.?[0-9]+)\s*/
            # Found an operand so we'll just push it 
            # on the stack after changing it to a float.
            stack.push $1.to_f
        elsif line =~ /^\s*([\+\-\*\/])\s*/ then
            # The line has an operator (+/-*).
            operator = $1

            # Get the operands off the stack.
            operand_2 = stack.pop
            operand_1 = stack.pop

            # Evaluate the expression and push it on to the stack.
            stack.push  case operator 
                when '+'
                    operand_1 + operand_2
                when '-'
                    operand_1 - operand_2
                when '*'
                    operand_1 * operand_2
                when '/'
                    operand_1 / operand_2
                end
        end

        # Replace whatever we just found with the empty string.
        line.sub!($&, "")
    end

    # We've finished processing the line, so print out the
    # top of the stack.
    puts "Top of stack = #{stack.peek}"
end
