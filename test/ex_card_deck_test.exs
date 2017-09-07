defmodule ExCardDeckTest do
  use ExUnit.Case

  test "get_card" do
    state = %{decks: [{:hearts, "A", 1, [1,11]}, {:spades, "2", 2, [2]}]}
    {:reply, card, new_state} = ExCardDeck.handle_call(:get_card, :from, state)
    assert card == {:hearts, "A", 1, [1,11]}

    {:reply, card, new_state} = ExCardDeck.handle_call(:get_card, :from, new_state)
    assert card == {:spades, "2", 2, [2]}

    {:reply, card, _new_state} = ExCardDeck.handle_call(:get_card, :from, new_state)
    assert is_nil(card) === true
  end

  test "discard" do
    state = %{decks: [{:hearts, "A", 1, [1,11]}, {:spades, "2", 2, [2]}]}
    {:noreply, new_state} = ExCardDeck.handle_cast(:discard, state)
    assert new_state[:decks] == [{:spades, "2", 2, [2]}]

    {:noreply, new_state} = ExCardDeck.handle_cast(:discard, new_state)
    assert new_state[:decks] == []

    {:noreply, _new_state} = ExCardDeck.handle_cast(:discard, new_state)
    assert new_state[:decks] == []
  end
end
