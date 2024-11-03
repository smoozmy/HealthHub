import UIKit

final class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
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
    
    private lazy var helloTextLabel: UILabel = {
        let element = UILabel()
        element.text = "Привет!"
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var descriptionTextLabel: UILabel = {
        let element = UILabel()
        element.text = "Пройди регистрацию \nи настрой свою цель"
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var nameTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "Введи свое имя"
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: element.frame.height))
        element.leftView = leftPaddingView
        element.leftViewMode = .always
        
        element.backgroundColor = .white
        element.layer.cornerRadius = 12
        
        element.returnKeyType = .done
        element.delegate = self
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var emailTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "Укажи email"
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: element.frame.height))
        element.leftView = leftPaddingView
        element.leftViewMode = .always
        
        element.backgroundColor = .white
        element.layer.cornerRadius = 12
        
        element.returnKeyType = .done
        element.delegate = self
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var passwordTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "Придумай пароль"
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: element.frame.height))
        element.leftView = leftPaddingView
        element.leftViewMode = .always
        
        element.backgroundColor = .white
        element.layer.cornerRadius = 12
        
        element.returnKeyType = .done
        element.delegate = self
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var passwordDoubleTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "Повтори пароль"
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: element.frame.height))
        element.leftView = leftPaddingView
        element.leftViewMode = .always
        
        element.backgroundColor = .white
        element.layer.cornerRadius = 12
        
        element.returnKeyType = .done
        element.delegate = self
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var genderLabel: UILabel = {
        let element = UILabel()
        element.text = "Выбери пол"
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var genderButtonStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var maleButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Мужской", for: .normal)
        element.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        element.backgroundColor = .lightText
        element.layer.cornerRadius = 15
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.tintColor = .gray
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var femaleButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Женский", for: .normal)
        element.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        element.backgroundColor = .lightText
        element.layer.cornerRadius = 15
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.tintColor = .gray
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var registerButtonStackView: UIStackView = {
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
    
    private lazy var registerButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("Зарегистрироваться", for: .normal)
        element.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        element.backgroundColor = .lightText
        element.layer.cornerRadius = 15
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.tintColor = .gray
        
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
        print("Открыт RegisterVC")
        
        let gradientLayer = Colors.angularGradientLayerSetupGoal(bounds: view.bounds)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setView()
        setupConstraints()
    }
    private func setView() {
        view.addSubview(bgView)
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(helloTextLabel)
        mainStackView.addArrangedSubview(descriptionTextLabel)
        mainStackView.addArrangedSubview(nameTextField)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(passwordDoubleTextField)
        mainStackView.addArrangedSubview(genderLabel)
        mainStackView.addArrangedSubview(genderButtonStackView)
        genderButtonStackView.addArrangedSubview(maleButton)
        genderButtonStackView.addArrangedSubview(femaleButton)
        mainStackView.addArrangedSubview(registerButtonStackView)
        registerButtonStackView.addArrangedSubview(spacer1)
        registerButtonStackView.addArrangedSubview(registerButton)
        registerButtonStackView.addArrangedSubview(spacer2)
        mainStackView.addArrangedSubview(haveAccountButton)
        
        
    }
    
    // MARK: - Actions
    
    @objc private func registerButtonTapped() {
        print("LoginVC: Кнопка Зарегистрироваться нажата")
    }
    
    @objc private func haveAccountButtonTapped() {
        print("LoginVC: Кнопка Есть аккаунт нажата")
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Скрыть клавиатуру при нажатии "Done"
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
        ])
    }
}

