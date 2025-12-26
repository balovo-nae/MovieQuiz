//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Yuriy Mur on 15.12.2025.
//

import Foundation
protocol QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer() // сообщение об успешной загрузке
    func didFailToLoadData(with error: Error) // сообщение об ошибке загрузки
}
