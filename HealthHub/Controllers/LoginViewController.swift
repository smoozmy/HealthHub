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
        element.backgroundColor = .red
        
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
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var passwordTextField: UITextField = {
        let element = UITextField()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var loginButton: UIButton = {
        let element = UIButton(type: .system)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var forgottenPasswordButton: UIButton = {
        let element = UIButton(type: .system)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var noAccountLabel: UILabel = {
        let element = UILabel()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var createAccountButton: UIButton = {
        let element = UIButton(type: .system)
        
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
        mainStackView.addArrangedSubview(loginButton)
        mainStackView.addArrangedSubview(forgottenPasswordButton)
        mainStackView.addArrangedSubview(noAccountLabel)
        mainStackView.addArrangedSubview(createAccountButton)
    }
    
    // MARK: - Actions
    
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

        ])
    }
}

