defmodule ExCardDeckTest do
  use ExUnit.Case

  test "get_card" do
    deck = [{:hearts, "A"}, {:spades, "2"}]
    {:reply, card, new_state} = ExCardDeck.handle_call(:get_card, :from, %{decks: deck})
    assert card == {:hearts, "A"}

    {:reply, card, new_state} = ExCardDeck.handle_call(:get_card, :from, new_state)
    assert card == {:spades, "2"}

    {:reply, card, _new_state} = ExCardDeck.handle_call(:get_card, :from, new_state)
    assert is_nil(card) === true
  end

  test "discard" do
    state = %{decks: [{:hearts, "A"}, {:spades, "2"}]}
    {:noreply, new_state} = ExCardDeck.handle_cast(:discard, state)
    assert new_state[:decks] == [{:spades, "2"}]

    {:noreply, new_state} = ExCardDeck.handle_cast(:discard, new_state)
    assert new_state[:decks] == []

    {:noreply, _new_state} = ExCardDeck.handle_cast(:discard, new_state)
    assert new_state[:decks] == []
  end
end
