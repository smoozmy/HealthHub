import Foundation

struct UserGoal: Codable {
    var goalType: String?
    var currentWeight: Double?
    var height: Double?
    var birthDate: Date?
    var activityLevel: String?
    var caloricIntake: Double?
}
