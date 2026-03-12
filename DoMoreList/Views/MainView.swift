import SwiftUI

struct MainView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .tag(0)
            ListView()
                .tabItem {
                    Label("List", systemImage: "square.and.pencil")
                }
                .tag(1)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(2)
        }
    }
}

#Preview {
    MainView()
}
