//
//  PullSubscriptions.swift
//  MotionFlix
//
//  Created by sachin jeph on 18/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import UIKit

/*

 */
func PullSubscriptions(subscriptions : envClass3){
 
    //   let playlistID = "PLBsP89CPrMeOA6Ypzvu4hfZigZIRBclY-"//MKBHD
  //  let subscriptionsUrl = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playlistID)&key=\(Api_Key)"
    //let subscriptionsUrl = "https://developers.google.com/apis-explorer/#p/youtube/v3/youtube.subscriptions.list?part=snippet,contentDetails&mine=true"
// let subscriptionsUrl = "https://www.googleapis.com/youtube/v3/subscriptions?part=snippet&mine=true&key=\(Api_Key)"
   // print(Token id)
  //  print("acces token is")?access_token=oauth2-token
    //print(accesToken)
   
    
    //below thing is working correctly //Requires user authentication
    ///////////////////
 // let subscriptionsUrl = "https://www.googleapis.com/youtube/v3/channels?part=snippet&mine=true&access_token=\(accesToken)"
  //////////////////////
    print(accesToken)
     let subscriptionsUrl = "https://www.googleapis.com/youtube/v3/subscriptions?part=snippet,contentDetails&mine=true&access_token=\(accesToken)"
   
    
    let url = URL(string: subscriptionsUrl)
    let request = URLRequest(url: url!)
    // request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request) { (data, resonse, error) in
        if error != nil {
            print("An error is encountered - \(error!) ")
            return
        }
        
        do {
       
            let jsonObj = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:AnyObject]
           // print(jsonObj)
            
             if let channels = jsonObj!["items"] as? [[String:AnyObject]]{
               
                for channel in channels{
                    
                    /////////Data members
                    var channelID : String?
                    var channelName : String?
                    var channelDesc : String?
                    var channelThumbnailUrl : String?
                    var ChannelrecentVideosCount : String?
                //    var channelImage : UIImageView?
                    ///
                    
                   //channelID
                    if let resourceID = channel["snippet"]!["resourceId"] as? [String:AnyObject]
                    {
                        if let   ChID = resourceID["channelId"] as?  String{//Actual Channel ID not any plalist ID
                            channelID = ChID//required channel ID
                        }
                    }
                    
              //channelName
                    if let name = channel["snippet"]!["title"] as? String{
                        channelName = name
                    }
                    
                    //channelDesc
                    if let desc = channel["snippet"]!["description"] as? String{
                        channelDesc = desc
                    }
                    
                    //Channel recent videos (last 7 days)
                    if let count = channel["contentDetails"]!["totalItemCount"] as? String{
                        ChannelrecentVideosCount = count
                    }
                    
                    //Channel thumbnail
                    if let thumbnailUrl = channel["snippet"]!["thumbnails"] as? [String:AnyObject]
                    {
                        if let   url = thumbnailUrl["high"]!["url"] as?  String{
                            channelThumbnailUrl = url//required channel ID
                         //   DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {

                       DispatchQueue.main.async {
                            let channelImage = UIImageView()
                            channelImage.downloadImage(urlString: url)
                  //      print("chanel name is ",channelName)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                        var ChannelL : ChannelCell?
                             ChannelL = ChannelCell(ChID: channelID, Chname: channelName, ChDesc: channelDesc, ChCountry: "US", ChThUrl: channelThumbnailUrl,chRVC : ChannelrecentVideosCount ,ChImage: channelImage)
                        if(ChannelL != nil){
                            subscriptions.Subscribedchannels.append(ChannelL!)
                            ChannelL = nil
                        }})
                        
                            }//})
                            
                        }
                    }
                
                }
            
            }
            
            
        
        }catch let error {
            print(error)
           
        }
        
        
        
    };task.resume()
    
    

}



//GET https://www.googleapis.com/youtube/v3/subscriptions?part=snippet&mine=true&key=[YOUR_API_KEY] HTTP/1.1

//Authorization: Bearer [YOUR_ACCESS_TOKEN]
//Accept: application/json

