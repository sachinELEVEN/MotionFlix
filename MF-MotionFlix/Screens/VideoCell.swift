//
//  VideoCell.swift
//  MotionFlix
//
//  Created by sachin jeph on 17/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI

struct VideoCellLayout : View {
    var eachVideo : VideoCell
    var extraData : UIImageView?
    var largeFontSize : Bool = true
    var body: some View {
        VStack(alignment:.leading){
            
            //  ImageShow() &&self.eachVideo.channelImage.image != nil
           // if(eachVideo.image.image != nil){
                ZStack(alignment:.bottomTrailing){
                 //video thumbnail
                   if(eachVideo.image.image != nil){
                   VStack(alignment:.center) {
                    Image(uiImage: eachVideo.image.image!)
                        .renderingMode(.original)
                        //This shlould work but its not working
                        .resizable()
                        .scaledToFit()
                    
                       // .frame(width:largeFontSize ? 350:200,height:largeFontSize ? 350/1.77:200/1.77)
             
                        
                    
                    
                    }
                    }
                    //channel Image

                      if(self.eachVideo.channelImage.image != nil){
                    Image(uiImage: self.eachVideo.channelImage.image!)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width:40,height:40)
                        .clipShape(Circle())
                      }
                    
                    
                     if(self.extraData != nil){
                   // if(let channelImage = extraData as? UIImageView)
                     Image(uiImage:extraData!.image!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width:40,height:40)
                            .clipShape(Circle())
                    
                        }
                    
                    
                }            // VStack(alignment:.leading){
            
            Text(eachVideo.videoTitle)
                .fontWeight(.bold)
                .lineLimit(3)
                .font(largeFontSize ? .title : .headline)
                .multilineTextAlignment(.leading)
              //  .padding(.horizontal)
            .padding(largeFontSize ? .bottom : .bottom,0)
            
            Text(eachVideo.channelName)
                .lineLimit(1)
                .font(largeFontSize ? .headline : .caption)
                .foregroundColor(.secondary)
               // .padding(.horizontal)
            
            Text(eachVideo.videoPublishedDate.dropLast(14))
                .lineLimit(1)
                 .font(largeFontSize ? .headline : .caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
               // .padding(.horizontal)
                .padding(largeFontSize ? .bottom : .bottom,0)
            
            //  }
            
            
        }.foregroundColor(.primary)
        

        
    }
}

//123
