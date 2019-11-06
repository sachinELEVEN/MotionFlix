import SwiftUI

struct Search_WillBeCalled:View {
  let searchResults = envClass()
  //  var  channelPlaylist = envClass2()
   
    var body : some View{
        
        VStack{
            Text("Nice").frame(width:0,height:0).onAppear{
             
            }.onAppear{ userCurrentScreen = "Search"
                print("Screen",userCurrentScreen)
            }
            
            Search().environmentObject(self.searchResults)
        
        }
    }
}




struct Search: View {
    @State var searchedText = ""
      @State private var showVideo = false
     @EnvironmentObject var searchResults : envClass
     var originalToken = "CAoQAA"
    var body: some View {
        NavigationView{
       ScrollView(.vertical){
        VStack {
            TextField("Search Here", text: $searchedText){
                          UIApplication.shared.keyWindow?.endEditing(true)
            searchNextPageToken = self.originalToken
            self.searchResults.currentVideos_1.removeAll()
            self.searchFunc()

            }
          
            
//                TextField($searchedText, placeholder: Text("Search Here")) {
//                            UIApplication.shared.keyWindow?.endEditing(true)
//                    searchNextPageToken = self.originalToken
//                    self.searchResults.currentVideos_1.removeAll()
//                    self.searchFunc()
//
//                }
//                .foregroundColor(.secondary)
//                    .padding([.horizontal,.top])
//                    .font(.title)
//                   .lineLimit(nil)
//                     Divider()
//                    .padding()
//
               // Spacer()
         
            
                VStack{
                                    ForEach(searchResults.currentVideos_1,id:\.videoID){eachVideo in
                                     
                                     
                                      
                                      //  VideoCellLayout(eachVideo: eachVideo)
                                                VideoCellLayout(eachVideo: eachVideo)//
                                                    .onTapGesture{self.startPlayingVideo(Video:eachVideo)}
                                        
                                        
                                    }

                }
               
            if(searchResults.currentVideos_1.count != 0){
                Button(action:{self.searchFunc()}){
                    Text("See More")
                        .font(.headline)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.3))
                    .cornerRadius(20)
                }
            }
            
            
            }
       }.navigationBarTitle(Text("Search"))
      }
        
         .sheet(isPresented: $showVideo){ videoPlayingScreen(Video:videoInSearch!)}
    }
    
    
    func searchFunc(){
    if(searchedText != ""){
        var temp = searchedText
        temp.removeAll { (char) -> Bool in
            char == " "
        }
     
        let searchType = "video"
  pullSearchData(seachedText: temp, searchType:searchType , searchResults: self.searchResults)
        print("Token is ",searchNextPageToken)
        //search by channels still has to be added
    }
    }
    
    func startPlayingVideo(Video:VideoCell){
        
        videoInSearch = Video
        // print("IDSearch ",videoInSearch?.videoTitle)
        showVideo = true
    }

}

