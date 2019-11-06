//
//  AboutChannel_General.swift
//  MotionFlix
//
//  Created by sachin jeph on 18/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//


import SwiftUI
//This

struct AbouChannel_GeneralWillBeCalled:View {
    var Channel : ChannelCell
     var  channelPlaylist = envClass2()//Recieves a channel playlist that will be displayed
    
    var body : some View{
        
        AboutChannel_General(Channel: Channel).environmentObject(channelPlaylist)
    }
}

struct AboutChannel_General : View {
    var Channel : ChannelCell
    @State var showVideo = false
    @State var videoToBePlayed = ""
   
    @EnvironmentObject var channelPlaylist : envClass2
   // @State var refresh = false
    var body: some View {
        
        ZStack(alignment:.bottom){
            
            VStack(alignment:.leading){
                ScrollView(.vertical){
                    
                    
                    HStack{
                    Text("About Channel")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .padding([.horizontal])
                        .padding(.top,-15)
                    Spacer()
                }
                    
                    ///
                    channelInfoSection1_General(Channel:self.Channel).environmentObject(channelPlaylist)
                    
                    ///
                   // VStack(alignment:.leading)
                   HStack { Text("Recents")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .padding([.top,.horizontal])
                        .padding(.bottom,10)
                    Spacer()
                    }
                    
                    
                    VStack{
                        
                        ForEach(channelPlaylist.channelPlaylist_v,id:\.videoID){eachVideo in
        
                            // NavigationLink(destination:videoPlayingScreen(Video:eachVideo)){
                          //  Button(action:withAnimation{{self.startPlayingVideo(Video:eachVideo)}}){
                                VideoCellLayout(eachVideo: eachVideo,extraData:self.Channel.channelImage)
                                    .onTapGesture{self.startPlayingVideo(Video:eachVideo)}
                          //  }
                        }.padding(.bottom)
                        
                        
                        
                        
                        // }.foregroundColor(.primary)
                        
                        /////
                        
                        
                    }
                    
                }//.background(Color.primary.opacity(0.1))
            }//.blur(radius:showVideo ? 10 : 0)
            // .navigationBarHidden(showVideo ? true : false)
            ///
            //video PLaying screen
.sheet(isPresented: $showVideo){
               if(userCurrentScreen=="WatchNow"){
               videoPlayingScreen(Video:videoInWatchNow!)
               }
               
              else if(userCurrentScreen=="Home"){
                             videoPlayingScreen(Video:videoInHome!)
                             }
               if(userCurrentScreen=="Search"){
                             videoPlayingScreen(Video:videoInSearch!)
                             }
           }//            if(showVideo){
//                ZStack(alignment:.bottom){
//                    //  presentation(Modal( videoPlayingScreen(Video:channelPlaylist.channelPlaylist_v[0])))
//                    videoPlayingScreen(Video:channelPlaylist.channelPlaylist_v[0])//Needs to be changed
//                        .background(Color.primary.colorInvert())
//
//
//                    Image(systemName: "chevron.down")
//                        .resizable()
//                        .frame(width:50,height:20)
//                        .foregroundColor(.primary)
//                        .padding()
//                        .tapAction{self.showVideo = false}
//                        .offset(x: 0, y: -80)
//
//
//                }
//                .relativeSize(width: 1, height: 1)
//                    // .frame(width:fullWidth,height:10)
//                    .transition(.move(edge: .bottom))
//                    .animation(.spring())
//                //                    .cornerRadius(fullWidth/20)
//                //                    .padding()
//
//            }
            
           
            
        }.navigationBarTitle(Text(""),displayMode: .large)
           
            .navigationBarHidden(showVideo ? true : false)
        
    }
    
       func startPlayingVideo(Video:VideoCell){
    if(userCurrentScreen=="WatchNow")
    {videoInWatchNow = Video}
    else if(userCurrentScreen=="Home"){videoInHome = Video}
    else if(userCurrentScreen=="Search"){videoInSearch = Video}
       
            showVideo = true
   }


}

