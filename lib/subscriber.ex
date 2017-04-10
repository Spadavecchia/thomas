defmodule Subscriber do
  @moduledoc """
  Subscriber
  """
  defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(subscriber = %Subscriber{}) do
    subscriber.paid && subscriber.over_18
  end
end
