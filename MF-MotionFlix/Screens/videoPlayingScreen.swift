//
//  videoPlayingScreen.swift
//  MotionFlix
//
//  Created by sachin jeph on 16/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI
import UIKit
import AVKit

struct videoPlayingScreen : View {
    var Video : VideoCell
    @State var refresh = false
    @State var showDescription = false
    @State var channelSubscribed = false
          let channelPlaylist = envClass2()
            
    
    var body: some View {
   NavigationView{
    ScrollView(.vertical){  VStack{
              
               // ZStack{
                  
                   
//                    Image(uiImage: Video.image.image!)
//                    .resizable()
//                    .scaledToFill()
//                     //   .frame(width:.r)
//                        .frame(height:fullHeight*0.8)
                    Text(Video.videoTitle)
                              .fontWeight(.bold)
                              .lineLimit(nil)
                              .font(.title)
                                .padding()
               
                HStack{
                    Spacer()
                Text("Published on")
                  .fontWeight(.regular)
                    .foregroundColor(.secondary)
                .font(.subheadline)
                
                Text(Video.videoPublishedDate.dropLast(14))
                  .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                 .font(.subheadline)
                 .padding(.trailing)
                }
                    
             //   VStack    {
                ZStack{
                   // HStack{
                    //    Spacer()
                        
                    Image(uiImage: Video.image.image!)
                                            .renderingMode(.original)
                                            .resizable()
                                          // .scaledToFit()
                   
                        
                    
                    
                    vv(VideoID:Video.videoID).edgesIgnoringSafeArea(.all)//web embedded player        //
                        .onTapGesture{print("tapped")}
                  .frame(width:200, height:200)
                        .opacity(0.03)
                    
                  //     Spacer()
                //    }
                    
                    
                    // gg(VidoeID: Video.videoID).edgesIgnoringSafeArea(.all)//Native player
                        
                 //   Text("Video Player")
              //      }
        //  Text("Tap To Play")
                }
                    .padding()
//                    Image(systemName:"play.fill")
//                        .resizable()
//                        .frame(width:100,height:100)
//                        .foregroundColor(.gray)
                
               // }//  onlyPlayer()//PLAYS VIDEO from videoURL
                   // Spacer()
          //  PlayerContainerView(player: AVPlayer(url: URL(string:song )!))
                
                
              
                
              //  ScrollView(.vertical){

           
           //     .onAppear{self.Video.channelImage.downloadImage(urlString: self.Video.channelThumbnailUrl)
            //        print("Downloading")
              //      }
                          
                    
               // .frame(height:200)
                    
                    HStack{
                        

                        if( Video.channelImage.image != nil){
                                
                                NavigationLink(destination:AboutChannel(Video: Video).environmentObject(channelPlaylist)){
                              Image(uiImage:  Video.channelImage.image!)//this
                                     .renderingMode(.original)
                                    .resizable()
                                    .frame(width:60,height:60)
                                    .clipShape(Circle())
                            }
                        }
                        
                        Text(Video.channelName)
                            .fontWeight(.bold)
                            .foregroundColor(channelSubscribed ? .primary : .secondary)
                            .lineLimit(nil)
                            .font(.title)
                            .padding(.horizontal)
                            //.padding()
                            .background(channelSubscribed ? Color.red : nil)
                        .cornerRadius(20)
                            .onTapGesture{//favourite the channel
////later make changes to user data model whether this creator is their favourite or not//subscribed or not
                            self.channelSubscribed.toggle()
                       }
                
    }.padding()
                        
                      
                        
                        HStack{
//                            Button(action:{self.showDescription.toggle()}){
//                                Image(systemName: self.showDescription ?  "square.on.square.fill": "square.on.square")
//                                    .resizable()
//                                    .frame(width:40,height:40)
//                                    .foregroundColor(.red)
//
//                            }
                            
                            
                               Button(action:{self.addToLikedVideo()}){
                                   Text(Video.liked ?  "Liked": "Like")
                                     .fontWeight(.bold)
                                       .font(.headline)
                            .padding(.horizontal)
                                       .background(Video.liked ? Color.red : nil)
                                    .cornerRadius(20)
                                       .foregroundColor(.primary)
                               }

                            
                            Spacer()
                          
                            
                          
                            
                            
                      
 
//                            Button(action:{self.showDescription.toggle()}){
//                                Image(systemName: self.showDescription ?  "square.on.square.fill": "square.on.square")
//                                    .resizable()
//                                    .frame(width:40,height:40)
//                                    .foregroundColor(.red)
//                            }
//
//
                            Spacer()
                            
                            Button(action:{self.addToDislikedVideo()}){
                                Text(Video.disliked ?  "Disliked": "Dislike")
                                  .fontWeight(.bold)
                                    .font(.headline)
                         .padding(.horizontal)
                                    .background(Video.disliked ? Color.red : nil)
                                    .cornerRadius(20)
                                    .foregroundColor(.primary)
                            }
                            
                          
                        }.padding()
                        //.foregroundColor(.)
                        
                   // }
                
                
                   // if(showDescription){
                        Text(Video.videoDesc)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                            .font(.headline)
                         .padding()
                        
                    
                    
                    
       
     //       }//.navigationBarTitle(Text(Video.videoTitle), displayMode: .inline)
               
                
                if(refresh){Text("Refreshing")}
    }}//.background(Color.pink.opacity(0.5).blur(radius: 5))
       //.background(Color.black)
                // .background(Color.primary.opacity(0.1))
                
        .navigationBarTitle(Text(Video.channelName),displayMode:.inline)
    //.navigationBarHidden(true)
       // .navigationBarHidden(true)
        
                
        // .navigationBarHidden(true)
       
 }
        
    }
    
    
    func addToLikedVideo(){
       refresh.toggle();
        Video.liked.toggle()
        if(Video.liked){ Video.disliked = false}
      //  refresh.toggle()
    }
    func addToDislikedVideo(){
         refresh.toggle();
          Video.disliked.toggle()
         if(Video.disliked){ Video.liked = false}
       //   refresh.toggle()
      }
    
}

struct  onlyPlayer:View{
    var body:some View{
        // PlayerContainerView(player: AVPlayer(url: URL(string:song )!))
        Text("This code has been commented")
    }
}
