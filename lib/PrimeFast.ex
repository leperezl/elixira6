defmodule Fast do
    use Application
    alias :rand, as: Rand
    @cores :erlang.system_info(:logical_processors_available)
    # acc es accuracy para rabin miller


    def main(num, acc, av) do
      #IO.inspect(@cores)
      cond do
        av > 0 -> spawn_link(fn -> Fast.main(num+@cores*25000, 10, av-1) end)
        true -> nil
      end
      submain(num, 10, @cores*10000)
    end

    def submain(num, acc, act) when act > 0 do
      miller_rabin?(num, acc)
      cond do
        String.ends_with?(Integer.to_string(num),"3") -> submain(num+4, acc, act-1);
        true -> submain(num+2, acc, act-1);
      end
      #IO.puts(num)
    end

    def submain(num, acc, _act) do
      #IO.puts(num)
      miller_rabin?(num, acc)
      submain(num+25000*@cores*@cores, acc, @cores*10000)
    end

    def test(num, acc) do
       res = miller_rabin?( num, acc)
       IO.inspect(res)
    end
   
    def modular_exp( x, y, mod ) do
       with [ _ | bits ] = Integer.digits( y, 2 ) do
            Enum.reduce bits, x, fn( bit, acc ) -> acc * acc |> ( &( if bit == 1, do: &1 * x, else: &1 ) ).() |> rem( mod ) end
       end
    end
   
    def miller_rabin( d, s ) when rem( d, 2 ) == 0, do: { s, d }
    def miller_rabin( d, s ), do: miller_rabin( div( d, 2 ), s + 1 )
   
    def miller_rabin?( n, g ) do
         { s, d } = miller_rabin( n - 1, 0 )
         miller_rabin( n, g, s, d )
    end
   
    def miller_rabin( n, 0, _, _ ), do: send(Process.whereis(:main), {:prime, n})
    def miller_rabin( n, g, s, d ) do
      a = 1 + Rand.uniform( n - 3 )
      x = modular_exp( a, d, n )
      if x == 1 or x == n - 1 do
        miller_rabin( n, g - 1, s, d )
      else
        if miller_rabin( n, x, s - 1) == True, do: miller_rabin( n, g - 1, s, d ), else: False
      end
    end
   
    def miller_rabin( _n, _x, r ) when r <= 0, do: False
    def miller_rabin( n, x, r ) do
      x = modular_exp( x, 2, n )
      unless x == 1 do
        unless x == n - 1, do: miller_rabin( n, x, r - 1 ), else: send(Process.whereis(:main), {:prime, n})
      else
        False
      end
    end
  end