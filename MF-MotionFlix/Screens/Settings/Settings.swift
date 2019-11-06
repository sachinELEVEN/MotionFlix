//
//  Settings.swift
//  MotionFlix
//
//  Created by sachin jeph on 21/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @State var showTopics = false
    var body: some View {
        NavigationView{
            Form{
                Section(header:Text("Configuration")){
                    Text("For You").onTapGesture{self.showTopics.toggle()}
                    
                }
            }.navigationBarTitle(Text("Settings"))
            
           
            
                .sheet(isPresented: $showTopics){UserTopicSelection()}
        }
    }
}

