//
//  PullDataFroScreenChannelInfo.swift
//  MotionFlix
//
//  Created by sachin jeph on 17/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import SwiftUI



func pullDataForChannelInfo(channelPlaylist:envClass2,playlistID:String){
    
    
    
    /////////////
    //let playlistID1 = "UCQSpnDG3YsFNf5-qHocF-WQ"
    
   // let playlistID1 = "UUE_M8A5yxnLfW0KghEeajjw"
    print("This is the ",playlistID)
  //  let playlistID = "UUE_M8A5yxnLfW0KghEeajjw"
    // var name = "Apple"
    //To get the channel info
    // let urlString = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&forUsername=\(name)&key=\(Api_Key)"
    //to get playsist of the channel
    let urlString = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playlistID)&key=\(Api_Key)"
    
    
    
   
    ////////
    
    let url = URL(string: urlString)
    let request = URLRequest(url: url!)
    // request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request) { (data, resonse, error) in
        if error != nil {
            print("An error is encountered - \(error!) ")
            return
        }
        
        do {
            //trying to convert json object into a dictionary
            let jsonObj = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:AnyObject]
            //   print(jsonObj)
            if let Videos = jsonObj!["items"] as? [[String:AnyObject]]{
                
                for eachVideo in Videos{
                    //eachVideo (dictionary) has a snippet key field
                    //everyting useful is inside snippet
                    //1
                    let channelID =  (eachVideo["snippet"]!["channelId"] as? String)! //used to fetch playList
                    //2
                    let channelName = ( eachVideo["snippet"]!["channelTitle"] as? String)!
                    //3
                //    getChannelDetails(channelName:channelName)
                   
                    //  channelDes
                    //  channelThumbnail
                    
                    //5
                    let videoTitle =  (eachVideo["snippet"]!["title"] as? String)!
                    //6
                    var videoID : String = "Error"
                    var  videoThumbnailUrl :String = "Error"
                    //7
                    let videoDesc =  (eachVideo["snippet"]!["description"] as? String)!
                    //8
                    let videoPublishedDate =  (eachVideo["snippet"]!["publishedAt"] as? String)!
                    
                    if let eachVideoResourceID = eachVideo["snippet"]!["resourceId"] as? [String:AnyObject]
                    {
                        videoID = (eachVideoResourceID["videoId"] as? String)!
                    }
                    
                    if let eachVideoResourceID = eachVideo["snippet"]!["thumbnails"] as? [String:AnyObject]
                    {//thumbnail resolution is 720X1280(HXW)
                        if let maxres = eachVideoResourceID["maxres"]  as? [String:AnyObject]{
                             videoThumbnailUrl = maxres["url"] as! String
                        }
                        
                        else{
                            if let high = eachVideoResourceID["high"]  as? [String:AnyObject]{
                                                       videoThumbnailUrl = high["url"] as! String
                                                  }
                        }
                        //videoThumbnailUrl = (eachVideoResourceID["maxres"]!["url"] as? String)!
                        ///////
                        
                        DispatchQueue.main.async {
                            let   videoImage = UIImageView()
                            videoImage.downloadImage(urlString: videoThumbnailUrl)
                            let FakeImageView = UIImageView()
                            let channelInfo = ["channelPlaylistID":playlistID,"channelDesc":"nil","channelCountry":"nil","channelThumbnailUrl":"nil"
                                ,"channelImage" :FakeImageView
                                
                                ] as [String : Any]
                            var vid : VideoCell?
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                               
                                vid = VideoCell(ChID:channelID,Chname:channelName, ChPlID: channelInfo["channelPlaylistID"]as! String, ChDesc: channelInfo["channelDesc"]as! String, ChCountry:channelInfo["channelCountry"]as! String,
                                                ChThUrl: channelInfo["channelThumbnailUrl"]as! String, ChImage:  channelInfo["channelImage"]as! UIImageView,VidTitle:videoTitle,VidID:videoID,VidThUrl:videoThumbnailUrl,VidDesc:videoDesc,VidPubDate:videoPublishedDate,VidImage:videoImage)
                                
                                ////////////
                                if(vid != nil){channelPlaylist.channelPlaylist_v.append(vid!) }
                                vid = nil //removing reference but i think since its a local variable reference would be removed automatically but i am doing this since i am not sure about it
                                ////
                            })
                        }
                    }
                    
                    
                    
                    
                    //             DummyDataUpdate(updateAllScreens: updateAllScreens)
                    
                }
                
                
            }
            
            
            
            
            //     DummyDataUpdate(updateAllScreens: updateAllScreens)
            
            
        }catch let error {
            print(error)
        }
        
        
        
    };task.resume()
    
    
    
    
    
    
}
