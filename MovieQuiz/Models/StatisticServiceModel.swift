//
//  StatisticServiceModel.swift
//  MovieQuiz
//
//  Created by Yuriy Mur on 16.12.2025.
//

import Foundation
struct GameResult {
    let correct: Int
    let total: Int
    let date: Date

    // метод сравнения по количеству верных ответов
    func isBetterThan(_ another: GameResult) -> Bool {
        correct > another.correct
    }
}
