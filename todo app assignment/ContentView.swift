//
//  ContentView.swift
//  todo app assignment
//
//  Created by shreenidhi vm on 13/11/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("Tasks") var tasksData:Data?
    @AppStorage("Completions") var completionData:Data?
    @AppStorage("DarkMode") var darkMode:Bool?
    @State var nightMode:Bool = false
    @State var showEditView:Bool = false
    @State var tasks:[String] = []
    @State var completion:[Bool] = []
    @State var isAddNewTaskViewShowing:Bool = false
    @State var isEditTaskViewShowing:Bool = false
    @State var indexToBePassed:Int = 0
    var body: some View {
        NavigationStack {
            if tasks.isEmpty {
                withAnimation{
                    NoTasksView()
                }
                    .navigationTitle("To-Do")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack{
                                Button {
                                    
                                }label: {
                                    EditButton()
                                        .foregroundStyle(nightMode ? Color.white : Color.black)
                                        .font(.system(size: 18,weight: .semibold,design: .rounded))
                                        .background(Capsule().stroke(nightMode ? Color.white : Color.black,lineWidth:2).frame(width: 90,height: 30))
                                        .padding()
                                }
                                Button {
                                    nightMode.toggle()
                                    darkMode = nightMode
                                } label: {
                                    Image(systemName:nightMode ? "moon.circle.fill" : "moon.circle")
                                        .foregroundStyle(nightMode ? Color.white : Color.black)
                                        .font(.system(size: 22))
                                        .padding(.leading,10)
                                }
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button {
                                isAddNewTaskViewShowing.toggle()
                            }label: {
                                ZStack {
                                    Circle()
                                        .foregroundStyle(nightMode ? Color.white : Color.black)
                                        .frame(width: 60,height: 90)
                                    Image(systemName: "plus")
                                        .foregroundStyle(nightMode ? Color.black : Color.white)
                                        .bold()
                                }
                                
                            }
                        }
                    }
            }else{
                VStack{
                    List{
                        ForEach(tasks.indices,id: \.self) { index in
                            VStack{
                                HStack {
                                    Image(systemName: completion[index] ? "checkmark.circle.fill" : "checkmark.circle")
                                        
                                        .font(.system(size: 26))
                                        .onTapGesture {
                                            
                                                completion[index].toggle()
                                            do {
                                                completionData = try PropertyListEncoder().encode(completion)
                                            }catch {
                                                print("Error while encoding the completions")
                                            }
                                            
                                        }
                                    Text(tasks[index])
                                    Spacer()
                                    Button {
                                        indexToBePassed = index
                                        isEditTaskViewShowing.toggle()

                                    }label: {
                                        Image(systemName:"chevron.right")
                                            .foregroundStyle(.black)
                                    }
                                }
                                .font(.system(size: 20))
                                .padding(.vertical,4)
                            }
                            
                                
                        }
                        .onDelete(perform: { indexSet in
                            tasks.remove(atOffsets: indexSet)
                            completion.remove(atOffsets: indexSet)
                        })
                    }
                }
                .navigationTitle("To-Do")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack{
                            Button {
                                
                            }label: {
                                EditButton()
                                    .foregroundStyle(nightMode ? Color.white : Color.black)
                                    .font(.system(size: 18,weight: .semibold,design: .rounded))
                                    .background(Capsule().stroke(nightMode ? Color.white : Color.black,lineWidth:2).frame(width: 90,height: 30))
                                    .padding()
                            }
                            Button {
                                nightMode.toggle()
                                darkMode = nightMode
                            } label: {
                                Image(systemName:nightMode ? "moon.circle.fill" : "moon.circle")
                                    .foregroundStyle(nightMode ? Color.white : Color.black)
                                    .font(.system(size: 22))
                                    .padding(.leading,10)
                            }
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            isAddNewTaskViewShowing.toggle()
                        }label: {
                            ZStack {
                                Circle()
                                    .foregroundStyle(nightMode ? Color.white : Color.black)
                                    .frame(width: 60,height: 90)
                                Image(systemName: "plus")
                                    .foregroundStyle(nightMode ? Color.black : Color.white)
                                    .bold()
                            }
                            
                        }
                    }
                }
            }

            
        }
        .preferredColorScheme(nightMode ? .dark : .light)
        .sheet(isPresented: $isEditTaskViewShowing, content: {
            EditView(tasks: $tasks, isEditTaskViewShowing: $isEditTaskViewShowing, indexToBePassed: $indexToBePassed, nightMode: $nightMode)
        })
        .sheet(isPresented: $isAddNewTaskViewShowing, content: {
            AddNewTaskView(tasks: $tasks, completion: $completion, isAddNewTaskViewShowing: $isAddNewTaskViewShowing, nightMode: $nightMode)
                
            
        })
        .onAppear {
            do {
                tasks = try PropertyListDecoder().decode([String].self, from:tasksData ?? Data())
                completion = try PropertyListDecoder().decode([Bool].self, from:completionData ?? Data())
                nightMode = darkMode ?? false
            }catch {
                print("Error Decoding")
            }
        }
    }
        
}

#Preview {
    ContentView()
}
