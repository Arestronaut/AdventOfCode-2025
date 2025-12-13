// Man, this took me longer than I want to admit

import Foundation

struct Node: Hashable, CustomStringConvertible {
  let row: Int, column: Int

  var description: String {
    "(\(row):\(column))"
  }
}

func buildTree(_ data: [[Character]]) -> ([Node: Set<Node>], Node) {
  let rootColumn = data[2].firstIndex(where: { $0 == "^" })!
  let root = Node(row: 2, column: rootColumn)
  var tree: [Node: Set<Node>] = [root: []]
  var next: Set<Node> = [root]

  while !next.isEmpty {
    let node = next.removeFirst()
    var children = tree[node] ?? []

    var leftNode: Node?
    var rightNode: Node?

    for i in (node.row + 1) ..< data.count {
      if leftNode == nil {
          if i == data.count - 1 {
            leftNode = Node(row: i, column: node.column - 1)
            children.insert(leftNode!)
          } else if data[i][node.column - 1] == "^"  {
            leftNode = Node(row: i, column: node.column - 1)
            children.insert(leftNode!)

            next.insert(leftNode!)
        }
      }

      if rightNode == nil {
        if i == data.count - 1 {
          leftNode = Node(row: i, column: node.column + 1)
          children.insert(leftNode!)
        } else if data[i][node.column + 1] == "^" {
          rightNode = Node(row: i, column: node.column + 1)
          children.insert(rightNode!)

          next.insert(rightNode!)
        }
      }

      if leftNode != nil, rightNode != nil {
        break
      }
    }

    tree[node] = children
  }

  return (tree, root)
}

func task1(_ rawData: [[Character]], _ tree: [Node: Set<Node>]) -> Int {
  tree.keys.filter {
    rawData[$0.row][$0.column] == "^"
  }
  .count
}

func task2(_ tree: [Node: Set<Node>], _ root: Node) -> Int {
  var cache: [Node: Int] = [:]

  func countAllPaths(_ node: Node) -> Int {
    if let count = cache[node] {
      return count
    }

    let children = tree[node] ?? []

    if children.isEmpty {
      return 1
    }

    var totalPathCount = 0
    for child in children {
      totalPathCount += countAllPaths(child)
    }

    cache[node] = totalPathCount

    return totalPathCount
  }

  return countAllPaths(root)
}

let data = try! String(contentsOfFile: "input", encoding: .utf8)
  .split(separator: "\n")
  .map { Array(String($0)) }

let (tree, root) = buildTree(data)

print("Task1: \(task1(data, tree))")
print("Task2: \(task2(tree, root))")