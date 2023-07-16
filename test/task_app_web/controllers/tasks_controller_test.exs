defmodule TaskAppWeb.TasksControllerTest do
  use TaskAppWeb.ConnCase

  import TaskApp.TaskFixtures

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get(conn, ~p"/tasks")
      assert html_response(conn, 200) =~ "Listing Tasks"
    end
  end

  describe "new tasks" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/tasks/new")
      assert html_response(conn, 200) =~ "New Tasks"
    end
  end

  describe "create tasks" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/tasks", tasks: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/tasks/#{id}"

      conn = get(conn, ~p"/tasks/#{id}")
      assert html_response(conn, 200) =~ "Tasks #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/tasks", tasks: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tasks"
    end
  end

  describe "edit tasks" do
    setup [:create_tasks]

    test "renders form for editing chosen tasks", %{conn: conn, tasks: tasks} do
      conn = get(conn, ~p"/tasks/#{tasks}/edit")
      assert html_response(conn, 200) =~ "Edit Tasks"
    end
  end

  describe "update tasks" do
    setup [:create_tasks]

    test "redirects when data is valid", %{conn: conn, tasks: tasks} do
      conn = put(conn, ~p"/tasks/#{tasks}", tasks: @update_attrs)
      assert redirected_to(conn) == ~p"/tasks/#{tasks}"

      conn = get(conn, ~p"/tasks/#{tasks}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, tasks: tasks} do
      conn = put(conn, ~p"/tasks/#{tasks}", tasks: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tasks"
    end
  end

  describe "delete tasks" do
    setup [:create_tasks]

    test "deletes chosen tasks", %{conn: conn, tasks: tasks} do
      conn = delete(conn, ~p"/tasks/#{tasks}")
      assert redirected_to(conn) == ~p"/tasks"

      assert_error_sent 404, fn ->
        get(conn, ~p"/tasks/#{tasks}")
      end
    end
  end

  defp create_tasks(_) do
    tasks = tasks_fixture()
    %{tasks: tasks}
  end
end
