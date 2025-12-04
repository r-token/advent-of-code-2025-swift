//
//  Day02.swift
//  AdventOfCode
//
//  Created by Ryan Token on 12/3/25.
//

import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    return data.split(separator: ",").compactMap {
      String($0).trimmingCharacters(in: .whitespacesAndNewlines)
    }
  }

  private struct Range {
    let begin: Int
    let end: Int
  }

  private func parseRanges(from entity: String) -> Range {
    let splitEntity = entity.split(separator: "-")
    let beginRange: Int = Int(String(splitEntity.first ?? "0")) ?? 0
    let endRange: Int = Int(String(splitEntity.last ?? "0")) ?? 0

    return Range(begin: beginRange, end: endRange)
  }

  private func isInvalidID(_ id: Int) -> Bool {
    guard id >= 10 else { return false }

    let stringId = String(id)
    let idCount = stringId.count
    // IDs can't start with 0, and they need to have a length that's an even number
    // so that we can split get an even prefix & suffix
    guard stringId.first != "0" && (idCount%2 == 0) else { return false }

    let numberPrefix = stringId.dropLast(idCount/2)
    let numberSuffix = stringId.dropFirst(idCount/2)
    return numberPrefix == numberSuffix
  }

  func part1() -> Any {
    var invalidIDSum = 0

    for entity in entities {
      let range = parseRanges(from: entity)
      for id in range.begin...range.end {
        if isInvalidID(id) {
          print("Found invalid ID: \(id)")
          invalidIDSum += id
        }
      }
    }

    return invalidIDSum
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    return 0
  }
}
