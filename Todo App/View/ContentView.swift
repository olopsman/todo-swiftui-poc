//
//  ContentView.swift
//  Todo App
//
//  Created by Paulo Orquillo on 29/04/21.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    
    //fetching the entities and adding a sorting
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: Body
    var body: some View {
        NavigationView {
            ZStack {
                List{
                    ForEach(self.todos, id:\.self){ todo in
                        HStack {
                            Text(todo.name ?? "Unknown")
                            Spacer()
                            Text(todo.priority ?? "Unknown")
                        }
                    }
                    .onDelete(perform: deleteTodo)
                } //:List
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                        Button(action: {
                            self.showingAddTodoView.toggle()
                        }){
                            Image(systemName: "plus")
                        }.sheet(isPresented: $showingAddTodoView, content: {
                            AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                        })
                )
                // MARK: no todo items
                if todos.count == 0 {
                    EmptyListView()
                }
            }//: ZStack
        }//:Navigation
    }
    
    // MARK: Functions
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
    }
}
