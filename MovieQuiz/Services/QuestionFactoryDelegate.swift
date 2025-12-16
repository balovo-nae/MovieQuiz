//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Yuriy Mur on 15.12.2025.
//

import Foundation
protocol QuestionFactoryDelegate: AnyObject {               // 1
    func didReceiveNextQuestion(question: QuizQuestion?)    // 2
}
