defmodule ExCardDeck do
  use GenServer

  @moduledoc """
  Provides a way to create and shuffle a deck of cards.
  """

  def start_link(number_of_decks \\ 1) do
    GenServer.start_link(__MODULE__, number_of_decks, [name: __MODULE__])
  end

  def init(number_of_decks) do
    decks = get_decks(number_of_decks)
    {:ok, %{number_of_decks: number_of_decks, decks: decks}}
  end

  def discard() do
    GenServer.cast(__MODULE__, :discard)
  end

  @doc """
  Get a card from the deck.

  ## Examples

      iex> ExCardDeck.get_card
      {:heart, "2"}

  """
  def get_card() do
    GenServer.call(__MODULE__, :get_card)
  end

  def shuffle() do
    GenServer.cast(__MODULE__, :shuffle)
  end

  def stop() do
    GenServer.stop(__MODULE__)
  end

  def handle_call(:get_card, _from, state) do
    decks = state[:decks]
    card = List.first(decks)
    new_state = List.delete_at(decks, 0)
    state = %{state | decks: new_state}

    {:reply, card, state}
  end

  def handle_cast(:discard, state) do
    decks = state[:decks]
    new_state = List.delete_at(decks, 0)
    state = %{state | decks: new_state}

    {:noreply, state}
  end

  def handle_cast(:shuffle, state) do
    decks = get_decks(state[:number_of_decks])
    state = %{state | decks: decks}

    {:noreply, state}
  end

  # Helper methods
  @spec get_decks(pos_integer()) :: [{atom(), binary()}]
  defp get_decks(number_of_decks) do
    decks = Enum.map(1..number_of_decks, fn(_) -> deck() end)
    List.flatten(decks) |> Enum.shuffle
  end

  def deck() do
    card_ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    card_suits = [:clubs, :diamonds, :hearts, :spades]
    Enum.map(card_ranks, fn(rank) ->
      Enum.map(card_suits, fn(suit) ->
        {suit, rank}
      end)
    end)
  end
end
