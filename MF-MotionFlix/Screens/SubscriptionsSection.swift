//
//  Subscriptions.swift
//  MotionFlix
//
//  Created by sachin jeph on 18/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI

struct SubscriptionsSection : View {
     @EnvironmentObject var subscriptions : envClass3
     // @State  var videoInWatchNow : VideoCell?
    
    var body: some View {
       // NavigationView{// }.navigationBarTitle(Text("Hello"))  .navigationBarHidden(true)
       
        ScrollView(.horizontal,showsIndicators: false){
        HStack{
         //   ForEach(subscriptions.Subscribedchannels,id: \.)
            ForEach(subscriptions.Subscribedchannels,id: \.channelID){channel in
                DisplaySubscriptionScetion(channel: channel)
            }


        }


     }
       // Text("I")
      //Fix this extract for view's content into seperate view
        
        
    }
}

//123.2

struct DisplaySubscriptionScetion:View{
    var channel: ChannelCell
    var body:some View{
        VStack{ //channel in

                  if(channel.channelID != nil) {//then show now data

              //.environmentObject(self.channelPlaylist)
                  NavigationLink(destination:AbouChannel_GeneralWillBeCalled(Channel: channel)){
        //           PresentationButton(destination:Temp()){
                  VStack(alignment:.center){
                      //cell UI inside it
                      if(channel.channelImage.image != nil){
                      Image(uiImage: channel.channelImage.image!)
                          .renderingMode(.original)
                          .resizable()
                         // .scaledToFit()
                          .cornerRadius(5)
                          .frame(width:70,height:130)
                         // .cornerRadius(5)
                          //.clipShape(RoundedRectangle(cornerRadius: 10))
                         // .clipShape(Circle())
                      }


                      Text(channel.channelName!)
                          .fontWeight(.bold)
                          .lineLimit(nil)
                          .font(.headline)
                          .multilineTextAlignment(.leading)

                          .padding([.bottom])





                  //   Spacer()


                  }//.padding(.horizontal)
                      .foregroundColor(.primary)
                  }

                 }
              }
    }
}
