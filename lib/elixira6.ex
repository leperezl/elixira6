defmodule Elixira6 do
  import Mogrify

  def resize(imagePath, width, height, opts \\ [path: "C:/Users/User/Desktop/Uniandes/Semestre 8/Concurrencia, paralelismo/elixira6/Fotos"]) do
  open(imagePath)
  |> resize_to_limit(~s(#{width}x#{height}))
  |> save(opts)
  end

  def test do
    System.cmd("cmd.exe", ["magick", "mogrify", "-resize", "20x20", "-write", "C:/Users/User/Desktop/Uniandes/Semestre 8/Concurrencia, paralelismo/elixira6/Fotos/example.jpg", "C:/Users/User/Desktop/Uniandes/Semestre 8/Concurrencia, paralelismo/elixira6/Fotos/image.jpeg"], [stderr_to_stdout: true])
  end
end
