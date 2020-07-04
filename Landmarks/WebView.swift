 import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: String
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL (string: self.url) else {
            return WKWebView()
        }
        let request = URLRequest (url:url)
        let wkWebView = WKWebView()
        wkWebView.load (request)
        return wkWebView
    }
    
    func updateUIView(_ uiView: WebView.UIViewType, context: UIViewRepresentableContext<WebView>){
    }
}
 
 struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
 }
 
