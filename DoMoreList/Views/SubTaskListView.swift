import SwiftUI

struct SubTaskListView: View {
    
    let subTask: SubTaskModel
    
    var body: some View {
        HStack {
            Image(systemName: subTask.isSubCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(subTask.isSubCompleted ? .green : .red)
            
            Text(subTask.subTask)
            Spacer()
        }
        .font(.title3)
        .padding(.leading, 30)
        .padding(.top, 5)
        .strikethrough(subTask.isSubCompleted, color: .gray)
        .foregroundColor(subTask.isSubCompleted ? .secondary : .primary)
    }
}

#Preview {
    SubTaskListView(subTask: SubTaskModel(subTask: "My Sub Task", isSubCompleted: false))
}
