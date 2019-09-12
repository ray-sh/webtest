defmodule StudyWeb.PageView do
  #It will call StudyWeb.view, 该函数会导入一些view/contorler/Router/template一些相关的函数
  use StudyWeb, :view


'''
  #1.PageView如何找到相对应的template,路径是root + (path<>View = PageView)
  /lib/study_web/templates/page
  use Phoenix.View,
        root: "lib/study_web/templates",
        namespace: StudyWeb
  #namespace的作用，
'''
end
