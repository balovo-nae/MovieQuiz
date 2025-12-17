//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Yuriy Mur on 16.12.2025.
//

import Foundation

protocol StatisticServiceProtocol {
    var gamesCount: Int { get }
    var totalCorrectAnswers: Int { get }
    var totalQuestionsAsked: Int { get }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }
    func store(correct count: Int, total amount: Int)
}
