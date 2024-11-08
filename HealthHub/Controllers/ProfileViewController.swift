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
        label.text = "Ваша суточная норма калорий: \(Int(userGoal?.caloricIntake ?? 0)) ккал"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    // Добавьте другие UI-элементы по необходимости
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserData()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(greetingLabel)
        contentView.addSubview(caloricIntakeLabel)
        contentView.addSubview(updateGoalButton)
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
            
            updateGoalButton.topAnchor.constraint(equalTo: caloricIntakeLabel.bottomAnchor, constant: 32),
            updateGoalButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            updateGoalButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            updateGoalButton.heightAnchor.constraint(equalToConstant: 50),
            
            logoutButton.topAnchor.constraint(equalTo: updateGoalButton.bottomAnchor, constant: 16),
            logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            logoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -32)
        ])
    }
}
