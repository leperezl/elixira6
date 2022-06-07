defmodule Main do
    
    def convert_image(path, size) do
        Image.image_file(path, size)
        num = Image.process_file
        res = Prime.time(num)
        printer(res,size)

        IO.inspect("The resulting prime image is in result.txt")
    end

    def printer(num, size) do
        val = Integer.to_string(num)
        list = String.graphemes(val)
        list = Enum.map(list, fn(chunk) -> "#{chunk} "end )
        chunks = Enum.chunk_every(list, size)
        res = Enum.map(chunks, fn(chunk) -> joiner(chunk) end )
        {:ok, file} = File.open("./Fotos/result.txt", [:write])
        Enum.map(res, fn(num) -> writer(num,file) end)
    end

    def joiner(list) do
        Enum.join(list,"")
    end

    def writer(chain, file) do
        line = "#{chain}\n"
        IO.write(file, line)

    end
end