//
//  Day03.swift
//  AdventOfCode
//
//  Created by Ryan Token on 12/15/25.
//

import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var batteryBanks: [String] {
    return data.split(separator: "\n").compactMap { String($0) }
  }

  private func getJoltageSum(from batteryBanks: [String]) -> Int {
    var joltageSum = 0
    var maxJoltageInBank = ""
    var firstNumberInBank = 0
    var firstNumberIndex = 0
    var secondNumberInBank = 0

    for bank in batteryBanks {
      (firstNumberInBank, firstNumberIndex) = getFirstNumber(from: bank)
      secondNumberInBank = getSecondNumber(from: bank, firstNumberIndex: firstNumberIndex)

      maxJoltageInBank = "\(firstNumberInBank)\(secondNumberInBank)"
      joltageSum += Int(maxJoltageInBank) ?? 0

      (maxJoltageInBank, firstNumberInBank, firstNumberIndex, secondNumberInBank) = reset()
    }

    return joltageSum
  }

  private func getFirstNumber(from bank: String) -> (Int, Int) {
    var firstNumberInBank = 0
    var firstNumberIndex = 0

    for (idx, battery) in bank.dropLast().enumerated() {
      guard let batteryJoltage = Int(String(battery)) else { continue }
      if batteryJoltage > firstNumberInBank {
        firstNumberInBank = batteryJoltage
        firstNumberIndex = idx
      }
    }

    return (firstNumberInBank, firstNumberIndex)
  }

  private func getSecondNumber(from bank: String, firstNumberIndex: Int) -> Int {
    var secondNumberInBank = 0

    for battery in bank.dropFirst(firstNumberIndex + 1) {
      guard let batteryJoltage = Int(String(battery)) else { continue }
      if batteryJoltage > secondNumberInBank {
        secondNumberInBank = batteryJoltage
      }
    }

    return secondNumberInBank
  }

  private func reset() -> (String, Int, Int, Int) {
    ("", 0, 0, 0)
  }

  func part1() -> Any {
    return getJoltageSum(from: batteryBanks)
  }

  func part2() -> Any {
    return false
  }
}
