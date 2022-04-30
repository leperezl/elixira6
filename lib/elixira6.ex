defmodule Prime do
  import Mogrify

  def resize(imagePath, width, height, opts \\ [path: "./Fotos/processed.jpeg"]) do
  open(imagePath)
  |> resize_to_limit(~s(#{width}x#{height}))
  |> save(opts)
  end

  def test do
    System.cmd("cmd.exe", ["magick", "mogrify", "-resize", "20x20", "-write", "./Fotos/example.jpg", "C:/Users/User/Desktop/Uniandes/Semestre 8/Concurrencia, paralelismo/elixira6/Fotos/image.jpeg"], [stderr_to_stdout: true])
  end

  def linux_test do
    open("./Fotos/image.jpeg") |> resize_to_limit("20x20") |> save([path: "./Fotos/resized.jpeg"])
  end
end
