import game_state.{type GameState}
import gleam/io
import gleam/string
import read

pub fn main() {
  let game = game_state.game_state()
  loop(game)
  Nil
}

fn loop(game: GameState) -> GameState {
  game |> read() |> eval() |> print() |> loop()
}

type Command {
  Guess(letter: String)
}

fn read(game: GameState) -> #(GameState, Command) {
  let c = read.prompt_char("Enter guess")
  #(game, Guess(c))
}

fn eval(tuple: #(GameState, Command)) -> GameState {
  let #(game, cmd) = tuple

  case cmd {
    Guess(letter:) ->
      case string.contains(game.hidden_word, letter) {
        False ->
          game_state.GameState(
            game.hidden_word,
            game.displayed_word,
            game.lifes - 1,
          )
        True ->
          game_state.GameState(
            game.hidden_word,
            // TODO: show letters
            game.displayed_word,
            game.lifes,
          )
      }
  }
}

fn print(game: GameState) -> GameState {
  io.println(game.displayed_word)
  game
}
