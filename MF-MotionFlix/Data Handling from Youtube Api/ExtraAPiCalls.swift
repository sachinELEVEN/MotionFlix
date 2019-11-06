//
//  ExtraAPiCalls.swift
//  MotionFlix
//
//  Created by sachin jeph on 18/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//
import Foundation
 var channelPlaylistIDForWatchNow = ""

func getChannelUploadPlaylistID (channelID:String)
{
   
    let urlString = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&id=\(channelID)&key=\(Api_Key)"
    
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
            //  print(jsonObj)
            if let Videos = jsonObj!["items"] as? [[String:AnyObject]]{
                
                for eachVideo in Videos{
                   // var channelPlaylistID = ""
                    
                    if let eachVideoResourceID = eachVideo["contentDetails"]!["relatedPlaylists"] as? [String:AnyObject]
                    {//thumbnail resolution is 720X1280(HXW)
                        channelPlaylistIDForWatchNow = (eachVideoResourceID["uploads"] as? String)!//channel recent playlist
                       
                    }
                   //  return channelPlaylistID
                    
                }
                
                
            }
        }catch let error {
            print(error)
        }
        
       
        
    };task.resume()
   
    
    
}


func getVideoUrlFromVideoID(VideoID:String){
    
  //  let videoID1 = ""
let str = "https://www.googleapis.com/youtube/v3/videos?id=\(VideoID)&key=\(Api_Key)&part=player"
    print("Video id is ",VideoID)
    let url = URL(string: str)
    let request = URLRequest(url: url!)
    // request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request) { (data, resonse, error) in
        if error != nil {
            print("An error is encountered - \(error!) ")
            return
        }
        
        do {
            //trying to convert json object into a dictionary
            let _ = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:AnyObject]
           // print(jsonObj)
//            if let Videos = jsonObj!["items"] as? [[String:AnyObject]]{
//
//                for eachVideo in Videos{
//                    // var channelPlaylistID = ""
//
//                    if let eachVideoResourceID = eachVideo["contentDetails"]!["relatedPlaylists"] as? [String:AnyObject]
//                    {//thumbnail resolution is 720X1280(HXW)
//                        channelPlaylistIDForWatchNow = (eachVideoResourceID["uploads"] as? String)!//channel recent playlist
//
//                    }
//                    //  return channelPlaylistID
//
//                }
//
//
//            }
        }catch let error {
            print(error)
        }
        
        
        
    };task.resume()
    
    
    
}
