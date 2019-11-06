//
//  UserDataModel.swift
//  MotionFlix
//
//  Created by sachin jeph on 16/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
var user = userDataModel()
class userDataModel{
   // var favouriteVideos = [String]()//Video ids
 //   var favouriteCreator = [String]()
  //  var favouriteCategories = [String]()
  
   // var ff = ["dsf","dvfc","dxv"]
    var favouriteTopics : [String] = []//Set<String>()
    var favouriteTopicList :[String] = []
    var country = "us"
    func addFavTopics(topicID:String,topic:String){//[weak self]
      
        if !self.favouriteTopics.contains(topicID){
           self.favouriteTopicList.append(topic)
            self.favouriteTopics.append(topicID)
        }else{
            /*
            self.favouriteTopics.removeAll { (str) -> Bool in
                       str == topicID
                   }*/
            
            //As pf now when tabbed view is pressed previous state of data is maintained so user.fvourt.count hasnt still been updated
            //So Reflect these changes the next time the app opens
        }
     
    }
    
    func getFavTopicsCount()->Int{
        print("AAAAAA")
        return self.favouriteTopics.count
    }
    
    
   
}
