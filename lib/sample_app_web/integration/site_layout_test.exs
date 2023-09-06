defmodule SampleAppWeb.SiteLayoutTest do
  use SampleAppWeb.ConnCase, async: true
  alias SampleAppWeb.DynamicTextHelpers
  alias SampleAppWeb.StaticPageView

  test "layout links", %{conn: conn} do
    conn = get(conn, Routes.root_path(conn, :home))
    contact_page_title = to_string(
      DynamicTextHelpers.page_title(
      Enum.into(assigns, %{view_module: SampleAppWeb.StaticPageView,
      action: :contact})))

    html_response(conn, 200)
    |> assert_select("a[href='#{Routes.root_path(conn, :home)}']", count: 2)
    |> assert_select("a[href='#{Routes.help_path(conn, :help)}']")
    |> assert_select("a[href='#{Routes.about_path(conn, :about)}']")
    |> assert_select("a[href='#{Routes.contact_path(conn, :contact)}']")

    conn = get(conn, Routes.contact_path(conn, :contact))
    html_response(conn, 200)
    |> assert_select("title", contact_page_title)
  end
end