struct channelInfoSection1_General:View{
    var Channel : ChannelCell
    @EnvironmentObject var channelPlaylist : envClass2
    var body:some View{
        
        VStack{
            Image(uiImage: Channel.channelImage.image!)
                .resizable()
                .frame(width:100,height:100)
                .clipShape(Circle())
                
                .overlay(
                    Circle().stroke(Color.primary.opacity(0.1), lineWidth: 4))
                .shadow(radius: 10)
                .padding()
                
                        .onAppear{
                            if(true)//self.channelPlaylist.channelPlaylist_v.count==0 //to update as of now you have to reopen app
                            {
                                
                                 getChannelUploadPlaylistID(channelID: self.Channel.channelID!)
                                 DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                                //   getChannelUploadPlaylistID(channelID: self.Channel.channelID!)
                                print("Playlist 123 is ",channelPlaylistIDForWatchNow)
                                pullDataForChannelInfo(channelPlaylist:self.channelPlaylist,playlistID:channelPlaylistIDForWatchNow);
                                //channelPlaylist is the container in which data is getting filled from server
                                    print("Channel Videos Loading")})}//else{print("already loaded")}
                    }
                    

         
            
            
            Text(Channel.channelName!)
                .fontWeight(.bold)
                .font(.title)
         
            HStack{
                
                Text("Subscribers")
                    .fontWeight(.bold)
                    .font(.headline)
                
                Spacer()
                Text(Channel.channelCountry! )
                    .fontWeight(.bold)
                    .font(.headline)
                
                
                
            }.padding()
            
            VStack(alignment:.leading){
                Text("About")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                
                
                Text(Channel.channelDesc!)
                    .fontWeight(.semibold)
                    .lineLimit(nil)
                    .font(.subheadline)
                    .frame(height:200)
                    .padding([.horizontal,.bottom])
                
                
            }
            
            
        }.background(Color.secondary.opacity(0.1))
            .cornerRadius(20)
            .padding()
    }
}


/*
 ScrollView(.vertical){
 
 
 VStack{
 Image(uiImage: Video.channelImage.image!)
 .resizable()
 .frame(width:100,height:100)
 .clipShape(Circle())
 
 .overlay(
 Circle().stroke(Color.primary.opacity(0.1), lineWidth: 4))
 .shadow(radius: 10)
 .padding()
 .onAppear{
 if(self.channelPlaylist.channelPlaylist_v.count==0)
 {pullDataForChannelInfo(channelPlaylist:self.channelPlaylist,playlistID:self.Video.channelPlaylistID);
 print("Channel Videos Loading")}else{print("already loaded")}
 
 }
 
 
 Text(Video.channelName)
 .fontWeight(.bold)
 .font(.title)
 
 HStack{
 
 Text("Subscribers")
 .fontWeight(.bold)
 .font(.headline)
 Spacer()
 Text(Video.channelCountry)
 .fontWeight(.bold)
 .font(.headline)
 
 
 
 }.padding()
 
 VStack(alignment:.leading){
 Text("About")
 .fontWeight(.bold)
 .font(.title)
 .padding()
 
 
 Text(Video.channelDesc)
 .fontWeight(.semibold)
 .lineLimit(nil)
 .font(.subheadline)
 .frame(height:200)
 .padding([.horizontal,.bottom])
 
 
 }
 
 
 }.background(Color.secondary.opacity(0.1))
 .cornerRadius(20)
 .padding()
 ////
 
 // VideosBelowChannelInfo()
 
 //   VStack {
 
 ForEach(channelPlaylist.channelPlaylist_v.identified(by: \.videoID)){eachVideo in
 //NavigationLink(destination:videoPlayingScreen(Video:eachVideo)){
 Button(action:{self.startPlayingVideo(VideoID:eachVideo.videoID)}){
 VStack{
 
 //  ImageShow()
 if(eachVideo.image.image != nil){
 Image(uiImage: eachVideo.image.image!)
 .renderingMode(.original)
 .resizable()
 .scaledToFit()
 
 
 
 //.padding()
 
 }
 
 
 Text(eachVideo.videoTitle)
 .fontWeight(.bold)
 .lineLimit(nil)
 .font(.headline)
 
 .padding()
 
 
 
 }.foregroundColor(.primary)
 
 
 
 }
 }
 
 
 
 
 // }.foregroundColor(.primary)
 
 /////
 
 
 }
 
 */
//123

