import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    HStack {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                        Text("List")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .font(.title2)
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Things to-do")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CreateView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ListView()
}
