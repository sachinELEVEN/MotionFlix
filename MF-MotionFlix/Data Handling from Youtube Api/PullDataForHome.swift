//
//  PullDataFromYoutube.swift
//  MotionFlix
//
//  Created by sachin jeph on 16/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
 // let Api_Key = "AIzaSyBy8uxR8E0-NwRKRzpI3rdgggxPM63AnRk"
let Api_Key = "AIzaSyAYeg_abYosxReMx3u3D2j6qjlHVXnzVFQ"
//RDPkh8UtuejGw&start_radio=1&t=5


func pullDataFromYouTubeDataApi(updateAllScreens:envClass){
    
    
    
    /////////////
 //let playlistID = "PLFs4vir_WsTwEd-nJgVJCZPNL3HALHHpF"//in a nutshell
  // let playlistID = "PLBsP89CPrMeOA6Ypzvu4hfZigZIRBclY-"//MKBHD
 // let playlistID = "RDPkh8UtuejGw&start_radio=1&t=5"//songs
    //let playlistID = "UUE_M8A5yxnLfW0KghEeajjw"//apple
   // var name = "Apple"
    //To get the channel info
   // let urlString = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&forUsername=\(name)&key=\(Api_Key)"
    //to get playsist of the channel
    //Below will give the playlist of the channel
 /* EARLIER HomeURL
    let urlString = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playlistID)&key=\(Api_Key)"
  */
    let categoryId = 0
    let urlString = "https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&regionCode=in&videoCategoryId=\(categoryId)&key=\(Api_Key)"

    //Below gets channel details based on channel ids
 //   https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&id=SOME_ID_VALUE&key=\(apiKey)
    
    
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
           // print(jsonObj)
            if let Videos = jsonObj!["items"] as? [[String:AnyObject]]{
             
                for eachVideo in Videos{
                    //eachVideo (dictionary) has a snippet key field
                    //everyting useful is inside snippet
                    ///
                    var channelInfoHomeScreen :[String:Any] = ["channelPlaylistID":"","channelDesc":"","channelCountry":"","channelThumbnailUrl":"567"]//sorry for doing this as if now
                    //
                    //1
                    let channelID =  (eachVideo["snippet"]!["channelId"] as? String)! //used to fetch playList
                    //2
                    print("xyz ",channelID)
                    let channelName = ( eachVideo["snippet"]!["channelTitle"] as? String)!
                    //3
                  //  getChannelDetails_Home(channelID:channelID)//getting channel details by channel ID
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
                    
                  /*  if let eachVideoResourceID = eachVideo["snippet"]!["resourceId"] as? [String:AnyObject]
                    {
                        videoID = (eachVideoResourceID["videoId"] as? String)!
                    }*/
                    
                    if let id = eachVideo["id"] as? String
                                       {
                                           videoID = id
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
                       ///////
                        
                        DispatchQueue.main.async {
                            let   videoImage = UIImageView()
                          
                        videoImage.downloadImage(urlString: videoThumbnailUrl)
                           
            getChannelDetails_Home(channelID: channelID) { (infoChannel) in
                    channelInfoHomeScreen = infoChannel
           //     print("1",infoChannel["channelThumbnailUrl"])
           //     print("2",channelInfoHomeScreen["channelThumbnailUrl"])
                                                                           
                            
                        //A Single Video is loaded
                        var vid : VideoCell?

                            //  DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                       //     print("wwww",channelInfo["channelPlaylistID"])
                            //  print(videoDesc)
                              //  var    chImage = UIImageView()
                             //  if let   chImg =  channelInfoHomeScreen["channelImage"] as? UIImageView
                              // {  chImage = chImg}
                                //
                            vid = VideoCell(ChID:channelID,Chname:channelName, ChPlID: channelInfoHomeScreen["channelPlaylistID"]as! String, ChDesc: channelInfoHomeScreen["channelDesc"]as! String, ChCountry:channelInfoHomeScreen["channelCountry"]as! String,
                                            ChThUrl: channelInfoHomeScreen["channelThumbnailUrl"]as! String, ChImage:channelInfoHomeScreen["channelImg"] as! UIImageView,VidTitle:videoTitle,VidID:videoID,VidThUrl:videoThumbnailUrl,VidDesc:videoDesc,VidPubDate:videoPublishedDate,VidImage:videoImage)
                           
                         ////////////
                        if(vid != nil){updateAllScreens.currentVideos_1.append(vid!) }
                        vid = nil //removing reference but i think since its a local variable reference would be removed automatically but i am doing this since i am not sure about it
                        ////
                            //})
                        
                        }//completion handler
                        }//dispatch.que.main.async
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






 //completion hand. returns void
func getChannelDetails_Home(channelID:String,completion:@escaping (_ infoChannel :[String:Any])->()){
    //This will give us the channel details
    // let channelName1 = "TailosiveTech"
   // let ch = "UCzNq9i-DlDDBLjPerVzJW-A"//kenny sebastian channelID
    print("ChannelID ",channelID)
    let urlString = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&id=\(channelID)&key=\(Api_Key)"
   // let urlString = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&forUsername=\(channelName1)&key=\(Api_Key)"
 //    var channelInfo : [String:Any] = ["":""]
  //  DispatchQueue.main.sync  {
    
    //  let playlistID = "UUE_M8A5yxnLfW0KghEeajjw"
   
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
                    //eachVideo (dictionary) has a snippet key field
                    //everyting useful is inside snippet
                    //1//snippet->playlist ID
                    var channelPlaylistID = ""
                     var channelCountry = ""
                    if let eachVideoResourceID = eachVideo["contentDetails"]!["relatedPlaylists"] as? [String:AnyObject]
                    {//thumbnail resolution is 720X1280(HXW)
                        channelPlaylistID = (eachVideoResourceID["uploads"] as? String)!//channel recent playlist
                    }
                    
                    let channelDesc =  (eachVideo["snippet"]!["description"] as? String)! //used to fetch playList
                    //2
                if  let ch =  eachVideo["snippet"]!["country"] as? String
                {    channelCountry = ch  }
                    var channelThumbnailUrl = ""
                  
                    if let eachVideoResourceID = eachVideo["snippet"]!["thumbnails"] as? [String:AnyObject]
                    {//thumbnail resolution is 720X1280(HXW)
                        channelThumbnailUrl = (eachVideoResourceID["high"]!["url"] as? String)!
                        ///////
                      //   print("11",channelThumbnailUrl)
                       // DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {//
                        DispatchQueue.main.async {  //channelInfo
                       
                            let   channelImage = UIImageView()
                        channelImage.downloadImage(urlString: channelThumbnailUrl)
                           
                            //not downloaded the image
                        //    channelImage.downloadImage(urlString: channelThumbnailUrl)//
                            let  infoChannel : [String:Any]
                            infoChannel = ["channelDesc" : channelDesc,"channelCountry" : channelCountry,"channelThumbnailUrl" : channelThumbnailUrl,"channelPlaylistID":channelPlaylistID,"channelImg":channelImage] as [String : Any]
                             
                            //completion handler is called when all the above work is done
                            completion(infoChannel)
                         //   return channelInfo
                        //     print("22", channelThumbnailUrl)
                           
                            
                        }//})//
                      //  return channelInfo
                    }
                }
                
                
            }
        }catch let error {
            print(error)
        }
        
       //CompletionHandler(channelInfo)
       
    };task.resume()
  //  }

  // print("channel Info is",channelInfo)
   // return channelInfo
    
    
}

