import Foundation

let data = try! String(contentsOfFile:  "input", encoding: .utf8)

let ranges = data
  .split(separator: ",")
  .map {
    let ranges = $0.split(separator: "-")
    return (
      String(ranges[0].trimmingCharacters(in: .whitespacesAndNewlines)),
      String(ranges[1].trimmingCharacters(in: .whitespacesAndNewlines))
    )
  }

func task1(_ ranges: [(String, String)]) -> Int {
  var result = 0
  let ranges = ranges.filter {
    if $0.0.count == $0.1.count && ($0.0.count % 2 != 0) {
      return false
    } else {
      return true
    }
  }

  for range in ranges {
    rangeLoop: for i in Int(range.0)! ... Int(range.1)! {
      let str = String(i)
      if (str.count % 2) != 0 {
        continue rangeLoop
      }

      let i = str.index(str.startIndex, offsetBy: str.count / 2)

      if str[str.startIndex..<i] == str[i..<str.endIndex] {
        result += Int(str)!
      }
    }
  }

  return result
}

func task2(_ ranges: [(String, String)]) -> Int {
  var result = 0

  for range in ranges {
    rangeLoop: for i in Int(range.0)! ... Int(range.1)! where i > 9 {
      let str = String(i)

      let maxChunkSize = str.count / 2
      chunkLoop: for chunkSize in (1...maxChunkSize).reversed() {
        var lastChunk: String?

        for step in stride(from: 0, to: str.count, by: chunkSize) {
          let i = str.index(str.startIndex, offsetBy: step)
          let j = str.index(str.startIndex, offsetBy: min(step + chunkSize, str.count))

          let chunk = str[i..<j]

          if lastChunk == nil {
            lastChunk = String(chunk)
          } else {
            if lastChunk! != chunk {
              continue chunkLoop
            }
          }
        }

        result += Int(str)!
        continue rangeLoop
      }
    }
  }

  return result
}

print("Task 1:", task1(ranges))
print("Task 2:", task2(ranges))