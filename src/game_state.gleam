import gleam/list
import gleam/string

pub type GameState {
  GameState(hidden_word: String, displayed_word: String, lifes: Int)
}

pub fn game_state() -> GameState {
  let hidden_word = random_word()
  let displayed_word: String =
    hidden_word
    |> string.to_graphemes()
    |> list.map(fn(_) { " _ " })
    |> string.concat()

  GameState(hidden_word, displayed_word, 9)
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
  ]
  |> list.shuffle()
}
