defmodule StudyWeb.PageController do
  use StudyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
