import XCTest

class DetailsTests: XCTestCase {

  var sut: DetailsViewModel!
  var apiService = MockGoogleApiService()
  var view = MockDetailsView()
  var place = Place(id: "1",
                    name: "Place 1",
                    rating: 5.0,
                    opening_hours: .init(open_now: true),
                    photos: nil,
                    geometry: .init(location: .init(lat: 100, lng: 200)))

  override func setUp() {
    sut = DetailsViewModel(place: place,
                           apiService: apiService)
    sut.view = view
  }

  func testViewDidAppearLoadPlaceInformation() {
    sut.viewDidAppear()
    let expectedViewData = DetailsViewData(name: place.name,
                                           openNow: place.opening_hours!.readableValue,
                                           rating: place.readableRating,
                                           image: nil,
                                           location: place.geometry.location)
    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
  }
}
