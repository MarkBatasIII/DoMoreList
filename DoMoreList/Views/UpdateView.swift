import SwiftUI

struct UpdateView: View {
    
    @ObservedObject var taskVM: TaskViewModel
    @Environment(\.dismiss) var dismiss
    
    var taskModel: TaskModel
    @State private var task: String
    
    
    init(taskVM: TaskViewModel, taskModel: TaskModel) {
        self.taskVM = taskVM
        self.taskModel = taskModel
        _task = State(initialValue: taskModel.task)
    }
    
    var body: some View {
        Form {
            VStack {
                TextField("Update Task", text: $task)
                    .frame(height: 55)
                    .fontWeight(.semibold)
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
}

#Preview {
    let tempTask = TaskModel(task: "Sample Task", isCompleted: false)
    
    return NavigationStack {
        UpdateView(taskVM: TaskViewModel(), taskModel: tempTask)
    }
}
