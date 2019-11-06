//
//  UserTopicSelection.swift
//  MotionFlix
//
//  Created by sachin jeph on 21/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI
/*
 :2 -  Autos & Vehicles
 :1 -  Film & Animation
 :10 - Music
 :15 - Pets & Animals
 :17 - Sports
 :18 - Short Movies
 :19 - Travel & Events
 :20 - Gaming
 :21 - Videoblogging
 :22 - People & Blogs
 :23 - Comedy
 :24 - Entertainment
 :25 - News & Politics
 :26 - Howto & Style
 :27 - Education
 :28 - Science & Technology
 :29 - Nonprofits & Activism
 :30 - Movies
 :31 - Anime/Animation
 :32 - Action/Adventure
 :33 - Classics
 :34 - Comedy
 :35 - Documentary
 :36 - Drama
 :37 - Family
 :38 - Foreign
 :39 - Horror
 :40 - Sci-Fi/Fantasy
 :41 - Thriller
 :42 - Shorts
 :43 - Shows
 :44 - Trailers
 */
/*

 
 
 
 
 
 */

struct UserTopicSelection: View {
    @State var refresh = false
    var topicsCategory : [String] =//set should not b used here because ForEach requires to identify each element and in [String] its simply done by index
    ["Automobiles",
    "Film & Animation",
    "Music",
    "Pets & Animals",
    "Sports",
    //"Short Movies",
    "Travel & Events",
    "Gaming",
    //"Videoblogging",
    "People & Blogs",
    "Entertainment",
    "News & Politics",
    "Howto & Style",
   // "Education",
    "Science & Technology",
    "Nonprofits & Activism",
    //"Movies",
    //"Anime/Animation",
   // "Action/Adventure",
    //"Classics",
    "Comedy"
   // "Documentary",
   // "Drama",
   // "Family",
   // "Foreign",
   // "Horror",
   // "Sci-Fi/Fantasy",
   // "Thriller",
   // "Shorts",
   // "Shows",
   // "Trailers"
    ]
    //var topicCategoryDict = ["Autos" :2]
    
  
    
    //@State var refresh = false
    
   
    var body: some View {
        NavigationView{
            ScrollView(.vertical,showsIndicators:false){
                VStack{
                    if(refresh){ Text("s").frame(width:0,height:0)}
                    
                    ForEach(topicsCategory,id:\.self){topic in
        
                        DisplayTopicList(topic: topic, refresh: self.$refresh)

                       // Text("Nice")
                           }
                    
                
                }}.navigationBarTitle(user.favouriteTopicList.count==14 ?  Text("Swipe Down to Dismiss"): Text("Tap to Add"))
                .navigationBarItems(trailing: Text("Print").onTapGesture {
                    for i in user.favouriteTopicList{
                        print(i)
                    }
                })
               
        }
    }
    
   
}




struct DisplayTopicList : View {
    var topic : String
    @Binding var refresh : Bool
    var topicCategoryDict = ["Automobiles" :2 ,
          "Film & Animation":1 ,
          "Music":10,
          "Pets & Animals":15,
          "Sports":17,
         // "Short Movies":18,
          "Travel & Events":19,
          "Gaming":20,
         // "Videoblogging":21,
          "People & Blogs":22,
          "Entertainment":24,
          "News & Politics":25,
          "Howto & Style":26,
        //  "Education":27,
          "Science & Technology":28,
          "Nonprofits & Activism":29,
         // "Movies":30,
         // "Anime/Animation":31,
         // "Action/Adventure":32,
        //  "Classics":33,
          "Comedy":23
       //   "Documentary":35,
       //   "Drama":36,
       //   "Family":37,
       //   "Foreign":38,
       //   "Horror":39,
       //   "Sci-Fi/Fantasy":40,
       //   "Thriller":41,
       //   "Shorts":42,
       //   "Shows":43,
       //   "Trailers":44
      ]
    var body: some View{
   VStack {
       if(!user.favouriteTopicList.contains(topic)){
           VStack{
               Text(topic)
                   .fontWeight(.bold)
                   .font(.title)
                   .frame(height:50)
                   .padding(.horizontal)
                   .background(Color.pink)
                   .cornerRadius(20)
                .onTapGesture{withAnimation{self.addToUserFavouriteTopics(Topic:self.topic)}}
                }//}
            }
        }
   }
    
    func addToUserFavouriteTopics(Topic : String){
           let topicID = topicCategoryDict[Topic]
        //adding to user
       //    print("rr",topicID)
           user.addFavTopics(topicID:String(topicID!),topic:Topic)
          self.refresh.toggle()
           
       }
   
}
