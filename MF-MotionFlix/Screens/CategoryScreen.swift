//
//  Category1Videos.swift
//  MotionFlix
//
//  Created by sachin jeph on 20/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI


struct categoryScreen_WillBeCalled:View{
    let category :envClass
    let id:String
    let index:Int
//    @EnvironmentObject var categories: senvClass
  //   @EnvironmentObject var category : envClass
    var body :some View{
    VStack{
        Text("").frame(width:0,height:0).onAppear{
            print("RR",self.id)
            print(self.index)
            print("PP",user.favouriteTopics.count)
            if(self.category.currentVideos_1.count==0){ print("Loading");
                pullCategoryVideos(category:self.category, categoryId:self.id )}
            else{print("Already Loaded")}
            
        }
       CategoryScreen().environmentObject(self.category)
    }
    }
}


struct CategoryScreen : View {
    @State var nowDate: Date = Date()
    @State var showVideo = false
   // var showVideo : Binding<Bool>
   // @State var videoToBePlayed = ""
  
    @EnvironmentObject var trending : envClass
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
     //   NavigationView{
            ScrollView(.horizontal,showsIndicators: false){
            HStack{
                
                ForEach(trending.currentVideos_1,id:\.videoID){eachVideo in
                   // NavigationLink(destination:videoPlayingScreen(Video:eachVideo)){
                    //Text(eachVideo.videoTitle)
                    Button(action:withAnimation{{self.startPlayingVideo(Video:eachVideo)}}){//
                  
                    VStack{  VideoCellLayout(eachVideo: eachVideo,largeFontSize: false)//
                       
                    }.frame(width:200,height:230)
                    // .frame(width:fullWidth - 50,height:350)
                       //  .navigationBarHidden(true)
//                        .navigationBarItems(trailing:Text("Refresh").tapAction {
//                            DummyDataUpdate(updateAllScreens:self.updateAllScreen)
//                            }
//
//
//                    )
                    
                    }//
                } //.listRowInsets(EdgeInsets())
                
              }.foregroundColor(.primary)
            } // .navigationBarTitle("Home")
               
       // }.blur(radius:showVideo ? 10 : 0)
          //  .background(showVideo ? Color.secondary : nil)
        
        ///
            ///Tabbed View
            
            ///
        
            
//            if(showVideo){
//                ZStack(alignment:.bottom){
//                    //  presentation(Modal( videoPlayingScreen(Video:channelPlaylist.channelPlaylist_v[0])))
//                    videoPlayingScreen(Video:trending.currentVideos_1[0])
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
       // .sheet(isPresented: $showVideo){ videoPlayingScreen(Video:self.trending.currentVideos_1[0])}//
      //  since in watchNow screen at a time only one video can play we can keep this .sheet in watchNow view

        //  .sheet(isPresented: $showVideo){ videoPlayingScreen(Video:self.trending.currentVideos_1[0])}
        
    }
 //   var videoInWatchNow : VideoCell?

    func startPlayingVideo(Video:VideoCell){
    videoInWatchNow = nil
       // videoToBePlayedInWatchNow = VideoID
        videoInWatchNow = Video
        showVideo = true
    }
    
    func search(){
        
    }
}


