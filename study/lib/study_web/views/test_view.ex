defmodule StudyWeb.TestView do
  @doc """
  Phoenix.View.render (StudyWeb.TestView, "index.html", name: "lei")
  template会被编译成函数，这个函数能够通过template名字index.html 来调用
  {:safe, ["Hello ", "lei", "\n"]}
  """
  use StudyWeb, :view

  #    def render("test.html", assigns) do
  #       "#{IO.inspect(assigns)}"
  #    end
end
