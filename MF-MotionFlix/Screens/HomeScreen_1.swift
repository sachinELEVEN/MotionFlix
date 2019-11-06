//
//  ContentView.swift
//  MotionFlix
//
//  Created by sachin jeph on 16/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI
//import WebKit
 
var fullWidth = UIScreen.main.bounds.width
var fullHeight = UIScreen.main.bounds.height

var videoInHome : VideoCell?
var videoInSearch : VideoCell?

var watchNowLoaded = true
struct HomeScreen_1WillBeCalled:View {
//  let updateAllScreens = envClass()
  //  var  channelPlaylist = envClass2()
    var UpdateAllScreens : envClass 
    
    
    var body : some View{
        
        VStack{
            Text("Nice").frame(width:0,height:0).onAppear{
                if(self.UpdateAllScreens.currentVideos_1.count==0){
                    //To Pull Data for HomeScreen
                    pullDataFromYouTubeDataApi(updateAllScreens:self.UpdateAllScreens)//
                    
                }
            }.onAppear{ userCurrentScreen = "Home"
                print("Screen",userCurrentScreen)
            }
          
               HomeScreen_1().environmentObject(self.UpdateAllScreens)
        
        }
    }
}



struct HomeScreen_1 : View {
    @State var nowDate: Date = Date()
    @State private var showVideo = false
    @State var videoToBePlayed = ""
    @EnvironmentObject var updateAllScreen : envClass
@State  var counter = 0
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {timer in
            self.nowDate = Date()
           // print(self.counter)
            if(self.counter>30){timer.invalidate()};self.counter += 1
          //  print("1")
        }}
  
    
    var body: some View {
        ZStack(alignment:.bottom){
        NavigationView{
            ScrollView{
            VStack{
                
                ForEach(updateAllScreen.currentVideos_1,id:\.videoID){eachVideo in
                   // NavigationLink(destination:videoPlayingScreen(Video:eachVideo)){
                    Button(action:{self.startPlayingVideo(Video:eachVideo)}){
                  
                  //  VideoCellLayout(eachVideo: eachVideo)
                            VideoCellLayout(eachVideo: eachVideo)//
                             .padding(.bottom)
                        
                       //  .navigationBarHidden(true)
//                        .navigationBarItems(trailing:Text("Refresh").tapAction {
//                            DummyDataUpdate(updateAllScreens:self.updateAllScreen)
//                            }
//
//
//                    )
                    
                    }
                } //.listRowInsets(EdgeInsets())
                
              }.foregroundColor(.primary)
            }  .navigationBarTitle("Watch Now")
               
        }//.blur(radius:showVideo ? 10 : 0)
          //  .background(showVideo ? Color.secondary : nil)
        
        ///
            ///Tabbed View
            
            ///
        
            .sheet(isPresented: $showVideo){ videoPlayingScreen(Video:videoInHome!)}
           // if(showVideo){
//                ZStack(alignment:.bottom){
//                    //  presentation(Modal( videoPlayingScreen(Video:channelPlaylist.channelPlaylist_v[0])))
//                    videoPlayingScreen(Video:updateAllScreen.currentVideos_1[0])
//                       // .background(Color.red)
//                     //.background(Color.pink.opacity(0.5).blur(radius: 5))
//
//                    Image(systemName: "chevron.down")
//                        .resizable()
//                        .frame(width:50,height:20)
//                        .foregroundColor(.primary)
//                        .padding()
//                        .tapAction{self.showVideo = false}
//
//
//
//                }//.background(Color.primary.colorInvert().opacity(0.1))
//                    //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//               .frame(width:fullWidth,height:fullHeight*0.85)
//                 // .background(Color.primary.opacity(0.8))
//                    .transition(.move(edge: .bottom))
//                    .animation(.spring())
//                //                    .cornerRadius(fullWidth/20)
//                //                    .padding()
//
//            }
//
           
            
         //   you can use this tabbed view to later display currently playing video
//            TabbedView {
//                Text("Hello, World")
//                    .tabItem {
//                        VStack{
//                            Image(systemName: "tv.fill")
//                            Text("Watch Now")
//                        }
//                }.tag(0)
//            }

        
                    }//.background(showVideo ? Color.primary:nil)
        
        
    }
    
    func startPlayingVideo(Video:VideoCell){
        
        videoInHome = Video
        showVideo = true
    }
    
    func search(){
        
    }
}

struct Temp: View{
    
    var body:some View{
        
        Text("Search")
        
    }
        
}



//saved
