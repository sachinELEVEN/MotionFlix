//
//  VideoDataModel.swift
//  MotionFlix
//
//  Created by sachin jeph on 16/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

//var currentVideos_1 = [VideoCell]()

class envClass : ObservableObject{
  //  var willChange = PassthroughSubject<Void, Never>()
    
  @Published  var currentVideos_1 = [VideoCell]()
    
}

class senvClass : ObservableObject{
   // var willChange = PassthroughSubject<Void, Never>()
    
@Published  var superSetAA = [envClass]()
    
}




//This Class object should be used only to playlist. That is when you have playlist url
class envClass2 : ObservableObject{
   // var willChange = PassthroughSubject<Void, Never>()
    
@Published  var channelPlaylist_v = [VideoCell]()
    
}





class VideoCell:Identifiable,ObservableObject  {
  //   var willChange = PassthroughSubject<Void, Never>()
@Published var image = UIImageView()
    
    
    
    var channelID : String
    var channelName : String
    var channelPlaylistID : String
    var channelDesc : String
    var channelCountry : String?
    var channelThumbnailUrl :String
    var channelImage : UIImageView
    
    var videoTitle : String
    var videoID : String
    var videoThumbnailUrl: String
    var videoDesc : String
    var videoPublishedDate : String
   
    //user congiguratioins
    var liked = false
    var disliked = false
    
    init(ChID:String,Chname:String,ChPlID:String,ChDesc:String,ChCountry:String,ChThUrl:String,ChImage:UIImageView,VidTitle:String,VidID:String,VidThUrl:String,VidDesc:String,VidPubDate:String, VidImage:UIImageView){
        
        self.channelID = ChID
         self.channelName = Chname
         self.channelPlaylistID = ChPlID
        self.channelDesc = ChDesc
        self.channelCountry = ChCountry
        self.channelThumbnailUrl = ChThUrl
        self.channelImage = ChImage
        
        self.videoTitle = VidTitle
         self.videoID = VidID
        self.videoThumbnailUrl = VidThUrl
        self.videoDesc = VidDesc
        self.videoPublishedDate = VidPubDate
        self.image = VidImage
        
       
    }
}



    func DummyDataUpdate(updateAllScreens:envClass){
    updateAllScreens.currentVideos_1.swapAt(0, 0)
}
