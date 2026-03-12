import SwiftUI

struct TaskListView: View {
    
    let task: TaskModel
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(task.isCompleted ? .green : .red)
            Text(task.task)
                .font(.title)
                .fontWeight(.semibold)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 5)
        .strikethrough(task.isCompleted, color: .gray)
        .foregroundColor(task.isCompleted ? .secondary : .primary)
    }
}

#Preview {
    TaskListView(task: TaskModel(task: "My Task", isCompleted: false))
}
