// TODO: Too stupid for modular arithmetic

import Foundation

let input = try! String(contentsOfFile: "input", encoding: .utf8)
  .split(separator: "\n")
  .map { Int($0.dropFirst())! * (($0.first! == "L") ? -1 : 1) }

var dial = 50
var passwordTask1 = 0
var passwordTask2 = 0
let upper = 100

for instruction in input {
  var position = dial

  if instruction < 0 {
    for _ in 1 ... abs(instruction) {
      position -= 1
      if position == -1 {
        position = 99
      } else if position == 0 {
        passwordTask2 += 1
      }
    }
  } else {
    for _ in 1 ... instruction {
      position += 1
      if position == 100 {
        position = 0
        passwordTask2 += 1
      }
    }
  }

  if position == 0 {
    passwordTask1 += 1
  }

  dial = position
}

print("The password for Task 1 is", passwordTask1)
print("The password for Task 2 is", passwordTask2)
