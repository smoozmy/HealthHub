import UIKit

final class WeighInViewController: UIViewController {
    
    var currentWeight: Decimal = 0.0
    var onSave: ((Decimal) -> Void)?
    
    // UI Elements
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = formattedWeightString(currentWeight)
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 48)
        button.addTarget(self, action: #selector(decreaseWeight), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 48)
        button.addTarget(self, action: #selector(increaseWeight), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(saveWeight), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    // Setup View
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(weightLabel)
        view.addSubview(minusButton)
        view.addSubview(plusButton)
        view.addSubview(saveButton)
    }
    
    // Actions
    @objc private func decreaseWeight() {
        currentWeight -= 0.1
        updateWeightLabel()
    }
    
    @objc private func increaseWeight() {
        currentWeight += 0.1
        updateWeightLabel()
    }
    
    private func updateWeightLabel() {
        weightLabel.text = formattedWeightString(currentWeight)
    }
    
    private func formattedWeightString(_ weight: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.decimalSeparator = "."
        if let weightString = formatter.string(from: weight as NSDecimalNumber) {
            return "\(weightString) кг"
        }
        return "\(weight) кг"
    }
    
    @objc private func saveWeight() {
        onSave?(currentWeight)
        dismiss(animated: true)
    }
    
    // Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            minusButton.trailingAnchor.constraint(equalTo: weightLabel.leadingAnchor, constant: -40),
            minusButton.centerYAnchor.constraint(equalTo: weightLabel.centerYAnchor),
            
            plusButton.leadingAnchor.constraint(equalTo: weightLabel.trailingAnchor, constant: 40),
            plusButton.centerYAnchor.constraint(equalTo: weightLabel.centerYAnchor),
            
            saveButton.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 60),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
