defmodule StudyWeb.PageView do
  # It will call StudyWeb.view, 该函数会导入一些view/contorler/Router/template一些相关的函数
  use StudyWeb, :view

  '''
    1.PageView如何找到相对应的template,路径是root + (path<>View = PageView)
    /lib/study_web/templates/page
    use Phoenix.View,
          root: "lib/study_web/templates",
          namespace: StudyWeb
    #namespace的作用，
    
    2.我们为什么需要不同的view？
    view的一个主要作用就是作为template function的Module

    3.web下面的folder的层次结构是有意义的，文件夹/name.format.eex （文件夹，文件名，foramt）都是render时
    要用的的参数

    4.学习API，了解一个系统一个关键的方法就是找到这个系统模型核心的数据结构，以及围绕这个数据机构的方法级
    %Plug.Conn{
      adapter: {Plug.Adapters.Test.Conn, :...},
      assigns: %{},
      before_send: [#Function<0.70535915/1 in Plug.CSRFProtection.call/2>,
       #Function<2.95550828/1 in Phoenix.Controller.fetch_flash/2>,
       #Function<0.35161479/1 in Plug.Session.before_send/2>,
       #Function<1.16531471/1 in Plug.Logger.call/2>],
      body_params: %{},
      cookies: %{},
      halted: false,
      host: "www.example.com",
      method: "GET",
      owner: #PID<0.279.0>,
      params: %{},
      path_info: ["test"],
      path_params: %{},
      port: 80,
      private: %{
        StudyWeb.Router => {[], %{}},
        :phoenix_action => :test,
        :phoenix_controller => StudyWeb.PageController,
        :phoenix_endpoint => StudyWeb.Endpoint,
        :phoenix_flash => %{},
        :phoenix_format => :json,
        :phoenix_layout => {StudyWeb.LayoutView, :app},
        :phoenix_recycled => true,
        :phoenix_router => StudyWeb.Router,
        :phoenix_view => StudyWeb.PageView,
        :plug_session => %{},
        :plug_session_fetch => :done,
        :plug_skip_csrf_protection => true
      },
      query_params: %{},
      query_string: "",
      remote_ip: {127, 0, 0, 1},
      req_cookies: %{},
      req_headers: [],
      request_path: "/test",
      resp_body: nil,
      resp_cookies: %{},
      resp_headers: [
        {"cache-control", "max-age=0, private, must-revalidate"},
        {"x-request-id", "FcQAYJM-3DDpV3cAAABl"},
        {"x-frame-options", "SAMEORIGIN"},
        {"x-xss-protection", "1; mode=block"},
        {"x-content-type-options", "nosniff"},
        {"x-download-options", "noopen"},
        {"x-permitted-cross-domain-policies", "none"},
        {"cross-origin-window-policy", "deny"}
      ],
      scheme: :http,
      script_name: [],
      secret_key_base: :...,
      state: :unset,
      status: nil
    }
  '''
end
