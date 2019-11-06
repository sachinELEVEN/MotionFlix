//
//  PullSearchData.swift
//  MotionFlix
//
//  Created by sachin jeph on 20/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
//search results is a playlist
/*
 {
    "kind": "youtube#searchResult",
    "etag": "\"Bdx4f4ps3xCOOo1WZ91nTLkRZ_c/btNh_4SeeUD9HTZToNu-bTVmEa4\"",
    "id": {
     "kind": "youtube#video",
     "videoId": "rie69P0W668"
    },
    "snippet": {
     "publishedAt": "2019-07-17T02:11:05.000Z",
     "channelId": "UCBJycsmduvYEL83R_U4JriQ",
     "title": "The iPhone 11 Models!",
     "description": "iPhone 11? iPhone XI? Either way. Tick tock tock. iPhone models from: https://twitter.com/SonnyDickson MKBHD Merch: http://shop.MKBHD.com Video Gear I ...",
     "thumbnails": {
      "default": {
       "url": "https://i.ytimg.com/vi/rie69P0W668/default.jpg",
       "width": 120,
       "height": 90
      },
      "medium": {
       "url": "https://i.ytimg.com/vi/rie69P0W668/mqdefault.jpg",
       "width": 320,
       "height": 180
      },
      "high": {
       "url": "https://i.ytimg.com/vi/rie69P0W668/hqdefault.jpg",
       "width": 480,
       "height": 360
      }
     },
     "channelTitle": "Marques Brownlee",
     "liveBroadcastContent": "none"
    }
   },
 */


//searchType can be playlist or videos or channels
var searchNextPageToken = ""
func pullSearchData(seachedText:String,searchType:String,searchResults:envClass){
    if(searchNextPageToken == "Complete"){return }
    
    let searchUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&pageToken=\(searchNextPageToken)&q=\(seachedText)&type=\(searchType)&key=\(Api_Key)"

    
    /////////////
 //let playlistID = "PLFs4vir_WsTwEd-nJgVJCZPNL3HALHHpF"//in a nutshell
 //  let playlistID = "PLBsP89CPrMeOA6Ypzvu4hfZigZIRBclY-"//MKBHD//
 // let playlistID = "RDPkh8UtuejGw&start_radio=1&t=5"//songs
    //let playlistID = "UUE_M8A5yxnLfW0KghEeajjw"//apple
   // var name = "Apple"
    //To get the channel info
   // let urlString = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&forUsername=\(name)&key=\(Api_Key)"
    //to get playsist of the channel
    //Below will give the playlist of the channel
//   let urlString = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playlistID)&key=\(Api_Key)"//

    //Below gets channel details based on channel ids
 //   https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&id=SOME_ID_VALUE&key=\(apiKey)
    
    
    ////////
    
    let url = URL(string: searchUrl)
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
            if  let token = jsonObj!["nextPageToken"] as? String{
                searchNextPageToken = token
            }else{searchNextPageToken = "Complete"}
            if let Videos = jsonObj!["items"] as? [[String:AnyObject]]{
             
                for eachVideo in Videos{
                    //eachVideo (dictionary) has a snippet key field
                    //everyting useful is inside snippet
                    ///
                    var channelInfoSearch :[String:Any] = ["channelPlaylistID":"","channelDesc":"","channelCountry":"","channelThumbnailUrl":"567"]//sorry for doing this as if now
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
                    
                    if let eachVideoResourceID = eachVideo["id"] as? [String:AnyObject]
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
                       ///////
                        
                        DispatchQueue.main.async {
                            let   videoImage = UIImageView()
                          
                        videoImage.downloadImage(urlString: videoThumbnailUrl)
                           
            getChannelDetails_Search(channelID: channelID) { (infoChannel) in
                    channelInfoSearch = infoChannel
             //   print("1",infoChannel["channelThumbnailUrl"])
             //   print("2",channelInfoSearch["channelThumbnailUrl"])
                                                                           
                            
                        //A Single Video is loaded
                        var vid : VideoCell?

                            //  DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                       //     print("wwww",channelInfo["channelPlaylistID"])
                            //  print(videoDesc)
                              //  var    chImage = UIImageView()
                             //  if let   chImg =  channelInfoHomeScreen["channelImage"] as? UIImageView
                              // {  chImage = chImg}
                                //
                            vid = VideoCell(ChID:channelID,Chname:channelName, ChPlID: channelInfoSearch["channelPlaylistID"]as! String, ChDesc: channelInfoSearch["channelDesc"]as! String, ChCountry:channelInfoSearch["channelCountry"]as! String,
                                            ChThUrl: channelInfoSearch["channelThumbnailUrl"]as! String, ChImage:channelInfoSearch["channelImg"] as! UIImageView,VidTitle:videoTitle,VidID:videoID,VidThUrl:videoThumbnailUrl,VidDesc:videoDesc,VidPubDate:videoPublishedDate,VidImage:videoImage)
                           
                         ////////////
                        if(vid != nil){searchResults.currentVideos_1.append(vid!) }
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
func getChannelDetails_Search(channelID:String,completion:@escaping (_ infoChannel :[String:Any])->()){
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

