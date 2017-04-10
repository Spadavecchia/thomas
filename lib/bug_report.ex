defmodule BugReport do
  @moduledoc """
  BugReport
  """
  defstruct owner: %Customer{}, details: "", severity: 1
end
