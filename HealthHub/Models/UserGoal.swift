import Foundation

struct UserGoal: Codable {
    var goalType: String?
    var currentWeight: Decimal?
    var startingWeight: Decimal?   // Добавляем это поле
    var height: Decimal?
    var birthDate: Date?
    var activityLevel: String?
    var caloricIntake: Decimal?
}
