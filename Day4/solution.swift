import Foundation

func removableRolls(_ data: [[Int]]) -> [(Int, Int)] {
  var result: [(Int, Int)] = []
  for row in data.indices {
    for column in data[row].indices where data[row][column] == 1 {
      let consideredIndices = [
        [row - 1, column - 1], [row - 1, column], [row - 1, column + 1],
        [row, column - 1], [row, column + 1],
        [row + 1, column - 1], [row + 1, column], [row + 1, column + 1]
      ]

      let numberOfAdjacentRolls: Int = consideredIndices.reduce(0) { previous, current in
        let next = if (0 ..< data.count).contains(current[0]), (0 ..< data[row].count).contains(current[1]) {
          data[current[0]][current[1]]
        } else {
          0
        }

        return previous + next
      }

      if numberOfAdjacentRolls < 4 {
        result.append((row, column))
      }
    }
  }

  return result
}

func task1(_ data: [[Int]]) -> Int {
  removableRolls(data).count
}

func task2(_ data: [[Int]]) -> Int {
  var result = 0

  var data = data
  while true {
    let removableIndices = removableRolls(data)

    if removableIndices.count > 0 {
      result += removableIndices.count
      removableIndices.forEach { data[$0.0][$0.1] = 0 }
    } else {
      break
    }
  }

  return result
}

let data = try! String(contentsOfFile: "input", encoding: .utf8)
  .split(separator: "\n")
  .map { String($0)
  .map { $0 == "@" ? 1 : 0 } }

print("(1) \(task1(data)) rolls can be removed")
print("(1) \(task2(data)) rolls can be removed")