import UIKit

struct Colors {
    static func angularGradientLayerSetupGoal(bounds: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [
//            UIColor.systemIndigo.cgColor,
            UIColor.systemCyan.cgColor,
            UIColor.systemIndigo.cgColor,
            UIColor.systemRed.cgColor,
            UIColor.systemRed.cgColor,
            UIColor.systemPink.cgColor,
            UIColor.systemCyan.cgColor,
            
//            UIColor.systemIndigo.cgColor
        ]
        
        gradientLayer.type = .conic
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.1)
        
        return gradientLayer
    }
}
