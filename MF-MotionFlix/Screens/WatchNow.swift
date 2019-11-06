//
//  WatchNow.swift
//  MotionFlix
//
//  Created by sachin jeph on 18/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//
var val = 0
import SwiftUI

 var videoToBePlayedInWatchNow = ""
  var videoInWatchNow : VideoCell?
 var category1 = [envClass](repeating:envClass(),count:30)//they are all stored in the same memory location,which is not what we want 
//WHEN VIEW  IS TAPPED SECOND TIME,AND SO ON ONLY "ONAPPEAR" FUNCTION ARE CALLED
struct WatchNow : View {
    let subscriptions = envClass3()//contains subscriptions 
     let trending = envClass()//contains trending
    @State var refresh = false
   // let category = envClass() //[envClass](repeating:envClass(),count:3)//contains category 1 videos
  // var  categories = [envClass](repeating: envClass(), count: 30)//
    var categories : [envClass]
  //  var  categories = senvClass()
  //count:user.favouriteTopics.count
 var  gradientColor1 = Color.primary.opacity(0.0)//favouriteTopics
    var gradientColor2 = Color.secondary.opacity(0.2)
  
     @State var showVideo = false

    
    var body: some View {
         NavigationView{
    ScrollView(.vertical){
        
        VStack(alignment:.leading) {
          
             
           
              if(refresh){Text("").frame(width:0,height:0)}
            Text("For You")
                .fontWeight(.black)
                .font(.largeTitle)
                .padding()
                .onTapGesture{ self.refresh.toggle()}
        .onAppear{
            
            userCurrentScreen = "WatchNow"
            print("Screen",userCurrentScreen)
            
            if(self.subscriptions.Subscribedchannels.count==0){ print("pulling subscriptions")
                PullSubscriptions(subscriptions : self.subscriptions)//
            
            }
            //Pulling trending
            if(self.trending.currentVideos_1.count==0){
            pullTrending(trending:self.trending)////
            }
         //   pullCategoryVideos(category:self.category, categoryId:"10" )//

            
    }
        
             Divider().padding([.horizontal,.horizontal,.horizontal,.horizontal])
          .padding(.bottom)
            
  
        
   //Trending Section
            VStack(alignment:.leading){
                         Text("Most Popular")
                             .fontWeight(.bold)
                               .padding(.top,-15)
                             .font(.title)
                             .padding(.top)
                             .padding(.horizontal)
                TrendingScreen().environmentObject(self.trending)
                    .onTapGesture{self.showVideo = true}
                     }.padding(.top,-15)
                        .padding(.bottom)
             Divider().padding([.horizontal,.horizontal])
           
    ////Category Videos  Category1
        
            ForEach(0..<user.getFavTopicsCount()){ index in
                
            VStack(alignment:.leading){
                         Text(user.favouriteTopicList[index])
                             .fontWeight(.bold)
                             .font(.title)
                             .padding(.top)
                            .padding(.bottom,10)
                             .padding(.horizontal)
                categoryScreen_WillBeCalled(category:self.categories[index],id:user.favouriteTopics[index],index:index)//.environmentObject(self.category)
                    .onTapGesture{self.showVideo = true;print("Tapped")}
                     }.padding(.bottom)
             Divider().padding([.horizontal,.horizontal])
      //  }//ForEach
            }
            
               Divider().padding([.horizontal,.horizontal])
            
            
              //Responsible for Showing Subscriptions Section
                      VStack(alignment:.leading){
                          Text("Subscriptions")
                              .fontWeight(.bold)
                              .font(.title)
                              .padding(.top)
                              .padding(.horizontal)
                 SubscriptionsSection().environmentObject(self.subscriptions)
                      }.padding(.bottom)
                  
            
            
    
        }.navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            .navigationBarItems(trailing: Text("Update").onTapGesture{
                val = 1
                self.refresh.toggle()})
        
    }
          
        .sheet(isPresented: $showVideo){ videoPlayingScreen(Video:videoInWatchNow!)}//})

    }
        
    }
}

//func pushObjsInCategories(){
    
//}
