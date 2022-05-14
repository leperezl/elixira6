defmodule Prime do

    @number 7777731073919171
    @number2  7355573

    #pc specs: 2 cores 4 threads i5 6200U, 12 Gb ram 1366 mhz

    @matrix4x4 2785634827935482 # 0.52 seconds
    @matrix5x5 2785634827935482546294839 #
    @matrix6x6 278563482793548254629483985142459062 #
    @matrix7x7 2785634827935482546294839851424590627421590453194 #

    def time(num) do
        {algo, val} = :timer.tc(fn -> tod(num) end)
        algo = algo/1000000
        IO.inspect {"Time in seconds: ",algo,val}
    end

    def tod(num) do
        cond do
            rem(num,2) == 0 -> cond do
                                   String.ends_with?(Integer.to_string(num+1),"5") -> principal(num+3)
                                   true -> principal(num+1)
                                end
            String.ends_with?(Integer.to_string(num),"5") -> principal(num+2)
            true -> principal(num)
        end
    end
    
    def principal(num) do
        sqrt = :math.sqrt(num)
        root = ceil(sqrt)
        r= r_calculator(root)
        #IO.puts("low is: #{1}")
        #IO.puts("up is: #{r}")
        #IO.puts("n is: #{num}")
        #IO.puts("x is: #{r+1}")
        IO.puts num
        Process.flag(:trap_exit, true)
        pid = spawn_link(fn -> task = Task.async(fn -> prime_chunk(1, r ,root, num, 2, (r+1));:timer.sleep(400) end); Task.await(task);Process.exit(self(), :custom) end)
        receive do
            {:EXIT, ref, :custom} -> IO.inspect {:prime,num}
            {:EXIT, ref, _algo} -> cond do
                                String.ends_with?(Integer.to_string(num+2),"5") -> principal(num+4);
                                true -> principal(num+2);
                        end
        end
    end
    
    def prime_check(low, up, n, x) do
        cond do
            x> low and x< up and rem(n,x) == 0 -> Process.exit(self(), :kill)
            x> low and x<up -> prime_check(low, up, n, (x+1))
            true -> #IO.puts("finished prime")
        end
    end

    def prime_chunk(low, up, sqrt, n, x, r) do
        #IO.puts("went up to: #{up}")
        cond do
            up<= sqrt -> pid = spawn_link(fn -> prime_chunk(up,(up+r), sqrt, n, (up+1),r) end);
                        prime_check(low,up, n, x)
            true -> #IO.puts("All processes started")
        end
    end

    def r_calculator(n) do
        div(n,100)
    end

    def call_prime() do
        sqrt = :math.sqrt(@number2)
        root = ceil(sqrt)
        r= r_calculator(root)
        IO.puts("low is: #{1}")
        IO.puts("up is: #{r}")
        IO.puts("n is: #{@number2}")
        IO.puts("x is: #{r+1}")
        prime_chunk(1, r ,root, @number2, 2, (r+1))
    end

    def call_prime2() do
        up = div(@number2,2) +1
        IO.puts("up is: #{up}")
        prime_check(1, @number2 ,@number2, 2)
    end
end