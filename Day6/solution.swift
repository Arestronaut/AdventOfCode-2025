import Foundation

func task1(_ data: [String]) -> Int {
  let data = data.map {
    $0.split(separator: " ").map { String($0).trimmingCharacters(in: .whitespaces) }
  }

  var rotate = [[String]](repeating: [String](repeating: "", count: data.count), count: data[0].count)

  for i in 0..<data.count {
    for j in 0..<data[i].count {
      rotate[j][i] = data[i][j]
    }
  }

  var result = 0
  for row in rotate {
    let values = row.dropLast(1).compactMap { Int($0) }
    let rowResult = switch row.last! {
      case "*": values.reduce(1, *)
      default: values.reduce(0, +)
    }

    result += rowResult
  }

  return result
}

func task2(_ data: [String]) -> Int {
  // Prepare data
  let data = data.map { Array($0).map{ String($0) } }

  var rotate = [[String]](repeating: [String](repeating: "", count: data.count), count: data[0].count)

  for i in 0..<data.count {
    for j in 0..<data[i].count {
      rotate[j][i] = data[i][j]
    }
  }

  var result = 0

  var nums = [Int]()
  var op = ""
  for numArray in rotate {
    var filtered = numArray.filter { $0 != " " }

    if filtered.isEmpty {
      let rowResult = switch op {
        case "*": nums.reduce(1, *)
        default: nums.reduce(0, +)
      }

      result += rowResult

      nums = []
      op = ""
    } else {
      if filtered.last! == "+" {
        filtered = filtered.dropLast()
        op = "+"
      } else if filtered.last! == "*" {
        filtered = filtered.dropLast()
        op = "*"
      }

      nums.append(Int(filtered.joined())!)

    }
  }

  let rowResult = switch op {
    case "*": nums.reduce(1, *)
    default: nums.reduce(0, +)
  }

  result += rowResult

  return result
}

let data = try! String(contentsOfFile: "input", encoding: .utf8)
  .split(separator: "\n")
  .map { String($0) }

print("Task1: \(task1(data))")
print("Task2: \(task2(data))")