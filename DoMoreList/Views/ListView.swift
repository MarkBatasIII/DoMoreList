import SwiftUI

struct ListView: View {
    
    @StateObject var taskVM = TaskViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                    ForEach(taskVM.tasks) { task in
                        GroupBox {
                            NavigationLink(destination: UpdateView(taskVM: taskVM, taskModel: task)) {
                                TaskListView(task: task)
                                    .onTapGesture {
                                        withAnimation(.linear) {
                                            taskVM.updateTaskCompleted(task: task)
                                        }
                                    }
                                Image(systemName: "pencil")
                                    .font(.title3)
                                    .foregroundStyle(.blue)
                                
                            }
                            if !task.subTasks.isEmpty {
                                DisclosureGroup("\(task.subTasks.count) \(Image(systemName: "rectangle.3.group"))") {
                                    ForEach(task.subTasks) { subTask in
                                        SubTaskListView(subTask: subTask)
                                            .listRowInsets(EdgeInsets())
                                            .onTapGesture {
                                                withAnimation(.linear) {
                                                    taskVM.updateSubTaskCompleted(task: task, subTask: subTask)
                                                }
                                            }
                                    }
                                }
                                .padding(.leading, 28)
                                .padding(.trailing, 7)
                                .font(.subheadline)
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: taskVM.deleteItem)
                    .onMove(perform: taskVM.moveItem)
            }
            .listStyle(.plain)
            .navigationTitle("Do More")
            .scrollBounceBehavior(.basedOnSize)
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
