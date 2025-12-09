import UIKit

struct QuizQuestion {
// строка с названием фильма,
// совпадает с названием картинки афиши фильма в Assets
    let image: String
  // строка с вопросом о рейтинге фильма
    let text: String
// булевое значение (true, false), правильный ответ на вопрос
    let correctAnswer: Bool
    let realRating: Double
}


// вью модель для состояния "Вопрос показан"
struct QuizStepViewModel {
  // картинка с афишей фильма с типом UIImage
  let image: UIImage
  // вопрос о рейтинге квиза
  let question: String
  // строка с порядковым номером этого вопроса (ex. "1/10")
  let questionNumber: String
}

// для состояния "Результат квиза"
struct QuizResultsViewModel {
  // строка с заголовком алерта
  let title: String
  // строка с текстом о количестве набранных очков
  let text: String
  // текст для кнопки алерта
  let buttonText: String
}

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var counterLabel: UILabel!

    private let questions: [QuizQuestion] = [
            QuizQuestion(
                image: "The Godfather",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true,
                realRating: 9.2
            ),
            QuizQuestion(
                image: "The Dark Knight",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true,
                realRating: 9.0
            ),
            QuizQuestion(
                image: "Kill Bill",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true,
                realRating: 8.1
            ),
            QuizQuestion(
                image: "The Avengers",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true,
                realRating: 8
            ),
            QuizQuestion(
                image: "Deadpool",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true,
                realRating: 8
            ),
            QuizQuestion(
                image: "The Green Knight",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true,
                realRating: 6.6
            ),
            QuizQuestion(
                image: "Old",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false,
                realRating: 5.8
            ),
            QuizQuestion(
                image: "The Ice Age Adventures of Buck Wild",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false,
                realRating: 4.3
            ),
            QuizQuestion(
                image: "Tesla",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false,
                realRating: 5.1),
            QuizQuestion(
                image: "Vivarium",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false,
                realRating: 5.8
            )
        ]

    private var currentQuestionIndex = 0
    private var correctAnswers = 0


    override func viewDidLoad() {
        
        // берём текущий вопрос из массива вопросов по индексу текущего вопроса
        
        
        
        super.viewDidLoad()

        let currentQuestion = questions[currentQuestionIndex]
        let viewModel = convert(model: currentQuestion)
        show(quiz: viewModel)



    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = true
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)

        
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {

        let currentQuestion = questions[currentQuestionIndex]
         let givenAnswer = false
         
         showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)


    }
    
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
        return questionStep
    }

    
    private func show(quiz step: QuizStepViewModel) {
      imageView.image = step.image
      textLabel.text = step.question
      counterLabel.text = step.questionNumber
    }

    // приватный метод для показа результатов раунда квиза
    // принимает вью модель QuizResultsViewModel и ничего не возвращает
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            self.currentQuestionIndex = 0
            self.correctAnswers = 0
            
            let firstQuestion = self.questions[self.currentQuestionIndex]
            let viewModel = self.convert(model: firstQuestion)
            self.show(quiz: viewModel)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    // приватный метод, который меняет цвет рамки
    // принимает на вход булевое значение и ничего не возвращает
    private func showAnswerResult(isCorrect: Bool) {
       // метод красит рамку

        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        if(isCorrect){
            correctAnswers += 1
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
        }else{
            imageView.layer.borderColor = UIColor.ypRed.cgColor
        }
        imageView.layer.cornerRadius = 20
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
        }
        
    }
    
    
    // приватный метод, который содержит логику перехода в один из сценариев
    // метод ничего не принимает и ничего не возвращает
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 {
          // идём в состояние "Результат квиза"
            let text = "Ваш результат: \(correctAnswers)/10"
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            show(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            
            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            
            show(quiz: viewModel)
        }
    }
    
    /*
    private func finishQuiz(){
        
        let alert = UIAlertController(
            title: "Этот раунд окончен!",
            message: "Ваш результат ???",
            preferredStyle: .alert)

        let action = UIAlertAction(title: "Try again", style: .default) { _ in
            self.currentQuestionIndex = 0
            // сбрасываем переменную с количеством правильных ответов
            self.correctAnswers = 0
            
            // заново показываем первый вопрос
            let firstQuestion = self.questions[self.currentQuestionIndex]
            let viewModel = self.convert(model: firstQuestion)
            self.show(quiz: viewModel)
        }

        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
        }*/
        
        
        
    

    


    
}

/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
*/



