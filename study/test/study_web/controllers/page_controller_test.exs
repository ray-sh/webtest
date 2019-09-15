defmodule StudyWeb.PageControllerTest do
  use StudyWeb.ConnCase

  test "GET /test", %{conn: conn} do
    conn = get(conn, "/test")
    # =~强大的运算符 Returns true if left matches right (if it's a regular expression) 
    #or contains right (if it's a string).
    result = html_response(conn, 200)
    IO.puts result
    assert result =~ "pp"
  end
end
