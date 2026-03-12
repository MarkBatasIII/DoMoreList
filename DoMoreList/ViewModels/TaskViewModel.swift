import Foundation

class TaskViewModel: ObservableObject {
    
    @Published var tasks = [TaskModel]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(tasks) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let saveItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([TaskModel].self, from: saveItems) {
                tasks = decodedItems
                return
            }
        }
        tasks = []
    }
    
    func moveItem(from: IndexSet, to: Int) {
        tasks.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(task: String) {
        let newTask = TaskModel(task: task, isCompleted: false)
        tasks.append(newTask)
    }
    
    func deleteItem(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func updateTaskCompleted(task: TaskModel ) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task.updateTaskModel()
        }
    }
    
    func updateItem(task: TaskModel, newTask: String, newSubTasks: [SubTaskModel]) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = TaskModel(
                id: task.id,
                task: newTask,
                isCompleted: task.isCompleted,
                subTasks: newSubTasks
            )
        }
    }
}
