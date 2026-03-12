import Foundation

struct TaskModel: Identifiable, Codable {
    let id: String
    let task: String
    var isCompleted: Bool
    var subTasks: [SubTaskModel]
    
    init(
        id: String = UUID().uuidString,
        task: String,
        isCompleted: Bool,
        subTasks: [SubTaskModel] = []
    ) {
        self.id = id
        self.task = task
        self.isCompleted = isCompleted
        self.subTasks = subTasks
    }
}
