import SwiftUI

struct CreateView: View {

    @ObservedObject var taskVM: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var textFieldCreate = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("What do you want to do?", text: $textFieldCreate)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
            }
            .padding(14)
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
