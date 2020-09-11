import SwiftUI
struct LandmarkRow: View {
    @EnvironmentObject private var userData: UserData
    var landmark: Landmark
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack {
                HStack {
                    Text(landmark.name)
                    Spacer()
                }
                HStack {
                    Text(landmark.state)
                    Spacer()
                }
            }
            Spacer()
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }
    }
    
}

struct LandmarkRow_Previews: PreviewProvider {
    @EnvironmentObject private var userData: UserData
    static var previews: some View {
        Group {
             LandmarkRow(landmark: landmarkData[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
