defmodule StudyWeb.PageController do
  use StudyWeb, :controller
  # 整个render的过程 controller.render -> view.render -> layoutTemplate -> template
  # 在这个流程中，view可以指定，如果不指定就用默认的，layout也可以指定，template也可以指定
  # TODO: 1>查看render的源码 2>Go through render的变化 3>定制render，使用不同的view，layout，template
  # TODO: render 过程中plug的使用
  def index(conn, _params) do
    render(conn, "index.html")
  end

  def test(conn, _params) do
    # IO.inspect(layout(conn)) 的值 {StudyWeb.LayoutView, :app}
    # IO.inspect(put_format(conn,:json))

    # IO.inspect(get_format(conn)) #的值时“html”
    conn
    # |>put_format(:json)
    |> put_layout(false)
    # 如果不指定，就用系统默认的layoutView module
    # |>put_layout("admin.html")
    # 因为当前默认的view是StudyWeb.PageView,所以put_new_view不生效，只有当前Controller没有view时，才生效
    # |>put_new_view(StudyWeb.TestView)
    |> put_view(StudyWeb.TestView)
    |> render("sui.html", heart: 11, huxi: 4)
  end
end
