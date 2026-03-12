import SwiftUI

struct UpdateView: View {
    
    @ObservedObject var taskVM: TaskViewModel
    @Environment(\.dismiss) var dismiss
    
    var taskModel: TaskModel
    
    @State private var task: String
    @State private var subTasks: [SubTaskModel]
    
    init(taskVM: TaskViewModel, taskModel: TaskModel) {
        self.taskVM = taskVM
        self.taskModel = taskModel
        _task = State(initialValue: taskModel.task)
        _subTasks = State(initialValue: taskModel.subTasks)
    }
    
    var body: some View {
        Form {
            TextField("Update Task", text: $task)
                .frame(height: 55)
                .fontWeight(.semibold)
            Section("Sub Tasks") {
                ForEach($subTasks) { $subTask in
                        TextField("Subtask Name", text: $subTask.subTask)
                }
                .onDelete { indexSet in
                    subTasks.remove(atOffsets: indexSet)
                }
                Button(action: {
                    subTasks.append(SubTaskModel(subTask: "", isSubCompleted: false))
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Subtask")
                    }
                }
            }
        }
        .navigationTitle("Edit")
        .toolbar {
            Button("Update") {
                taskVM.updateItem(task: taskModel, newTask: task, newSubTasks: subTasks)
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
