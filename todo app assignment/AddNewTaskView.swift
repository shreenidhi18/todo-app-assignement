//
//  AddNewTaskView.swift
//  todo app assignment
//
//  Created by shreenidhi vm on 13/11/23.
//

import SwiftUI

struct AddNewTaskView: View {
    @AppStorage("Tasks") var tasksData:Data?
    @AppStorage("Completions") var completionData:Data?
    @Binding var tasks:[String]
    @Binding var completion:[Bool]
    @Environment(\.dismiss) var dismiss
    @State var newTask:String = ""
    @Binding var isAddNewTaskViewShowing:Bool 
    var showButton:Bool {newTask.isEmpty}
    @Binding var nightMode:Bool

    
    
    var body: some View {
        NavigationView {
            VStack {
                //vstack 2 start
                VStack(alignment: .leading, spacing: 20) {
                    
                    TextField("New task", text: $newTask)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                    
                    
                    
                    Button {
                        tasks.append(newTask)
                        completion.append(false)
                        do {
                            tasksData = try PropertyListEncoder().encode(tasks)
                            completionData = try PropertyListEncoder().encode(completion)
                        }catch {
                            print("Error encoding while adding new task")
                        }
                        isAddNewTaskViewShowing = false
                        dismiss()
                          
                                                
                        
                    } 
                    
                label: {
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(showButton ? Color.gray : Color.black)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                            
                            
                    }
                .disabled(showButton)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 30)
            }
            .navigationTitle("Add a new task")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(nightMode ? .white : .black)
                    }
                }
            }
        }
    }
}


//#Preview {
//    AddNewTaskView(tasks: ["task"], completion: [false])
//}
