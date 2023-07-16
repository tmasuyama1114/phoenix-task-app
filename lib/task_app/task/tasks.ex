defmodule TaskApp.Task.Tasks do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(tasks, attrs) do
    tasks
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
