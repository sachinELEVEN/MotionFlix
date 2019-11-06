//
//  File.swift
//  MotionFlix
//
//  Created by sachin jeph on 06/10/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import SwiftUI

struct FatSecret:View{
    var body:some View{
        Text("a")
            .onAppear{
                getSearchFood()
        }
    }
}


func getSearchFood(){
   var clientID = "25a284a4d03b42018790d783c4925fb3"
 var clientSecret   = "4d04e92691e34eb0a33678c3d6a45da2"
 accessToken1   = "ya29.ImGUB2RQVYpNIHWZc0ki+WgKkwC28/agCz32qlXIlT4dXQzjG2fFdFN/fvYr7jAfY0L1GQ+rQ7956m9vYgdY+Bdczs7xEWWIpwcwrVQ6EmhswyWMfjeYPw0BMygY5GroI8n4"

    
    var url = URL(string: "https://oauth.fatsecret.com/connect/token?grant_type=client_credentials&client_id=\(clientID)&client_secret=\(clientSecret)&scope=basic")
print(url)
       //seachedText:String,searchType:String
         
           let fatSecretConsKey = "b99f1169ea534976b066ae2c6cf6fecd"
        let fatSecretConsumerSecret = "f2a0831d9aaf42668e197a82259830d9"
           let timeStampSinceJan1 = NSTimeIntervalSince1970
        let timeStamp = Int(timeStampSinceJan1)
           let nounce = UUID.init().uuidString
       
        

        
           let parameters : [String:String] =
               ["oauth_consumer_key":fatSecretConsKey,
           "oauth_signature_method":"HMAC-SHA1",
           "oauth_timestamp":"\(timeStampSinceJan1)",
           "oauth_nonce":nounce,
           "oauth_version":"1.0",
          // "oauth_signature":oauth_sign,
           "method":"foods.search"
           ]
        
        
      
      //  print(timeStamp)
     //     var url = URL(string: "http://platform.fatsecret.com/rest/server.api?oauth_signature=\(oauth_sign)&oauth_consumer_key=\(fatSecretConsKey)&oauth_signature_method=HMAC-SHA1&oauth_timestamp=\(timeStamp)&oauth_nonce=\(nounce)&oauth_version=1.0&method=foods.search&format=json")
        
        
      
        
      // var url = URL(string: "https://platform.fatsecret.com/js?key=a8abdcd07de245fbb88c930cb2019b79&format=json")
      
        let request = URLRequest(url: url!)
       // request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, resonse, error) in
            if error != nil {
               
                print("An error is encountered - \(error!) ")
                return
            }
            
            do {
                //trying to convert json object into a dictionary
                
                let jsonObj = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
              
                print(jsonObj)
              
              
                
                
               
        
                
                
            }catch let error {
                print(error)
            }
           
       
            
        };task.resume()
        
      
        
        
        
        
    
}
//Fat Secret Credentials

/*
 Optional(https://oauth.fatsecret.com/connect/token?grant_type=client_credentials&client_id=25a284a4d03b42018790d783c4925fb3&client_secret=4d04e92691e34eb0a33678c3d6a45da2&scope=basic)
 */
