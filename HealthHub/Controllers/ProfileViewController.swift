import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var user: User?
    private var userGoal: UserGoal?
    
    // MARK: - UI Elements
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет, \(user?.name ?? "пользователь")!"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var caloricIntakeLabel: UILabel = {
        let label = UILabel()
        let caloricIntake = userGoal?.caloricIntake ?? Decimal(0)
        label.text = "Ваша суточная норма калорий: \(NSDecimalNumber(decimal: caloricIntake).intValue) ккал"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addWeighInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить взвешивание", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(addWeighInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var updateGoalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Обновить цель", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(updateGoalButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var startingWeightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var currentWeightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var weightDifferenceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserData()
        setupView()
        setupConstraints()
        updateWeightLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
        updateWeightLabels()
    }

    // MARK: - Setup View

    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(greetingLabel)
        contentView.addSubview(caloricIntakeLabel)
        contentView.addSubview(startingWeightLabel)
        contentView.addSubview(currentWeightLabel)
        contentView.addSubview(weightDifferenceLabel)
        contentView.addSubview(updateGoalButton)
        contentView.addSubview(addWeighInButton)
        contentView.addSubview(logoutButton)
    }

    // MARK: - Load User Data

    private func loadUserData() {
        // Загрузка текущего пользователя
        if let currentUserEmail = UserDefaults.standard.string(forKey: "currentUserEmail"),
           let data = UserDefaults.standard.data(forKey: "users"),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            user = users.first(where: { $0.email == currentUserEmail })
        }
        
        // Загрузка цели пользователя
        if let data = UserDefaults.standard.data(forKey: "UserGoal"),
           let goal = try? JSONDecoder().decode(UserGoal.self, from: data) {
            userGoal = goal
        }
    }

    // MARK: - Actions

    @objc private func addWeighInButtonTapped() {
        let weighInVC = WeighInViewController()
        weighInVC.modalPresentationStyle = .pageSheet
        if let sheet = weighInVC.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        // Передаем текущий вес и замыкание для обновления веса
        weighInVC.currentWeight = userGoal?.currentWeight ?? Decimal(0.0)
        weighInVC.onSave = { [weak self] newWeight in
            self?.userGoal?.currentWeight = newWeight
            self?.saveUserGoal()
            self?.updateWeightLabels()
        }
        present(weighInVC, animated: true)
    }

    @objc private func updateGoalButtonTapped() {
        let goalSetupVC = GoalSetupViewController()
        goalSetupVC.modalPresentationStyle = .fullScreen
        present(goalSetupVC, animated: true)
    }

    @objc private func logoutButtonTapped() {
        // Очистка данных о текущем пользователе
        UserDefaults.standard.removeObject(forKey: "currentUserEmail")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
        // Возврат на экран входа
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }

    // MARK: - Helper Methods

    private func saveUserGoal() {
        if let data = try? JSONEncoder().encode(userGoal) {
            UserDefaults.standard.set(data, forKey: "UserGoal")
        }
    }

    private func updateWeightLabels() {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.decimalSeparator = "."
        
        // Начальный вес
        if let startingWeight = userGoal?.startingWeight,
           let startingWeightString = formatter.string(from: startingWeight as NSDecimalNumber) {
            startingWeightLabel.text = "Начальный вес: \(startingWeightString) кг"
        } else {
            startingWeightLabel.text = "Начальный вес: 0.0 кг"
        }
        
        // Актуальный вес
        if let currentWeight = userGoal?.currentWeight,
           let currentWeightString = formatter.string(from: currentWeight as NSDecimalNumber) {
            currentWeightLabel.text = "Актуальный вес: \(currentWeightString) кг"
        } else {
            currentWeightLabel.text = "Актуальный вес: 0.0 кг"
        }
        
        // Разница
        if let startingWeight = userGoal?.startingWeight,
           let currentWeight = userGoal?.currentWeight {
            let difference = currentWeight - startingWeight
            if let differenceString = formatter.string(from: difference as NSDecimalNumber) {
                weightDifferenceLabel.text = "Разница: \(differenceString) кг"
            }
        } else {
            weightDifferenceLabel.text = "Разница: 0.0 кг"
        }
    }

    // MARK: - Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            greetingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            greetingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            greetingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            caloricIntakeLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 24),
            caloricIntakeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            caloricIntakeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            startingWeightLabel.topAnchor.constraint(equalTo: caloricIntakeLabel.bottomAnchor, constant: 16),
            startingWeightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            startingWeightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            currentWeightLabel.topAnchor.constraint(equalTo: startingWeightLabel.bottomAnchor, constant: 8),
            currentWeightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentWeightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            weightDifferenceLabel.topAnchor.constraint(equalTo: currentWeightLabel.bottomAnchor, constant: 8),
            weightDifferenceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            weightDifferenceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            updateGoalButton.topAnchor.constraint(equalTo: weightDifferenceLabel.bottomAnchor, constant: 32),
            updateGoalButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            updateGoalButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            updateGoalButton.heightAnchor.constraint(equalToConstant: 50),
            
            addWeighInButton.topAnchor.constraint(equalTo: updateGoalButton.bottomAnchor, constant: 16),
            addWeighInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            addWeighInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            addWeighInButton.heightAnchor.constraint(equalToConstant: 50),

            logoutButton.topAnchor.constraint(equalTo: addWeighInButton.bottomAnchor, constant: 16),
            logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            logoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -32)
        ])
    }
}
