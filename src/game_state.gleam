import gleam/list
import gleam/string

pub type Game {
  Game(
    hidden_word: String,
    displayed_word: String,
    lives: Int,
    won: Int,
    lost: Int,
  )
}

pub fn game(won: Int, lost: Int) -> Game {
  let hidden_word = random_word()
  let displayed_word: String =
    hidden_word
    |> string.to_graphemes()
    |> list.map(fn(_) { "_" })
    |> string.concat()

  Game(hidden_word, displayed_word, 5, won, lost)
}

fn random_word() -> String {
  let w = case random_words() |> list.first() {
    Error(_) -> random_word()
    Ok(w) -> w
  }
  w
}

fn random_words() -> List(String) {
  [
    "water",
    "hot air baloon",
    "bubble",
    "blueberry",
    "strawberry",
    "cheesecake",
    "tomatoes",
    "potatoes",
    "philosophy",
    "anger",
    "mountainbike",
    "tzatziki",
    "honey",
    "ice cream",
  ]
  |> list.shuffle()
}
