import SwiftUI

struct TaskListView: View {
    
    let task: TaskModel
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(task.isCompleted ? .green : .red)
            Text(task.task)
                .fontWeight(.semibold)
            Spacer()
        }
        .font(.headline)
        .strikethrough(task.isCompleted, color: .gray)
        .foregroundColor(task.isCompleted ? .secondary : .primary)
    }
}

#Preview {
    TaskListView(task: TaskModel(task: "My Task", isCompleted: false))
}
