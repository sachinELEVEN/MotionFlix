//
//  player.swift
//  MotionFlix
//
//  Created by sachin jeph on 16/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import AVKit
import WebKit

let song = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
let story = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
/*
struct PlayerView: UIViewRepresentable {
    let player: AVPlayer
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
        (uiView as? PlayerUIView)?.updatePlayer(player: player)
    }
    
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(player: player)
    }
}

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    init(player: AVPlayer) {
        super.init(frame: .zero)
        
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    func updatePlayer(player: AVPlayer) {
        self.playerLayer.player = player
    }
}

struct PlayerContainerView : View {
    
    @State var seekPos = 0.0
    
    private let player: AVPlayer
    init(player: AVPlayer) {
        self.player = player
    }
    var body: some View {
        VStack {
            PlayerView(player: player)
            PlayerControlsView(player: player)
        }
    }
}

struct PlayerControlsView : View {
    @State var playerPaused = true
    @State var seekPos = 0.0
    let player: AVPlayer
    var body: some View {
        VStack {
            Button(action: {
                self.playerPaused.toggle()
                if self.playerPaused {
                    self.player.pause()
                }
                else {
                    self.player.play()
                }
            }) {
                Image(systemName: playerPaused ? "play.fill" : "pause.fill")
                    .resizable()
                    .frame(width:40,height:40)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .foregroundColor(.pink)
            }
            Slider(value: $seekPos, from: 0, through: 1, onEditingChanged: { _ in
                guard let item = self.player.currentItem else {
                    return
                }
                
                let targetTime = self.seekPos * item.duration.seconds
                self.player.seek(to: CMTime(seconds: targetTime, preferredTimescale: 600))
            })
                .foregroundColor(.pink)
                .padding(.horizontal, 20)
        }.foregroundColor(.pink)
    }
}


*/

 struct vv:UIViewRepresentable {
 var VideoID:String
 func makeUIView(context : Context )->WKWebView{
   
   let webView = WKWebView()
 return webView
 }
 
 func updateUIView(_ webView:WKWebView,context:Context){
    let url = URL(string: "https://www.youtube.com/embed/\(VideoID)")
  //  getVideoUrlFromVideoID(VideoID: VideoID)
   
     webView.configuration.allowsInlineMediaPlayback = true
    let request = URLRequest(url: url!)
   
   // webView.loadHTMLString(<#T##string: String##String#>, baseURL: <#T##URL?#>)
   
   // webView.configuration.mediaTypesRequiringUserActionForPlayback = .video
    webView.load(request)
    //webView.configuration.allowsInlineMediaPlayback = true
      // webView.configuration.mediaTypesRequiringUserActionForPlayback = .video
  //  webView.

 }
 
 }
 

struct gg : UIViewControllerRepresentable {
 var VidoeID:String
//var videoID1 = "www.youtube.com/embed/Wf1lQdupvPE"
    var videoID1 = "https://www9.fmovies.to/film/riverdale-3.z1pmp/vvvy4ol"
func makeUIViewController(context: UIViewControllerRepresentableContext<gg>) -> AVPlayerViewController {
   let p = AVPlayerViewController()
   // p.frame =
    return p
}

func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<gg>) {
    let url = URL(string:videoID1)
    let player = AVPlayer(url: url!)
    let vc = uiViewController
    vc.player = player
    //PROBLEM
    //present(vc, animated: true){
    vc.player?.play()
   
  //  }
}
}
