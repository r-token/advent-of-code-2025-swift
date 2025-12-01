//
//  Day01.swift
//  AdventOfCode
//
//  Created by Ryan Token on 12/1/25.
//

import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    return data.split(separator: "\n").compactMap { String($0) }
  }

  private enum Direction {
    case left, right, unknown
  }

  private func rotate(_ direction: Direction, from initial: Int, clicks: Int) -> Int {
    var normalizedClicks = clicks > 99 ? clicks%100 : clicks

    switch direction {
    case .left:
      if initial - normalizedClicks < 0 {
        return (initial - normalizedClicks) + 100
      } else {
        return initial - normalizedClicks
      }
    case .right:
      if initial + normalizedClicks > 99 {
        return (initial + normalizedClicks) - 100
      } else {
        return initial + normalizedClicks
      }
    case .unknown:
      return 0
    }
  }

  private func parseDirection(from input: String) -> Direction {
    switch input.first {
    case "L":
      return .left
    case "R":
      return .right
    default:
      return .unknown
    }
  }

  private func parseClickAmount(from input: String) -> Int {
    Int(input.dropFirst()) ?? 0
  }

  func part1() -> Any {
    var zeroCounter = 0
    var currentPosition = 50

    for entity in entities {
      let direction = parseDirection(from: entity)
      let amount = parseClickAmount(from: entity)

      switch direction {
      case .left:
        currentPosition = rotate(.left, from: currentPosition, clicks: amount)
      case .right:
        currentPosition = rotate(.right, from: currentPosition, clicks: amount)
      case .unknown:
        break
      }

      if currentPosition == 0 {
        zeroCounter += 1
      }
    }

    return zeroCounter
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Sum the maximum entries in each set of data
    // entities.map { $0.max() ?? 0 }.reduce(0, +)
    return 0
  }
}

