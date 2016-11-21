defmodule Rumbl.WatchView do
  use Rumbl.Web, :view

  def player_id(video) do
    ~r{(?<url>watch\?v=)(?<id>.*)} |> Regex.named_captures(video.url) |> get_in(["id"])
  end
end
