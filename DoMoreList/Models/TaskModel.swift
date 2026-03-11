import Foundation

struct ItemModel: Identifiable, Codable {
    let id: String
    var task: String
    var isCompleted: Bool
    
    init(
        id: String = UUID().uuidString,
        task: String,
        isCompleted: Bool
    ) {
        self.id = id
        self.task = task
        self.isCompleted = isCompleted
    }
}
