defmodule Prime do

    @number 7777731079103
    
    def prime_check(low, up, n, x) do
        cond do
            x> low and x< up and rem(n,x) == 0 -> IO.puts("not prime #{x}")
            x> low and x<up -> prime_check(low, up, n, (x+1))
            true -> IO.puts("finished prime")
        end
    end

    def prime_chunk(low, up, n, x, r) do
        prime_check(low,up, n, x)
    end

    def r_calculator(n) do
        div(n,100000)
    end

    def call_prime() do
        r= r_calculator(@number)
        IO.puts("low is: #{r}")
        IO.puts("up is: #{r*2}")
        IO.puts("n is: #{@number}")
        IO.puts("x is: #{r+1}")
        prime_check(r, (r*2) ,@number, (r+1))
    end
end