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
    // so that we can split it to get an even prefix & suffix
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
          invalidIDSum += id
        }
      }
    }

    return invalidIDSum
  }

  private func isInvalidIDPart2(_ id: Int) -> Bool {
    guard id >= 10 else { return false }

    let stringId = String(id)
    let idCount = stringId.count
    // IDs can't start with 0
    guard stringId.first != "0" else { return false }

    switch idCount {
    case 4:
      return isAllOneNumber(stringId) || isTwoPairs(stringId)
    case 6:
      return isAllOneNumber(stringId) || isTwoPairs(stringId) || isThreePairs(stringId)
    case 8:
      return isAllOneNumber(stringId) || isTwoPairs(stringId) || isFourPairs(stringId)
    case 9:
      return isAllOneNumber(stringId) || isThreePairs(stringId)
    case 10:
      return isAllOneNumber(stringId) || isTwoPairs(stringId) || isFivePairs(stringId)
    default:
      return isAllOneNumber(stringId)
    }
  }

  private func isTwoPairs(_ stringId: String) -> Bool {
    let numberPrefix = stringId.dropLast(stringId.count/2)
    let numberSuffix = stringId.dropFirst(stringId.count/2)
    return numberPrefix == numberSuffix
  }

  private func isThreePairs(_ stringId: String) -> Bool {
    let count = Double(stringId.count)
    let firstThird = stringId.dropLast(Int(count/1.5))
    let middleThird = stringId.dropFirst(Int(count/3)).dropLast(Int(count)/3)
    let lastThird = stringId.dropFirst(Int(count/1.5))
    return firstThird == middleThird && firstThird == lastThird
  }

  private func isFourPairs(_ stringId: String) -> Bool {
    let count = Double(stringId.count)
    let firstQuarter = stringId.dropLast(Int(count/1.333333333333333))
    let secondQuarter = stringId.dropFirst(Int(count/4)).dropLast(Int(count/2))
    let thirdQuarter = stringId.dropFirst(Int(count/2)).dropLast(Int(count/4))
    let lastQuarter = stringId.dropFirst(Int(count/1.333333333333333))
    return firstQuarter == secondQuarter &&
      firstQuarter == thirdQuarter &&
      firstQuarter == lastQuarter
  }

  private func isFivePairs(_ stringId: String) -> Bool {
    let count = Double(stringId.count)
    let firstFifth = stringId.dropLast(Int(count/1.25))
    let secondFifth = stringId.dropFirst(Int(count/5)).dropLast(Int(count/1.66666666666666))
    let thirdFifth = stringId.dropFirst(Int(count/2.5)).dropLast(Int(count/2.5))
    let fourthFifth = stringId.dropFirst(Int(count/1.66666666666666)).dropLast(Int(count/5))
    let lastFifth = stringId.dropFirst(Int(count/1.25))
    return firstFifth == secondFifth &&
      firstFifth == thirdFifth &&
      firstFifth == fourthFifth &&
      firstFifth == lastFifth
  }

  private func isAllOneNumber(_ stringId: String) -> Bool {
    var allOneNumber = true
    var prevChar: Character?
    for (idx, char) in stringId.enumerated() {
      if idx == 0 {
        prevChar = char
        continue
      } else {
        if prevChar != char {
          allOneNumber = false
          break
        }
      }
    }
    return allOneNumber
  }

  func part2() -> Any {
    var invalidIDSum = 0

    for entity in entities {
      let range = parseRanges(from: entity)
      for id in range.begin...range.end {
        if isInvalidIDPart2(id) {
          invalidIDSum += id
        }
      }
    }

    return invalidIDSum
  }
}
