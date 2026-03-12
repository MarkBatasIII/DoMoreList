import SwiftUI

struct ListView: View {
    
    @StateObject var taskVM = TaskViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(taskVM.tasks) { task in
                    NavigationLink(destination: UpdateView(taskVM: taskVM, taskModel: task)) {
                        TaskListView(task: task)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    taskVM.updateTaskCompleted(task: task)
                                }
                            }
                    }
                    if !task.subTasks.isEmpty {
                        VStack {
                            DisclosureGroup("You have \(task.subTasks.count) sub task\(task.subTasks.count > 1 ? "s" : "")") {
                                ForEach(task.subTasks) { subTask in
                                    SubTaskListView(subTask: subTask)
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                                taskVM.updateSubTaskCompleted(task: task, subTask: subTask)
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: taskVM.deleteItem)
                .onMove(perform: taskVM.moveItem)
            }
            .navigationTitle("Do More List")
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                if !taskVM.tasks.isEmpty {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink(destination: CreateView(taskVM: taskVM)) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .overlay(alignment: .center) {
                if taskVM.tasks.isEmpty {
                    ContentUnavailableView(label: {
                        Label("Empty List", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding things to see your list.")
                    }, actions: {
                        NavigationLink(destination: CreateView(taskVM: taskVM)
                        ) {
                            Text("Create")
                                .font(.headline)
                        }
                    })
                    .offset(y: -50)
                    .transition(AnyTransition.opacity.animation(.easeIn))
                }
            }
        }
    }
}

#Preview {
    ListView()
}
