defmodule TaskAppWeb.TasksController do
  use TaskAppWeb, :controller

  alias TaskApp.Task
  alias TaskApp.Task.Tasks

  def index(conn, _params) do
    tasks = Task.list_tasks()
    render(conn, :index, tasks_collection: tasks)
  end

  def new(conn, _params) do
    changeset = Task.change_tasks(%Tasks{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"tasks" => tasks_params}) do
    case Task.create_tasks(tasks_params) do
      {:ok, tasks} ->
        conn
        |> put_flash(:info, "Tasks created successfully.")
        |> redirect(to: ~p"/tasks/#{tasks}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tasks = Task.get_tasks!(id)
    render(conn, :show, tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    tasks = Task.get_tasks!(id)
    changeset = Task.change_tasks(tasks)
    render(conn, :edit, tasks: tasks, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tasks" => tasks_params}) do
    tasks = Task.get_tasks!(id)

    case Task.update_tasks(tasks, tasks_params) do
      {:ok, tasks} ->
        conn
        |> put_flash(:info, "Tasks updated successfully.")
        |> redirect(to: ~p"/tasks/#{tasks}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, tasks: tasks, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tasks = Task.get_tasks!(id)
    {:ok, _tasks} = Task.delete_tasks(tasks)

    conn
    |> put_flash(:info, "Tasks deleted successfully.")
    |> redirect(to: ~p"/tasks")
  end
end
