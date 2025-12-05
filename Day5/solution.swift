import Foundation

func freshAvailableIngredients(_ data: [String]) -> Int {
  let splitIndex = data.firstIndex(where: {
    $0.isEmpty
  })!

  let ranges: [ClosedRange<Int>] = data[data.startIndex ..< splitIndex]
    .map {
      let range = $0.split(separator: "-")
      return Int(String(range[0]))! ... Int(String(range[1]))!
    }

  return data[splitIndex + 1 ..< data.endIndex]
    .filter { element in ranges.first(where: { $0.contains(Int(element)!) }) != nil }
    .count
}

func freshIngredients(_ data: [String]) -> Int {
  let splitIndex = data.firstIndex(where: {
    $0.isEmpty
  })!

  var ranges = data[data.startIndex ..< splitIndex].map {
    let upperLower = $0.split(separator: "-")
    return Int(String(upperLower[0]))! ... Int(String(upperLower[1]))!
  }.sorted(by: { $0.lowerBound < $1.lowerBound})

  var result: Int = (ranges[0].upperBound + 1) - ranges[0].lowerBound

  var index = 1
  while index < ranges.count {
    let prev = ranges[index-1]
    let cur = ranges[index]

    if cur.upperBound <= prev.upperBound {
      ranges.remove(at: index)
    } else if cur.lowerBound <= prev.upperBound {
      result += cur.upperBound - prev.upperBound
      index += 1
    } else {
      result += (cur.upperBound + 1) - cur.lowerBound
      index += 1
    }
  }

  return result
}

let data = try! String(contentsOfFile: "input", encoding: .utf8)
  .split(separator: "\n", omittingEmptySubsequences: false)
  .map { String($0) }

print("\(freshAvailableIngredients(data)) are fresh")
print("\(freshIngredients(data)) are fresh")