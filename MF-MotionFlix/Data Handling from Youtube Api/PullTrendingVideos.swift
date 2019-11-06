//
//  PullTrendingVideos.swift
//  MotionFlix
//
//  Created by sachin jeph on 19/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//


//GET https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&regionCode=in&key=[YOUR_API_KEY] HTTP/1.1

//Authorization: Bearer [YOUR_ACCESS_TOKEN]
//Accept: application/json


import Foundation
import UIKit
import SwiftUI





func pullTrending(trending:envClass){
    
    
    
    /////////////
 //let playlistID = "PLFs4vir_WsTwEd-nJgVJCZPNL3HALHHpF"//in a nutshell
  // let playlistID = "PLBsP89CPrMeOA6Ypzvu4hfZigZIRBclY-"//MKBHD
    //let playlistID = "UUE_M8A5yxnLfW0KghEeajjw"//apple
   // var name = "Apple"
    //To get the channel info
   // let urlString = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&forUsername=\(name)&key=\(Api_Key)"
    //to get playsist of the channel
    //Below will give the playlist of the channel
   let urlString = "https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&regionCode=in&key=\(Api_Key)"

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
         //   print(jsonObj)
            if let Videos = jsonObj!["items"] as? [[String:AnyObject]]{
             
                for eachVideo in Videos{
                    //eachVideo (dictionary) has a snippet key field
                    //everyting useful is inside snippet
                    //1
                    var channelInfoTrending :[String:Any] = ["channelPlaylistID":"","channelDesc":"","channelCountry":"","channelThumbnailUrl":"1234"]//sorry for doing this as if now
                    
                    
                    let channelID =  (eachVideo["snippet"]!["channelId"] as? String)! //used to fetch playList
                    //2
                    print("xyz ",channelID)
                    let channelName = ( eachVideo["snippet"]!["channelTitle"] as? String)!
                    //3
               //     getChannelDetails_Trending(channelID:channelID,trending:trending)//getting channel details by channel ID
                          //  channelDes
                          //  channelThumbnail
                  //  let   channelImage : UIImageView?
                    ///
                  
                   // getChannelDetails_Home(channelID: channelID){imageView in
                      
                 //   }
                    
                    
            ////////
                    
                    //5
                    let videoTitle =  (eachVideo["snippet"]!["title"] as? String)!
                    //6
                    var videoID : String = "Error"
                    var  videoThumbnailUrl :String = "Error"
                    //7
                    let videoDesc =  (eachVideo["snippet"]!["description"] as? String)!
                    //8
                    let videoPublishedDate =  (eachVideo["snippet"]!["publishedAt"] as? String)!
                    
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
                     print("Broke 1")
                
                          
               //    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
                 //           if  let channelThumbnailUrl = channelInfoTrending["channelThumbnailUrl"] as? String
                //  {print(channelThumbnailUrl)
                  //  print("Broke 2")
                 //     print("ch ",channelInfoTrending["channelThumbnailUrl"])
                //    channelImage.downloadImage(urlString: channelThumbnailUrl)}})
                                         //  print("Broke 3")         ///   "channelImage" : channelImage,
                            
                            
                        //A Single Video is loaded
                            getChannelDetails_Trending(channelID: channelID) { (infoChannel) in
                                                  channelInfoTrending = infoChannel
                                               //   print("1",infoChannel["channelThumbnailUrl"])
                                               //   print("2",channelInfoTrending["channelThumbnailUrl"])
                                              
                                              ///
                            
                        var vid : VideoCell?

                         //     DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                       //     print("wwww",channelInfo["channelPlaylistID"])
                            //  print(videoDesc)
                             //   var    chImage = UIImageView()
                             //  if let   chImg =  channelInfoTrending["channelImage"] as? UIImageView
                              // {  chImage = chImg}
                                print("VideoID ",videoID)
                                //
                            vid = VideoCell(ChID:channelID,Chname:channelName, ChPlID: channelInfoTrending["channelPlaylistID"]as! String, ChDesc: channelInfoTrending["channelDesc"]as! String, ChCountry:channelInfoTrending["channelCountry"]as! String,
                                            ChThUrl: channelInfoTrending["channelThumbnailUrl"]as! String, ChImage:channelInfoTrending["channelImg"] as!UIImageView,VidTitle:videoTitle,VidID:videoID,VidThUrl:videoThumbnailUrl,VidDesc:videoDesc,VidPubDate:videoPublishedDate,VidImage:videoImage)
                            //    Vid.chan
                                //downloading image to object
                               // DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                                    //vid?.channelImage.downloadImage(urlString: vid!.channelThumbnailUrl)
                                     //  print("yes")
                                    // print("YY ",vid?.channelThumbnailUrl)
                               // })
                               
                           
                         ////////////
                              
                                
                        if(vid != nil){
                            trending.currentVideos_1.append(vid!)
                           vid = nil
                                }}
                            
                       // vid = nil //removing reference but i think since its a local variable reference would be removed automatically but i am doing this since i am not sure about it
                        ////
                          //  })
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


 var gameTimer: Timer?

extension UIImageView{
    func downloadImage(urlString:String){
        
        let url = URL(string: urlString)
       // print("Downloading Image")
        //print(url)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request){(data,response,error) in
            if error != nil{
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image =  UIImage(data: data!)
              
            }
       
          
        };task.resume()
       //   DispatchQueue.main.async { DummyDataUpdate(updateAllScreens:updateAllScreens)}
    }
    
}
                                                            //infoChannel is the input in completion handler and the completion hand. returns void
func getChannelDetails_Trending(channelID:String,completion:@escaping (_ infoChannel :[String:Any])->()){
    //This will give us the channel details
    // let channelName1 = "TailosiveTech"
   // let ch = "UCzNq9i-DlDDBLjPerVzJW-A"//kenny sebastian channelID
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
//Get this done
