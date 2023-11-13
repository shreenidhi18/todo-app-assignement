//
//  EditViewTaskView.swift
//  todo app assignment
//
//  Created by shreenidhi vm on 13/11/23.
//

import SwiftUI

struct EditView: View {
    @AppStorage("Tasks") var tasksData:Data?
    
    @Binding var tasks:[String]
    
    @Environment(\.dismiss) var dismiss
    @State var newTask:String = ""
    @Binding var isEditTaskViewShowing:Bool
    var showButton:Bool {newTask.isEmpty}
    @Binding var indexToBePassed:Int
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
                        tasks[indexToBePassed] = newTask
                        
                        do {
                            tasksData = try PropertyListEncoder().encode(tasks)
                            
                        }catch {
                            print("Error encoding while editing task")
                        }
                        isEditTaskViewShowing = false
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
            .navigationTitle("Edit your existing task")
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
//    EditView()
//}
