import game_state.{type Game, Game}
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import read.{type Guess}

pub fn main() -> Nil {
  let game = game_state.game(0, 0)
  // solely for having iconic - r e p l
  print(game)
  loop(game)
  Nil
}

fn loop(game: Game) -> Game {
  game |> read() |> eval() |> print() |> loop()
}

fn read(game: Game) -> #(Game, Guess) {
  let guess =
    read.prompt_guess(
      "Guess (lives: "
        <> int.to_string(game.lives)
        <> " - won: "
        <> int.to_string(game.won)
        <> " - lost: "
        <> int.to_string(game.lost)
        <> ")",
      string.length(game.hidden_word),
    )
  #(game, guess)
}

fn eval(tuple: #(Game, Guess)) -> Game {
  let #(game, cmd) = tuple

  let game = case cmd {
    read.GuessLetter(letter:) ->
      case string.contains(game.hidden_word, letter) {
        False -> Game(..game, lives: game.lives - 1)
        True -> {
          let displayed_word =
            list.zip(
              game.hidden_word |> string.to_graphemes(),
              game.displayed_word |> string.to_graphemes(),
            )
            |> list.map(fn(tuple) {
              case tuple {
                #(hidden_c, _) if hidden_c == letter -> letter
                #(_, displayed_c) -> displayed_c
              }
            })
            |> string.concat()

          Game(..game, displayed_word: displayed_word)
        }
      }
    read.GuessWord(word:) -> {
      case word == game.hidden_word {
        False -> Game(..game, lives: game.lives - 1)
        True -> Game(..game, displayed_word: game.hidden_word)
      }
    }
  }

  let game = case game.displayed_word == game.hidden_word {
    False -> game
    True -> {
      io.println("You won! Next round comming right at you...")
      game_state.game(game.won + 1, game.lost)
    }
  }

  let game = case game.lives <= 0 {
    False -> game
    True -> {
      io.println(
        "You lost - word was "
        <> game.hidden_word
        <> "! Next round comming right at you...",
      )
      game_state.game(game.won, game.lost + 1)
    }
  }
  game
}

fn print(game: Game) -> Game {
  io.println(
    game.displayed_word
    |> string.to_graphemes()
    |> list.map(fn(c) { string.concat([" ", c, " "]) })
    |> string.concat(),
  )
  game
}
