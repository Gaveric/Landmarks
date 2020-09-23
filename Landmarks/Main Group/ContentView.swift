import SwiftUI
struct ContentView: View {
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    //@State var expand = false
    init(){
        UITableView.appearance().backgroundColor =  UIColor(red: 240/255, green:240/255, blue: 249/255, alpha: 0.5)
    }
    
    @State var showMenu = false
    @State var index = 0
    
    var body: some View {
        
        
        
        // MARK: Drager
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width > 100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
        }
        //return GeometryReader { geometry in

        return             ZStack {
            
            // MARK: Menu
            
            VStack {
                
                Menu(showMenu: self.$showMenu, index: self.$index)
                    //.frame(width: geometry.size.width/2)//, height: geometry.size.height)
                    .transition(.move(edge: .trailing))
            }
            //                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            //                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
            
            // MARK: TheMain
            
            VStack {
                
                GeometryReader { _ in
                                           
                if self.index == 0{
                                               
                                               
                    TheMain(showMenu: self.$showMenu)
                    //                        .frame(width: geometry.size.width, height: geometry.size.height)
                    //                          .offset(x: self.showMenu ? -geometry.size.width/2 : 0, y: 0)
                    
                    //                        .disabled(self.showMenu ? true : false)
                    //                        .rotationEffect(.init(degrees: self.showMenu ? -5 : 0))
               
                    }
                    else if self.index == 1 {
                        Prayes(showMenu: self.$showMenu)
                    }
                
                
                
                
                
                }
                .background(Color.offWhite)
                .cornerRadius(self.showMenu ? 30 : 0)
                    // Shrinking And Moving View Right Side When Menu Button Is Clicked...
                .scaleEffect(self.showMenu ? 0.9 : 1)
                    //.offset(x: self.showMenu ? -geometry.size.width/2 : 0, y: 0)
                .offset(x: self.showMenu ? -UIScreen.main.bounds.width / 2 : 0, y: self.showMenu ? 15 : 0)
                    // Rotating Slighlty...
                .rotationEffect(.init(degrees: self.showMenu ? -5 : 0))
                
            }
            .gesture(drag)
        }
        .background(Color.offWhite.edgesIgnoringSafeArea(.all))
        //.edgesIgnoringSafeArea(.all)
    }
}

struct LandmarksList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
    }
}

