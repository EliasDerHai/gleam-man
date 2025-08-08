import gleam/io
import gleam/string
import gleam/yielder
import stdin

pub type Guess {
  GuessLetter(letter: String)
  GuessWord(word: String)
}

pub fn prompt_guess(message: String, word_len: Int) -> Guess {
  io.println(message)
  case read_line() |> string.to_graphemes {
    [c] -> GuessLetter(c)
    word -> {
      let word = string.concat(word)
      case string.length(word) == word_len {
        False -> {
          io.println("bad input - try again!")
          prompt_guess(message, word_len)
        }
        True -> GuessWord(word)
      }
    }
  }
}

pub fn read_line() -> String {
  case yielder.first(stdin.read_lines()) {
    Ok(line) -> line |> string.trim()
    Error(_) -> ""
  }
}
