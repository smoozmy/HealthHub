import UIKit

final class GoalSetupViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private var currentStepIndex = 0
    private var userGoal = UserGoal()
    private let steps: [GoalSetupStep] = [
        .goalType,
        .currentWeight,
        .height,
        .birthDate,
        .activityLevel
    ]
    
    // MARK: - UI Elements
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Шаг 1 из \(steps.count)"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Далее", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Назад", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // UI Elements for Steps
    private var stepTitleLabel = UILabel()
    private var verticalStackView = UIStackView()
    private var textField = UITextField()
    private var datePicker = UIDatePicker()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupView()
        updateContentForCurrentStep()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(progressLabel)
        view.addSubview(contentView)
        view.addSubview(nextButton)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contentView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Update Content
    
    private func updateContentForCurrentStep() {
        // Удаляем предыдущие элементы
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        progressLabel.text = "Шаг \(currentStepIndex + 1) из \(steps.count)"
        
        let currentStep = steps[currentStepIndex]
        
        switch currentStep {
        case .goalType:
            showGoalTypeStep()
        case .currentWeight:
            showCurrentWeightStep()
        case .height:
            showHeightStep()
        case .birthDate:
            showBirthDateStep()
        case .activityLevel:
            showActivityLevelStep()
        }
    }
    
    // MARK: - Step Views
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func showGoalTypeStep() {
        stepTitleLabel = createTitleLabel(text: "Выберите вашу цель")
        let options = ["Похудение", "Поддержание веса", "Набор веса"]
        verticalStackView = createVerticalButtonStack(options: options, action: #selector(goalTypeSelected(_:)))
        setupStepConstraints()
    }
    
    private func showCurrentWeightStep() {
        stepTitleLabel = createTitleLabel(text: "Введите ваш текущий вес (кг)")
        textField = createTextField(placeholder: "Вес в кг", text: userGoal.currentWeight != nil ? "\(userGoal.currentWeight!)" : "")
        setupStepConstraints()
    }
    
    private func showHeightStep() {
        stepTitleLabel = createTitleLabel(text: "Введите ваш рост (см)")
        textField = createTextField(placeholder: "Рост в см", text: userGoal.height != nil ? "\(userGoal.height!)" : "")
        setupStepConstraints()
    }
    
    private func showBirthDateStep() {
        stepTitleLabel = createTitleLabel(text: "Выберите вашу дату рождения")
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        if let birthDate = userGoal.birthDate {
            datePicker.date = birthDate
        }
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        setupStepConstraints()
    }
    
    private func showActivityLevelStep() {
        stepTitleLabel = createTitleLabel(text: "Выберите уровень активности")
        let options = ["Малоподвижный", "Лёгкая активность", "Средняя активность", "Высокая активность", "Очень высокая активность"]
        verticalStackView = createVerticalButtonStack(options: options, action: #selector(activityLevelSelected(_:)))
        setupStepConstraints()
    }
    
    // MARK: - UI Creation Helpers
    
    private func createTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createTextField(placeholder: String, text: String) -> UITextField {
        let field = UITextField()
        field.placeholder = placeholder
        field.text = text
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 8
        field.keyboardType = .decimalPad
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        return field
    }
    
    private func createVerticalButtonStack(options: [String], action: Selector) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        for option in options {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.backgroundColor = .systemGray6
            button.layer.cornerRadius = 8
            button.tintColor = .black
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            button.addTarget(self, action: action, for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
        return stack
    }
    
    private func setupStepConstraints() {
        // Удаляем предыдущие элементы
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        contentView.addSubview(stepTitleLabel)
        NSLayoutConstraint.activate([
            stepTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            stepTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stepTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        let currentStep = steps[currentStepIndex]
        
        switch currentStep {
        case .goalType, .activityLevel:
            contentView.addSubview(verticalStackView)
            NSLayoutConstraint.activate([
                verticalStackView.topAnchor.constraint(equalTo: stepTitleLabel.bottomAnchor, constant: 16),
                verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        case .currentWeight, .height:
            contentView.addSubview(textField)
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: stepTitleLabel.bottomAnchor, constant: 16),
                textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                textField.heightAnchor.constraint(equalToConstant: 44)
            ])
        case .birthDate:
            contentView.addSubview(datePicker)
            NSLayoutConstraint.activate([
                datePicker.topAnchor.constraint(equalTo: stepTitleLabel.bottomAnchor, constant: 16),
                datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
    }
    
    // MARK: - Actions
    
    @objc private func nextButtonTapped() {
        if validateCurrentStep() {
            if currentStepIndex < steps.count - 1 {
                currentStepIndex += 1
                updateContentForCurrentStep()
            } else {
                calculateBMRAndCalories()
                saveAllData()
                navigateToProfileScreen()
            }
        }
    }
    
    @objc private func backButtonTapped() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
            updateContentForCurrentStep()
        }
    }
    
    @objc private func goalTypeSelected(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        userGoal.goalType = title
        updateButtonSelection(in: verticalStackView, selectedButton: sender)
    }
    
    @objc private func activityLevelSelected(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        userGoal.activityLevel = title
        updateButtonSelection(in: verticalStackView, selectedButton: sender)
    }
    
    // MARK: - Validation
    
    private func validateCurrentStep() -> Bool {
        let currentStep = steps[currentStepIndex]
        switch currentStep {
        case .goalType:
            if userGoal.goalType == nil {
                showError("Пожалуйста, выберите вашу цель.")
                return false
            }
        case .currentWeight:
            if let text = textField.text, let weight = Decimal(string: text), weight > 0 && weight < 500 {
                userGoal.currentWeight = weight
            } else {
                showError("Пожалуйста, введите корректный вес.")
                return false
            }
        case .height:
            if let text = textField.text, let height = Decimal(string: text), height > 50 && height < 300 {
                userGoal.height = height
            } else {
                showError("Пожалуйста, введите корректный рост.")
                return false
            }
        case .birthDate:
            let birthDate = datePicker.date
            if calculateAge(birthDate: birthDate) >= 18 {
                userGoal.birthDate = birthDate
            } else {
                showError("Вам должно быть не менее 18 лет.")
                return false
            }
        case .activityLevel:
            if userGoal.activityLevel == nil {
                showError("Пожалуйста, выберите уровень активности.")
                return false
            }
        }
        return true
    }
    
    // MARK: - Helper Methods
    
    private func updateButtonSelection(in stackView: UIStackView, selectedButton: UIButton) {
        for case let button as UIButton in stackView.arrangedSubviews {
            button.backgroundColor = button == selectedButton ? .systemBlue : .systemGray6
            button.tintColor = button == selectedButton ? .white : .black
        }
    }
    
    private func calculateAge(birthDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthDate, to: Date())
        return components.year ?? 0
    }
    
    private func calculateBMRAndCalories() {
        guard let weightDecimal = userGoal.currentWeight,
              let heightDecimal = userGoal.height,
              let birthDate = userGoal.birthDate,
              let activityLevel = userGoal.activityLevel,
              let goalType = userGoal.goalType else {
            return
        }
        
        let age = calculateAge(birthDate: birthDate)
        let gender = getUserGender()
        
        // Преобразуем Decimal в Double для расчетов
        let weight = NSDecimalNumber(decimal: weightDecimal).doubleValue
        let height = NSDecimalNumber(decimal: heightDecimal).doubleValue
        
        var bmr: Double = 0
        
        if gender == "Мужской" {
            bmr = 10 * weight + 6.25 * height - 5 * Double(age) + 5
        } else {
            bmr = 10 * weight + 6.25 * height - 5 * Double(age) - 161
        }
        
        let activityFactor: Double
        switch activityLevel {
        case "Малоподвижный":
            activityFactor = 1.2
        case "Лёгкая активность":
            activityFactor = 1.375
        case "Средняя активность":
            activityFactor = 1.55
        case "Высокая активность":
            activityFactor = 1.725
        case "Очень высокая активность":
            activityFactor = 1.9
        default:
            activityFactor = 1.2
        }
        
        let tdee = bmr * activityFactor
        let caloricIntake: Double
        switch goalType {
        case "Похудение":
            caloricIntake = tdee * 0.8
        case "Поддержание веса":
            caloricIntake = tdee
        case "Набор веса":
            caloricIntake = tdee * 1.2
        default:
            caloricIntake = tdee
        }
        
        userGoal.caloricIntake = Decimal(caloricIntake)
        
        // Устанавливаем начальный вес, если он еще не установлен
        if userGoal.startingWeight == nil {
            userGoal.startingWeight = userGoal.currentWeight
        }
    }
    
    private func getUserGender() -> String {
        return UserDefaults.standard.string(forKey: "UserGender") ?? "Мужской"
    }
    
    private func saveAllData() {
        if let data = try? JSONEncoder().encode(userGoal) {
            UserDefaults.standard.set(data, forKey: "UserGoal")
        }
    }
    
    private func navigateToProfileScreen() {
        let profileVC = ProfileViewController()
        profileVC.modalPresentationStyle = .fullScreen
        present(profileVC, animated: true)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

enum GoalSetupStep {
    case goalType
    case currentWeight
    case height
    case birthDate
    case activityLevel
}


