import UIKit

final class RegistrationViewController: UIViewController {
    
    // MARK: - UI and Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Открыт RegisterVC")
        
        view.backgroundColor = .red
        
        setView()
        setupConstraints()
    }
    private func setView() {
        // Здесь добавляются новые элементы для отображения на экране
    }
    
    // MARK: - Actions
    
}

// MARK: - Constraints

extension RegistrationViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Здесь прописываются констрейнты для элементов
        ])
    }
}

