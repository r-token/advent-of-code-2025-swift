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

  private struct RotationResult {
    var newPosition: Int
    var timesPassedZero: Int
  }

  private func rotate(_ direction: Direction, from initial: Int, clicks: Int) -> RotationResult {
    let normalizedClicks = clicks > 99 ? clicks%100 : clicks
    var rotationResult = RotationResult(newPosition: 0, timesPassedZero: 0)

    switch direction {
    case .left:
      if initial - normalizedClicks < 0 {
        rotationResult.newPosition = (initial - normalizedClicks) + 100
      } else {
        rotationResult.newPosition = initial - normalizedClicks
      }
    case .right:
      if initial + normalizedClicks > 99 {
        rotationResult.newPosition = (initial + normalizedClicks) - 100
      } else {
        rotationResult.newPosition = initial + normalizedClicks
      }
    case .unknown:
      break
    }

    rotationResult.timesPassedZero = getTimesPassedZero(direction: direction, from: initial, clicks: clicks)

    return rotationResult
  }

  private func getTimesPassedZero(direction: Direction, from initial: Int, clicks: Int) -> Int {
    var timesPassedZero = 0
    let leftRotatingArray = (initial-clicks...initial).reversed()
    let rightRotatingArray = initial...initial+clicks

    switch direction {
    case .left:
      for (idx, number) in leftRotatingArray.enumerated() {
        if number % 100 == 0 && idx != 0 {
          timesPassedZero += 1
        }
      }
    case .right:
      for (idx, number) in rightRotatingArray.enumerated() {
        if number % 100 == 0 && idx != 0 {
          timesPassedZero += 1
        }
      }
    case .unknown:
      break
    }

    return timesPassedZero
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
        currentPosition = rotate(.left, from: currentPosition, clicks: amount).newPosition
      case .right:
        currentPosition = rotate(.right, from: currentPosition, clicks: amount).newPosition
      case .unknown:
        continue
      }

      if currentPosition == 0 {
        zeroCounter += 1
      }
    }

    return zeroCounter
  }

  func part2() -> Any {
    var currentPosition = 50
    var timesPassedZero = 0

    for entity in entities {
      let direction = parseDirection(from: entity)
      let amount = parseClickAmount(from: entity)

      switch direction {
      case .left:
        let rotationResult = rotate(.left, from: currentPosition, clicks: amount)
        currentPosition = rotationResult.newPosition
        timesPassedZero += rotationResult.timesPassedZero
      case .right:
        let rotationResult = rotate(.right, from: currentPosition, clicks: amount)
        currentPosition = rotationResult.newPosition
        timesPassedZero += rotationResult.timesPassedZero
      case .unknown:
        continue
      }
    }

    return timesPassedZero
  }
}
