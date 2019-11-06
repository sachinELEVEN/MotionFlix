//
//  PullSubscriptionVideos.swift
//  MotionFlix
//
//  Created by sachin jeph on 20/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import SwiftUI
/*
{
   "kind": "youtube#subscription",
   "etag": "\"Bdx4f4ps3xCOOo1WZ91nTLkRZ_c/yoBfYy4IuwsOslECKSp9vvU_l3A\"",
   "id": "ZLIgqI4e9gRwzTglKfXT_SULp_mbS5sFMCMoc6292XI",
   "snippet": {
    "publishedAt": "2019-07-20T04:08:45.211Z",
    "title": "Let's Learn Swift",
    "description": "print(\"Let's Learn Swift\")\n\nSwift. Herkesin muhteşem uygulamalar geliştirebilmesi için güçlü ve açık kaynaklı bir dil.\n\nSwift; iOS, Mac, Apple TV ve Apple Watch uygulamaları geliştirmek için Apple tarafından oluşturulmuş güçlü ve kullanıcı dostu bir programlama dili. Geliştiricilere, her zamankinden daha fazla özgürlük sağlamak için tasarlandı. Swift, kullanımı kolay ve açık kaynaklı bir dil. Bu yüzden, bir fikri olan herkes, şimdi inanılmaz şeyler yaratabilir.",
    "resourceId": {
     "kind": "youtube#channel",
     "channelId": "UC_0srkcd_tioJrb11wBCdEQ"
    },
    "channelId": "UC0Rbf0CZpTDGn3kd_erKOIQ",
    "thumbnails": {
     "default": {
      "url": "https://yt3.ggpht.com/-G6xvREaV8ZM/AAAAAAAAAAI/AAAAAAAAAAA/Pz2OLu9m2-4/s88-c-k-no-mo-rj-c0xffffff/photo.jpg"
     },
     "medium": {
      "url": "https://yt3.ggpht.com/-G6xvREaV8ZM/AAAAAAAAAAI/AAAAAAAAAAA/Pz2OLu9m2-4/s240-c-k-no-mo-rj-c0xffffff/photo.jpg"
     },
     "high": {
      "url": "https://yt3.ggpht.com/-G6xvREaV8ZM/AAAAAAAAAAI/AAAAAAAAAAA/Pz2OLu9m2-4/s800-c-k-no-mo-rj-c0xffffff/photo.jpg"
     }
    }
   }
  },



GET "https://www.googleapis.com/youtube/v3/subscriptions?part=snippet&mine=true&access_token=\(accesToken)" HTTP/1.1

Authorization: Bearer [YOUR_ACCESS_TOKEN]
Accept: application/json

*/

