defmodule TaskApp.TaskFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TaskApp.Task` context.
  """

  @doc """
  Generate a tasks.
  """
  def tasks_fixture(attrs \\ %{}) do
    {:ok, tasks} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> TaskApp.Task.create_tasks()

    tasks
  end
end
