import Foundation

struct TaskModel: Identifiable, Codable {
    let id: String
    let task: String
    let isCompleted: Bool
    let subTasks: [SubTaskModel]
    
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
    
    func updateTaskModel() -> TaskModel {
         return TaskModel(
            id: id,
            task: task,
            isCompleted: !isCompleted,
            subTasks: subTasks
         )
    }
}
