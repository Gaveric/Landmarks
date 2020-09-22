import SwiftUI
struct ContentView: View {
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var expand = false
    init(){
        UITableView.appearance().backgroundColor =  UIColor(red: 240/255, green:240/255, blue: 249/255, alpha: 0.5)
    }
    
    @State var showMenu = false
    
    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width > 100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
        }
        return GeometryReader { geometry in
            ZStack {
                
                VStack {
                    TheMain(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? -geometry.size.width/2 : 0, y: 0)
                        .disabled(self.showMenu ? true : false)
                        .rotationEffect(.init(degrees: self.showMenu ? -5 : 0))
                }
                
                
                if self.showMenu {
                    
                    HStack {
                        Spacer()
                        Menu()
                            .frame(width: geometry.size.width/2)//, height: geometry.size.height)
                            .transition(.move(edge: .trailing))
                        
                        
                    }
                    
                }
            }
            .gesture(drag)
        }
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

