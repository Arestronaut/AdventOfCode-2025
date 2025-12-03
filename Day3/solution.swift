import Foundation

let data = try! String(contentsOfFile: "sample", encoding: .utf8).split(separator: "\n").map { $0.map { Int(String($0))! } }


func task(_ banks: [[Int]], numberOfBatteries: Int) -> Int {
  var result = 0

  for bank in banks {
    var idxs: [Int] = []
    for offset in 0 ..< numberOfBatteries {
      var i = idxs.last == nil ? offset : idxs.last! + 1
      var maxIdx = i

      while i < bank.count - (numberOfBatteries - offset) + 1 {
        if bank[i] > bank[maxIdx] {
          maxIdx = i
        }

        i += 1
      }

      idxs.append(maxIdx)
    }

    let bankResult: Int = idxs.enumerated().reduce(0) { prev, current in
      let (position, index) = current
      return prev + Int(pow(Double(10), Double(numberOfBatteries - position - 1))) * bank[index]
    }

    result += bankResult
  }

  return result
}

print("Total output joltage (1)", task(data, numberOfBatteries: 2))
print("Total output joltage (2)", task(data, numberOfBatteries: 12))