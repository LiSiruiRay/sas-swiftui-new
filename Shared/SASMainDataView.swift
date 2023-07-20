// Created by S Ray Li on 2023.Jul.19
//

import SwiftUI
import Combine
import FirebaseAnalytics
import FirebaseAnalyticsSwift

class FavouriteNumberViewModel: ObservableObject {
  @Published var favouriteNumber: Int = 42

  private var defaults = UserDefaults.standard
  private let favouriteNumberKey = "favouriteNumber"
  private var cancellables = Set<AnyCancellable>()

  init() {
    if let number = defaults.object(forKey: favouriteNumberKey) as? Int {
      favouriteNumber = number
    }
    $favouriteNumber
      .sink { number in
        self.defaults.set(number, forKey: self.favouriteNumberKey)
        Analytics.logEvent("stepper", parameters: ["value" : number])
      }
      .store(in: &cancellables)
  }
}

struct SASMainDataView: View {
  @StateObject var viewModel = FavouriteNumberViewModel()
    @State private var category: Wine.Category = .variety
  var body: some View {
    VStack {
        PieChart(entries: Wine.entriesForWines(Wine.allWines, category: category), category: $category)
            .frame(height: 400)
            .padding()
    }
//    .frame(width: 5000)
      
//    .frame(maxHeight: 150)
//    .foregroundColor(.white)
//    .padding()
//    #if os(iOS)
//    .background(Color(UIColor.systemPink))
//    #endif
//    .clipShape(RoundedRectangle(cornerRadius: 16))
//    .padding()
//    .shadow(radius: 8)
    .navigationTitle("News Data")
//    .analyticsScreen(name: "\(SASMainDataView.self)")
  }
}

struct FavouriteNumberView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
        SASMainDataView()
    }
  }
}
