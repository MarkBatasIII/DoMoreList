import Foundation

class TaskViewModel: ObservableObject {
    
    private let itemsKey: String = "Items"
    
    @Published var tasks: [TaskModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    init() {
        loadItems()
    }
    
    // MARK: Save/Load Items
    
    private func loadItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let decodedItems = try? JSONDecoder().decode([TaskModel].self, from: data)
        else { return }
        
        self.tasks = decodedItems
    }
    
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: itemsKey)
        }
    }
    
    // MARK: Actions
    
    func addItem(task: String) {
        let newTask = TaskModel(task: task, isCompleted: false, subTasks: [])
        tasks.append(newTask)
    }
    
    func deleteItem(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        tasks.move(fromOffsets: from, toOffset: to)
    }
    
    // MARK: Update
    
    func updateTaskCompleted(task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func updateSubTaskCompleted(task: TaskModel, subTask: SubTaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            if let subIndex = tasks[index].subTasks.firstIndex(where: { $0.id == subTask.id }) {
                tasks[index].subTasks[subIndex].isSubCompleted.toggle()
            }
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
