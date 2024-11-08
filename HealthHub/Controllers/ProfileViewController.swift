import UIKit

final class ProfileViewController: UIViewController {
    
    var currentUser: User?
    
    let name = UserDefaults.standard.string(forKey: "name") ?? "Пользователь"
    let email = UserDefaults.standard.string(forKey: "email") ?? "Почта"
    let password = UserDefaults.standard.string(forKey: "password") ?? "Пароль"
    let gender = UserDefaults.standard.string(forKey: "gender") ?? "Пол"
    
    // MARK: - UI and Lyfe Cycle
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fillEqually
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var helloLabel: UILabel = {
        let element = UILabel()
        element.text = "Привет, \(name)"
        
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var emailLabel: UILabel = {
        let element = UILabel()
        element.text = "Твой имейл - \(email)"
        
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var passwordLabel: UILabel = {
        let element = UILabel()
        element.text = "Твой пароль - \(password)"
        
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var genderLabel: UILabel = {
        let element = UILabel()
        element.text = "Твой пол - \(gender)"
        
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var logoutButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Logout", for: .normal)
        element.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        
        if let email = UserDefaults.standard.string(forKey: "currentUserEmail"),
           let data = UserDefaults.standard.data(forKey: "users"),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            currentUser = users.first(where: { $0.email == email })
        }
        
        // Обновляем UI с данными пользователя
        if let user = currentUser {
            helloLabel.text = "Привет, \(user.name)"
            emailLabel.text = "Твой email: \(user.email)"
            passwordLabel.text = "Твой пароль: \(user.password)"
            genderLabel.text = "Твой пол: \(user.gender)"
        }
    
        
        setView()
        setupConstraints()
    }
    private func setView() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(helloLabel)
        mainStackView.addArrangedSubview(logoutButton)
        mainStackView.addArrangedSubview(emailLabel)
        mainStackView.addArrangedSubview(passwordLabel)
        mainStackView.addArrangedSubview(genderLabel)
    }
    
    // MARK: - Actions

    
    @objc private func logout() {
        UserDefaults.standard.set(nil, forKey: "currentUserEmail")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")

        let welcomeVC = WelcomeViewController()
        welcomeVC.modalPresentationStyle = .fullScreen
        present(welcomeVC, animated: false)
    }
}

// MARK: - Constraints

extension ProfileViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}

