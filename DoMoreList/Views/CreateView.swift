import SwiftUI

struct CreateView: View {

    @ObservedObject var taskVM: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var textFieldCreate = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        Form {
            TextField("Task Name", text: $textFieldCreate)
                .frame(height: 55)
                .fontWeight(.semibold)
        }
        .navigationTitle("Create Task")
        .toolbar {
            Button("Save") {
                if checkInput() {
                    taskVM.addItem(task: textFieldCreate)
                    dismiss()
                }
            }
        }
        .alert("Invalid Input", isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    func checkInput() -> Bool {
        if(textFieldCreate.count < 3) {
            errorMessage = "Text is too short."
            showingError = true
            return false
        }
        return true
    }
}

#Preview {
    NavigationStack {
        CreateView(taskVM: TaskViewModel())
    }
}
