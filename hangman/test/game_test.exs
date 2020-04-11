defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters |> length > 0
      && game.letters |> Enum.all?(fn l -> l =~ ~r/[a-z]/ end)
  end

  test "state is not changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert { ^game, _tally } = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter marked as not already used" do
    { game, _tally } = Game.new_game() |> Game.make_move("x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter marked as already used" do
    { game, _tally } = Game.new_game() |> Game.make_move("x")
    assert game.game_state != :already_used
    { game, _tally } = game |> Game.make_move("x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    { game, _tally } = Game.new_game("wibble") |> Game.make_move("e")
    assert game.game_state == :good_guess
  end

  test "a guessed word is a won game" do
    game  = Game.new_game("wibble")
    moves = [
      { "w", :good_guess },
      { "i", :good_guess },
      { "b", :good_guess },
      { "l", :good_guess },
      { "e", :won },
    ]

    moves
    |> Enum.reduce(game, fn ({guess, state}, game) ->
      { game, _tally } = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end)

    assert game.turns_left == 7
  end

  test "a bad guess is recognized" do
    { game, _tally } = Game.new_game("wibble") |> Game.make_move("x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "a lost game is recognized" do
    game  = Game.new_game("w")
    moves = [
      { "a", :bad_guess },
      { "b", :bad_guess },
      { "c", :bad_guess },
      { "d", :bad_guess },
      { "e", :bad_guess },
      { "f", :bad_guess },
      { "g", :lost },
    ] 

    moves
    |> Enum.with_index()
    |> Enum.reduce(game, fn ({{ guess, state }, index}, game) ->
      { game, _tally } = Game.make_move(game, guess)
      assert game.game_state == state
      assert game.turns_left == 7 - (index + 1)
      game
    end)
  end

end
