import SwiftUI

struct CreateView: View {
    
    @State private var textFieldCreate = ""
    
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
            Button("Create") { }
        }
    }
}

#Preview {
    NavigationStack {
        CreateView()
    }
}
