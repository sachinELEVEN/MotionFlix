//
//  Trending.swift
//  MotionFlix
//
//  Created by sachin jeph on 19/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//
import SwiftUI






struct TrendingScreen : View {
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
        //ZStack(alignment:.bottom){
     //   NavigationView{
            ScrollView(.horizontal,showsIndicators: false){
            HStack{
                
                ForEach(trending.currentVideos_1,id:\.videoID){eachVideo in
                   // NavigationLink(destination:videoPlayingScreen(Video:eachVideo)){
                    //Text(eachVideo.videoTitle)
                    Button(action:withAnimation{{self.startPlayingVideo(Video:eachVideo)}}){//
                  
                    VStack{
                        VideoCellLayout(eachVideo: eachVideo,largeFontSize:false).frame(width:350,height:350)
                        
                   
                    }
                    
                  }//
                } //.listRowInsets(EdgeInsets())
                
              }.foregroundColor(.primary)
            } // .navigationBarTitle("Home")
               
  
                //    }//.background(showVideo ? Color.primary:nil)
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


