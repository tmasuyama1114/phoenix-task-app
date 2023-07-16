defmodule TaskAppWeb.TasksHTML do
  use TaskAppWeb, :html

  embed_templates "tasks_html/*"

  @doc """
  Renders a tasks form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def tasks_form(assigns)
end
