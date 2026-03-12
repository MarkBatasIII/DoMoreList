import SwiftUI

struct UpdateView: View {
    
    @ObservedObject var taskVM: TaskViewModel
    @Environment(\.dismiss) var dismiss
    
    var taskModel: TaskModel
    
    @State private var task: String
    @State private var textSubTasks: [String] = []
    
    init(taskVM: TaskViewModel, taskModel: TaskModel) {
        self.taskVM = taskVM
        self.taskModel = taskModel
        _task = State(initialValue: taskModel.task)
    }
    
    var body: some View {
        Form {
            TextField("Update Task", text: $task)
                .frame(height: 55)
                .fontWeight(.semibold)
            Section("Sub Tasks") {
                List {
                    ForEach(0..<textSubTasks.count, id: \.self) { index in
                        TextField("Enter sub task here...", text: $textSubTasks[index])
                    }
                    .onDelete(perform: removeField)
                    Button(action: addField) {
                        Label("Add Sub Task", systemImage: "plus")
                    }
                }
            }
        }
        .navigationTitle("Edit")
        .toolbar {
            Button("Update") {
                taskVM.updateItem(task: taskModel, newTask: task)
                dismiss()
            }
        }
    }
    
    func addField() {
        textSubTasks.append("")
    }
    
    func removeField(at offsets: IndexSet) {
        textSubTasks.remove(atOffsets: offsets)
    }
}

#Preview {
    let tempTask = TaskModel(task: "Sample Task", isCompleted: false)
    
    return NavigationStack {
        UpdateView(taskVM: TaskViewModel(), taskModel: tempTask)
    }
}
