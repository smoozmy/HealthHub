import UIKit

final class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    var gender = ""
    
    // MARK: - UI and Lifecycle
    
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
        element.spacing = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var helloTextLabel: UILabel = {
        let element = UILabel()
        element.text = "Привет, мир!"
        element.textColor = .clear
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 22, weight: .semibold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var descriptionTextLabel: UILabel = {
        let element = UILabel()
        element.text = "Пройди регистрацию\nи настрой свою цель"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 20, weight: .medium)
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.returnKeyType = .done
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }
    
    private lazy var nameTextField = createTextField(placeholder: "Введи свое имя")
    private lazy var emailTextField = createTextField(placeholder: "Укажи email")
    private lazy var passwordTextField = createTextField(placeholder: "Придумай пароль")
    private lazy var passwordDoubleTextField = createTextField(placeholder: "Повтори пароль")
    
    private lazy var genderLabel: UILabel = {
        let element = UILabel()
        element.text = "Выбери пол"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 16, weight: .medium)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var genderButtonStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fillEqually
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var maleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Мужской", for: .normal)
        button.backgroundColor = .lightText
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(maleButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var femaleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Женский", for: .normal)
        button.backgroundColor = .lightText
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(femaleButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var registerButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Регистрация", for: .normal)
        element.backgroundColor = .lightText
        element.layer.cornerRadius = 15
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.tintColor = .gray
        element.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var haveAccountButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("У меня есть аккаунт", for: .normal)
        element.addTarget(self, action: #selector(haveAccountButtonTapped), for: .touchUpInside)
        element.setTitleColor(.systemIndigo, for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = Colors.angularGradientLayerSetupGoal(bounds: view.bounds)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(bgView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(helloTextLabel)
        mainStackView.addArrangedSubview(descriptionTextLabel)
        mainStackView.addArrangedSubview(nameTextField)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(passwordDoubleTextField)
        mainStackView.addArrangedSubview(genderLabel)
        
        genderButtonStackView.addArrangedSubview(maleButton)
        genderButtonStackView.addArrangedSubview(femaleButton)
        mainStackView.addArrangedSubview(genderButtonStackView)
        mainStackView.addArrangedSubview(registerButton)
        mainStackView.addArrangedSubview(haveAccountButton)
    }
    
    private func choiceGender() {
        print("Перекрашивание кнопок пола")
        if gender == "Мужской" {
            maleButton.backgroundColor = .systemBlue
            maleButton.setTitleColor(.white, for: .normal)
            femaleButton.backgroundColor = .lightText
            femaleButton.setTitleColor( .gray, for: .normal)
        } else {
            femaleButton.backgroundColor = .systemPink
            femaleButton.setTitleColor(.white, for: .normal)
            maleButton.backgroundColor = .lightText
            maleButton.setTitleColor( .gray, for: .normal)
        }
    }
    
    @objc private func maleButtonTapped() {
        print("RegistrVC: Выбран пол - Мужской")
        gender = "Мужской"
        choiceGender()
    }
    
    @objc private func femaleButtonTapped() {
        print("RegistrVC: Выбран пол - Женский")
        gender = "Женский"
        choiceGender()
    }
    
    @objc private func haveAccountButtonTapped() {
        print("RegistrVC: Кнопка Есть аккаунт нажата")
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
    
    @objc private func registerButtonTapped() {
        print("RegistrVC: Кнопка Регистрация нажата")
        
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let passwordConfirm = passwordDoubleTextField.text,
              !name.isEmpty, !email.isEmpty, !password.isEmpty, !passwordConfirm.isEmpty
        else {
            print("Заполните все поля")
            return
        }
        
        guard password == passwordConfirm else {
            print("Пароли не совпадают")
            return
        }
        
        // Создаем нового пользователя
        let newUser = User(id: UUID().uuidString, name: name, email: email, password: password, gender: gender)
        
        // Получаем текущий список пользователей из UserDefaults
        var users = [User]()
        if let data = UserDefaults.standard.data(forKey: "users"),
           let savedUsers = try? JSONDecoder().decode([User].self, from: data) {
            users = savedUsers
        }
        
        // Проверяем, существует ли уже пользователь с таким email
        if users.contains(where: { $0.email == email }) {
            print("Пользователь с таким email уже существует")
            return
        }
        
        // Добавляем нового пользователя в массив
        users.append(newUser)
        
        // Сохраняем обновленный массив пользователей
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: "users")
        }
        
        // Сохраняем информацию о текущем пользователе
        UserDefaults.standard.set(newUser.email, forKey: "currentUserEmail")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        // Переходим на экран профиля
        let profileVC = ProfileViewController()
        profileVC.modalPresentationStyle = .fullScreen
        present(profileVC, animated: true)
    }

    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Constraints

extension RegistrationViewController {
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
            
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordDoubleTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordDoubleTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            genderButtonStackView.heightAnchor.constraint(equalToConstant: 50),
            genderButtonStackView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 15),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.bottomAnchor.constraint(equalTo: haveAccountButton.topAnchor, constant: -80),
            haveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            
        ])
    }
}
