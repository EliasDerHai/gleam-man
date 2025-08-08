import game_state.{type Game, Game}
import gleam/io
import gleam/list
import gleam/string
import read

pub fn main() -> Nil {
  let game = game_state.game()
  loop(game)
  Nil
}

fn loop(game: Game) -> Game {
  game |> read() |> eval() |> print() |> loop()
}

type Command {
  Guess(letter: String)
}

fn read(game: Game) -> #(Game, Command) {
  let c = read.prompt_char("Enter guess")
  #(game, Guess(c))
}

fn eval(tuple: #(Game, Command)) -> Game {
  let #(game, cmd) = tuple

  case cmd {
    Guess(letter:) ->
      case string.contains(game.hidden_word, letter) {
        False -> Game(..game, lives: game.lives - 1)
        True -> {
          let next_displayed_word =
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

          Game(..game, displayed_word: next_displayed_word)
        }
      }
  }
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
