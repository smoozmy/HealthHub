import UIKit

//AngularGradient(colors: [.indigo, .mint, .purple, .cyan], center: .bottomLeading)


final class LoginViewController: UIViewController {
    
    // MARK: - UI and Lyfe Cycle
    private lazy var bgView: UIView = {
        let element = UIView()
        element.backgroundColor = .white30
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .equalCentering
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    private lazy var loginLabel: UILabel = {
        let element = UILabel()
        element.text = "Войти с помощью\nэлектронной почты"
        element.numberOfLines = 0
        element.textAlignment = .center
        element.font = .systemFont(ofSize: .init(22), weight: .semibold)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var emailTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "Введи email"
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: element.frame.height))
        element.leftView = leftPaddingView
        element.leftViewMode = .always
        
        element.backgroundColor = .white
        element.layer.cornerRadius = 12
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var passwordTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "Введи пароль"
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: element.frame.height))
        element.leftView = leftPaddingView
        element.leftViewMode = .always
        
        element.backgroundColor = .white
        element.layer.cornerRadius = 12
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
 
    private lazy var loginButtonStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fillEqually
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var spacer1: UIView = {
        let element = UIView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var spacer2: UIView = {
        let element = UIView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var loginButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Войти", for: .normal)
        element.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        element.backgroundColor = .lightText
        element.layer.cornerRadius = 15
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.tintColor = .gray
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var forgottenPasswordButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Вы забыли пароль?", for: .normal)
        element.addTarget(self, action: #selector(forgottenPasswordButtonTapped), for: .touchUpInside)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.setTitleColor(.systemIndigo, for: .normal)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var noAccountLabel: UILabel = {
        let element = UILabel()
        element.text = "Не зарегистрированы?"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 16)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var createAccountButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Создать учетную запись", for: .normal)
        element.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        element.setTitleColor(.systemIndigo, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = Colors.angularGradientLayerSetupGoal(bounds: view.bounds)
                view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        
        setView()
        setupConstraints()
    }
    private func setView() {
        view.addSubview(bgView)
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(loginLabel)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(loginButtonStackView)
        loginButtonStackView.addArrangedSubview(spacer1)
        loginButtonStackView.addArrangedSubview(loginButton)
        loginButtonStackView.addArrangedSubview(spacer2)
        mainStackView.addArrangedSubview(forgottenPasswordButton)
        mainStackView.addArrangedSubview(noAccountLabel)
        mainStackView.addArrangedSubview(createAccountButton)
    }
    
    // MARK: - Actions
    
    @objc private func loginButtonTapped() {
        print("LoginVC: Кнопка Войти нажата")
    }
    
    @objc private func forgottenPasswordButtonTapped() {
        print("LoginVC: Кнопка Забыли пароль нажата")
    }
    
    @objc private func createAccountButtonTapped() {
        print("LoginVC: Кнопка Создать УЗ нажата")
    }
    
}

// MARK: - Constraints

extension LoginViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loginLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4),
            
            emailTextField.heightAnchor.constraint(equalToConstant: .init(60)),
            passwordTextField.heightAnchor.constraint(equalToConstant: .init(60)),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            loginButtonStackView.heightAnchor.constraint(equalToConstant: .init(50)),
            
            loginButtonStackView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60),
            forgottenPasswordButton.topAnchor.constraint(equalTo: loginButtonStackView.bottomAnchor, constant: 50),
            
            noAccountLabel.bottomAnchor.constraint(equalTo: createAccountButton.topAnchor)

        ])
    }
}

