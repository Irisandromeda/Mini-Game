//
//  Game.swift
//  RightOnTarget
//
//  Created by Irisandromeda on 18.12.2022.
//

import Foundation

protocol GameProtocol {
    var score: Int { get }
    var currentSecretValue: Int { get }
    var isGameEnded: Bool { get }
    func calculatedScore(with value: Int)
    func startNewRound()
    func restartGame()
}

class Game: GameProtocol {
    var score: Int = 0
    var currentSecretValue: Int = 0
    var isGameEnded: Bool {
        if currentRound >= lastRound {
            return true
        } else {
            return false
        }
    }
    
    private var minSecretValue: Int
    private var maxSecretValue: Int
    private var lastRound: Int
    private var currentRound: Int = 1
    
    init?(startValue: Int, endValue: Int, rounds: Int) {
        guard startValue <= endValue else { return nil }
        
        minSecretValue = startValue
        maxSecretValue = endValue
        lastRound = rounds
        currentSecretValue = getSecretValue()
    }
    
    func calculatedScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
    
    func startNewRound() {
        currentSecretValue = getSecretValue()
        currentRound += 1
    }
    
    func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    private func getSecretValue() -> Int {
        return (minSecretValue...maxSecretValue).randomElement() ?? 0
    }
    
}
