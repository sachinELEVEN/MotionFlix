//
//  ChannelDataModel.swift
//  MotionFlix
//
//  Created by sachin jeph on 18/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class envClass3 : ObservableObject{
  //  var willChange = PassthroughSubject<Void, Never>()
    
   @Published var Subscribedchannels = [ChannelCell]()
    
}


class ChannelCell:Identifiable,ObservableObject  {
    //var willChange = PassthroughSubject<Void, Never>()
    @Published var channelImage = UIImageView()
    
    
    //This is a channelID not a any playlistID of the channel
    var channelID : String?
    var channelName : String?
    //var channelPlaylistID : String
    var channelDesc : String?
    var channelCountry : String?
    var channelThumbnailUrl :String?
    var channelRecentVideosCoun : String?
   // var channelImage : UIImageView?
    
   
    //user congiguratioins
   // var subscribed = false
    
    
    init(ChID:String?,Chname:String?,ChDesc:String?,ChCountry:String?,ChThUrl:String?,chRVC:String?,ChImage:UIImageView)
    {
        
        self.channelID = ChID//this may not be the channel ID but may be the uploads playlist ID
        self.channelName = Chname
        self.channelDesc = ChDesc
        self.channelCountry = ChCountry
        self.channelThumbnailUrl = ChThUrl
        self.channelRecentVideosCoun = chRVC
        self.channelImage = ChImage
      
        
    }
}
