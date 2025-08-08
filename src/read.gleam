import gleam/io
import gleam/string
import gleam/yielder
import stdin

pub fn prompt_char(message: String) -> String {
  io.println(message)
  case read_line() |> string.to_graphemes {
    [c] -> c
    _ -> prompt_char(message)
  }
}

pub fn read_line() -> String {
  case yielder.first(stdin.read_lines()) {
    Ok(line) -> line |> string.trim()
    Error(_) -> ""
  }
}
