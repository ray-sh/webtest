defmodule StudyWeb.PageController do
  use StudyWeb, :controller
  #整个render的过程 controller.render -> view.render -> layoutTemplate -> template
  #在这个流程中，view可以指定，如果不指定就用默认的，layout也可以指定，template也可以指定
  #TODO: 1>查看render的源码 2>Go through render的变化 3>定制render，使用不同的view，layout，template
  #TODO: render 过程中plug的使用
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
