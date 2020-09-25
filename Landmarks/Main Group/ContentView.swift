import SwiftUI
struct ContentView: View {
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    //@State var expand = false
    init(){
        UITableView.appearance().backgroundColor =  UIColor(red: 240/255, green:240/255, blue: 249/255, alpha: 0.5)
    }
        
    var body: some View {
        // MARK: Drager
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width > 100 {
                    withAnimation {
                        self.userData.showMenu = false
                    }
                }
        }
        
        return ZStack {
            
            // MARK: Menu
            
            VStack {
                Menu()
                    .transition(.move(edge: .trailing))
            }
            
            // MARK: The
            
            VStack {
                GeometryReader { _ in
                    if self.userData.index == 0{
                        TheTimeTable()
                    }
                    else if self.userData.index == 1 {
                        ThePrayes()
                    }
                }
                .background(Color.offWhite)
                .cornerRadius(self.userData.showMenu ? 30 : 0)
                .scaleEffect(self.userData.showMenu ? 0.9 : 1)
                    .offset(x: self.userData.showMenu ? -UIScreen.main.bounds.width / 2 : 0, y: self.userData.showMenu ? 15 : 0)
                    .rotationEffect(.init(degrees: self.userData.showMenu ? -5 : 0))
                .animation(.easeInOut(duration: 0.5))
            }
            .gesture(drag)
        }
        .background(Color.offWhite.edgesIgnoringSafeArea(.all))
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

