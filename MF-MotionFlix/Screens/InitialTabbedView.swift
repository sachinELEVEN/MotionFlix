//
//  TabbedView.swift
//  MotionFlix
//
//  Created by sachin jeph on 17/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI
var userCurrentScreen = "Home"

struct InitialTabbedView : View {
  //  @EnvironmentObject var updateAllScreens : envClass
   // @State var selection = 0
     let updateAllScreens = envClass()//HomeScreen created here
    var Categories:[envClass]//WatchNow comes from sceneDelegate
    
    var body: some View {
   ZStack {
    TabView {
       
//Text("Google SignIn Unavailable")
      GoogleSignIn()
            .tabItem {
                VStack{
                    Image(systemName: "house.fill")
                    Text("Log in")
               } //.foregroundColor(selection==0 ? .pink : nil)
        }.tag(4)
        
        
        HomeScreen_1WillBeCalled(UpdateAllScreens:updateAllScreens)//.environmentObject(updateAllScreens)
                .tabItem {
                    VStack{
                        Image(systemName: "tv.fill")
                        Text("Watch Now")//only name changes Home -> Watch Now
                    } //.foregroundColor(selection==0 ? .pink : nil)
            }.tag(0)
                //.tapAction{self.selection = 0}
        
        //
        //HomeScreen_1().environmentObject(updateAllScreens)
        WatchNow(categories: Categories)//.environmentObject(self.category1)
            .tabItem {
                VStack{
                    Image(systemName: "suit.heart.fill")
                    Text("For You")//only name changes Watch Now -> For you
                } //.foregroundColor(selection==1 ? .pink : nil)
        }.tag(1)
        // .tapAction{self.selection = 1}
        
        //
     Search_WillBeCalled()
            .tabItem {
                VStack{
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                } //.foregroundColor(selection==2 ? .pink : nil)
        }.tag(2)
        // .tapAction{self.selection = 2}
        
        //
//        Settings()
//            .tabItem {
//                VStack{
//                    Image(systemName: "person.fill")
//                    Text("Settings")
//                } //.foregroundColor(selection==3 ? .pink : nil)
//        }.tag(3)
        
        
        FatSecret()
                   .tabItem {
                       VStack{
                           Image(systemName: "person.fill")
                           Text("Settings")
                       } //.foregroundColor(selection==3 ? .pink : nil)
               }.tag(5)
        // .tapAction{self.selection = 3}
        
        //
        
        }
        
        }
    }
}

