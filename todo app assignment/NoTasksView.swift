//
//  NoTasksView.swift
//  todo app assignment
//
//  Created by shreenidhi vm on 13/11/23.
//

import SwiftUI

struct NoTasksView: View {
    var body: some View {
           
               
           Image("illustration-no1")
             .renderingMode(.template)
             .resizable()
             .scaledToFit()
             .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
       }
   }


#Preview {
    NoTasksView()
}
