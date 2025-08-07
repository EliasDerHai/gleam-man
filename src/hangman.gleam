import gleam/io
import gleam/list
import gleam/string

pub fn main() -> Nil {
  let game = game()
  io.println(string.concat(["Hello from ", game.hidden_word, "!"]))
}

type Game {
  Game(hidden_word: String, displayed_word: String, lifes: Int)
}

fn game() -> Game {
  let hidden_word = random_word()
  let displayed_word: String =
    hidden_word
    |> string.to_graphemes()
    |> list.map(fn(_) { " _ " })
    |> string.concat()

  Game(hidden_word, displayed_word, 9)
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
