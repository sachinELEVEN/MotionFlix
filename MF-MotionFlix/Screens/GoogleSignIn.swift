//FIRAnalyticsQueueFIRAnalyticsQueue
import SwiftUI
import UIKit
import GoogleAPIClientForREST
import GoogleSignIn
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
 */
//GIDSignInDelegate, GIDSignInUIDelegate
//930840547650-o7nohnicir8iu4adsqn5otlcl6eifogi.apps.googleusercontent.com


//Problem calls from background thread
var tokenID = ""
var accesToken = ""
var countryOfUser = "''"
var accessToken1 = ""
struct GoogleSignIn: UIViewControllerRepresentable {
   
    private let service = GTLRYouTubeService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    func makeUIViewController(context: Context) -> UIViewController {
       
       // DispatchQueue.main.async{
            let viewController = CustomViewController()
        
       // }
          return viewController
      
       
    }
    
    func updateUIViewController(_ viewController: UIViewController, context: Context) {

        viewController.view.backgroundColor = .blue
    
        
//       //addd the google sign in button
//        let googleButton = GIDSignInButton()
//        googleButton.frame = CGRect(x: 100, y: 400, width: 80, height: 40)
//        viewController.view.addSubview(googleButton)
//
        
        // Configure Google Sign-in.
     
        
    }
    
    class CustomViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
        
        
        // If modifying these scopes, delete your previously saved credentials by
        // resetting the iOS simulator or uninstall the app.
        private let scopes = [kGTLRAuthScopeYouTubeReadonly]
        
           private let service = GTLRYouTubeService()
        let signInButton = GIDSignInButton()
        let output = UITextView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
          // Configure Google Sign-in.
          GIDSignIn.sharedInstance().delegate = self
          GIDSignIn.sharedInstance().uiDelegate = self
          GIDSignIn.sharedInstance().scopes = scopes
       //   GIDSignIn.sharedInstance().signInSilently()

          // Add the sign-in button.
         self.view.addSubview(self.signInButton)

          // Add a UITextView to display output.
          output.frame = view.bounds
          output.isEditable = false
          output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
          output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
          output.isHidden = true
          self.view.addSubview(self.output);
        }
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                  withError error: Error!) {
            if let error = error {
                showAlert(title: "Authentication Error", message: error.localizedDescription)
                self.service.authorizer = nil
            } else {
                //Successfully logged in
                 tokenID = user.authentication.idToken
                accesToken = user.authentication.accessToken
               print("YYYY")
               // print(accesToken)
                  print(tokenID)
                accessToken1 = accesToken
                
                //
                self.signInButton.isHidden = true
                self.output.isHidden = false
                self.service.authorizer = user.authentication.fetcherAuthorizer()
                fetchChannelResource()
            }
        }
        
        
        // List up to 10 files in Drive
        //Gets users channel details
        func fetchChannelResource() {
            
           let query = GTLRYouTubeQuery_ChannelsList.query(withPart: "snippet,statistics")
        //    let query = GTLRYouTubeQuery_SubscriptionsList.query(withPart: "snippet")
           print("This")
            print(query)
         //   print(query.)
            //  query.identifier = "UC_x5XG1OV2P6uZZ5FSM9Ttw"
            // To retrieve data for the current user's channel, comment out the previous
            // line (query.identifier ...) and uncomment the next line (query.mine ...)
             query.mine = true
            service.executeQuery(query,
                                 delegate: self,
                                 didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
        }
        
        // Process the response and display output
        @objc  func displayResultWithTicket(
            ticket: GTLRServiceTicket,
            finishedWithObject response : GTLRYouTube_ChannelListResponse,
           // finishedWithObject response : GTLRYouTube_SubscriptionListResponse,
            error : NSError?) {
            
            if let error = error {
                showAlert(title: "Error", message: error.localizedDescription)
                return
            }
            
            var outputText = ""
            if let channels = response.items, !channels.isEmpty {
                let channel = response.items![0]
           print("channel is printed")
                print(channel)
                //  let s = chann
                
                let title = channel.snippet!.title
                let description = channel.snippet?.descriptionProperty
                let viewCount =   channel.statistics?.viewCount
                countryOfUser = channel.snippet?.country ?? "in"
                print("Counrty ",countryOfUser)
                outputText += "title: \(title!)\n"
               outputText += "description: \(description!)\n"
            outputText += "view count: \(viewCount!)\n"
            }
            output.text = "done"//outputText
 
        }
        
        
        
        // Helper for showing an alert
        func showAlert(title : String, message: String) {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert
            )
            let ok = UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: nil
            )
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
   
}




//ya29.ImGUB2RQVYpNIHWZc0ki-WgKkwC28_agCz32qlXIlT4dXQzjG2fFdFN_fvYr7jAfY0L1GQ-rQ7956m9vYgdY-Bdczs7xEWWIpwcwrVQ6EmhswyWMfjeYPw0BMygY5GroI8n4
//ya29.ImGUB2RQVYpNIHWZc0ki+WgKkwC28/agCz32qlXIlT4dXQzjG2fFdFN/fvYr7jAfY0L1GQ+rQ7956m9vYgdY+Bdczs7xEWWIpwcwrVQ6EmhswyWMfjeYPw0BMygY5GroI8n4
