# ExCardDeck

Provides an easy way to get a single or multiple decks of cards pre-shuffled. When you need
a new deck just call the shuffle method for more cards.

Getting Started

## Adding ExCardDeck to your project:

```elixir
def deps do
  [
    {:ex_card_deck, "~> 0.1.0"}
  ]
end

defp application do
  [applications: [:ex_card_deck]]
end
```

Quick Introduction

```elixir
> use ExCardDeck
> ExCardDeck.start_link()
> ExCardDeck.get_card()
{:spades, "A"}
... 51 other cards later
> ExCardDeck.get_card()
nil
> ExCardDeck.shuffle()
> ExCardDeck.get_card()
{:hearts, "5"}
```