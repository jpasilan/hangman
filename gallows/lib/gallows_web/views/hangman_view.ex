defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import GallowsWeb.Views.Helpers.GameStateHelper

  def show_as_word(letters),  do: letters |> Enum.join(" ")
  def new_game_button(conn), do: button("New Game", to: Routes.hangman_path(conn, :create_game))

  def generate_new_game_button_or_form(conn, %{game_state: state}) when state in [:won, :lost] do
    new_game_button(conn)
  end

  def generate_new_game_button_or_form(conn, _tally) do
    form_for(conn, Routes.hangman_path(conn, :make_move), [as: :make_move, method: :put], fn f ->
      [
        text_input(f, :guess),
        submit("Make next move")
      ]
    end)
  end

  def turn(left, target) when target >= left, do: "faint"
  def turn(_left, _target),                   do: "dim"

end
