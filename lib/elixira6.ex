defmodule Image do
  import Mogrify

  def resize(imagePath, width, height, opts \\ [path: "./Fotos/processed.jpeg"]) do
  open(imagePath)
  |> resize_to_limit(~s(#{width}x#{height}))
  |> save(opts)
  end

  def test do
    System.cmd("cmd.exe", ["magick", "mogrify", "-resize", "20x20", "-write", "./Fotos/example.jpg", "./Fotos/image.jpeg"], [stderr_to_stdout: true])
  end

  def linux_test do
    open("./Fotos/image.jpeg") |> resize("45x45") |> custom("colorspace", "Gray") |> save([path: "./Fotos/resized3.txt"])
  end

  def image_file(path, dim) do
    open("#{path}") |> resize("#{dim}x#{dim}") |> custom("colorspace", "Gray") |> save([path: "./Fotos/resized.txt"])
  end

  def process_file do
    {:ok, content} = File.read("./Fotos/resized.txt")
    val = String.split(content, "\n", trim: true)
    process(val, [])
  end

  def process([h | t], list) do
    cond do
      Enum.at(String.split(h, "gray", trim: true),1) != nil and Enum.at(String.split(h, "gray", trim: true),1) != [] and !String.starts_with?(h,"#")->
        val = 9-trunc(Float.floor(10*String.to_integer(Enum.at(String.split(Enum.at(String.split(Enum.at(String.split(h, "gray", trim: true),1), "("),1), ")"),0))/255))
        #val = 9-trunc(Float.floor(10*String.to_integer(Enum.at(String.split(Enum.at(String.split(h, "("),1), ")"),1))/255))
        cond do
          val < 0 ->
            list = Enum.concat(list, [0])
            process(t, list)
          true ->
            list = Enum.concat(list, [val])
            process(t, list)
        end
      true ->
        process(t, list)
    end
  end

  def process([], list) do
    list
    res = String.to_integer(Enum.join(list))
    #IO.inspect String.to_integer(Enum.join(list))
    {:ok, file} = File.open("./Fotos/numbers.txt", [:write])
    IO.write(file, inspect(res, limit: :infinity))
    IO.puts(res)
    res
  end
end
#Enum.at(String.split(Enum.at(String.split(Enum.at(String.split(h, "gray", trim: true),1), "("),1), ")"),0)