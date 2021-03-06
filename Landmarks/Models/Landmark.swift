import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String                                //название храма
    fileprivate var imageName: String               //имя картинки
    fileprivate var coordinates: Coordinates        //структура координат храма
    var state: String                               //город\поселок
    var park: String                // пока не использовать
    var category: String//Category          // пока не использовать
    var isFavorite: Bool                            // добавить в избранные
    var explanation: String?            // Пояснение о расписании (если nill - должно быть подробное расписание в timeTable)
    var timeTable: TimeTable?  // это массив дней
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,// - 00.003,
            longitude: coordinates.longitude)// + 00.01)
    }

//    enum Category: String, CaseIterable, Codable, Hashable {
//        case featured = "Featured"
//        case lakes = "Lakes"
//        case rivers = "Rivers"
//        case mountains = "Mountains"
//        case berezovskoe = "Березовское"
//        case vp = "Верхнепышминское"
//        case vseрsviatskoe = "Всехсвятское"
//    }
}

extension Landmark {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}

// MARK: - TimeTable
struct TimeTable: Hashable, Codable {
    var monday, tuesdayFriday, saturday, sunday: Day
}

// MARK: - Day
struct Day: Hashable, Codable {
    var morning, evening: String
}

struct Landmark_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
