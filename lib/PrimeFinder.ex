defmodule Prime do

    @number 7777731073919179
    @number2  7355573
    
    def prime_check(low, up, n, x) do
        cond do
            x> low and x< up and rem(n,x) == 0 -> IO.puts("NOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO #{x}")
            x> low and x<up -> prime_check(low, up, n, (x+1))
            true -> IO.puts("finished prime")
        end
    end

    def prime_chunk(low, up, sqrt, n, x, r) do
        IO.puts("went up to: #{up}")
        cond do
            up<= sqrt -> { spawn_link(fn -> prime_chunk(up,(up+r), sqrt, n, (up+1),r) end),
                        prime_check(low,up, n, x)
                    }
            true -> IO.puts("All processes started")
        end
    end

    def r_calculator(n) do
        div(n,100)
    end

    def call_prime() do
        sqrt = :math.sqrt(@number)
        root = ceil(sqrt)
        r= r_calculator(root)
        IO.puts("low is: #{1}")
        IO.puts("up is: #{r}")
        IO.puts("n is: #{@number}")
        IO.puts("x is: #{r+1}")
        prime_chunk(1, r ,root, @number, 2, (r+1))
    end

    def call_prime2() do
        up = div(@number2,2) +1
        IO.puts("up is: #{up}")
        prime_check(1, @number2 ,@number2, 2)
    end


end