import XCTest

class HomeTests: XCTestCase {

  var sut: HomeViewModel!
  var locationService = MockLocationService()
  var apiService = MockGoogleApiService()
  var view = MockHomeView()

  override func setUp() {
    sut = HomeViewModel(locationService: locationService,
                        apiService: apiService)
    sut.view = view
  }

  func testViewDidLoadShowLoader() {
    sut.viewDidLoad()
    let expectedViewData = HomeViewData(places: [],
                                        segments: [.bar, .cafe, .restaurant],
                                        selectedSegmentIndex: 0,
                                        showLoader: true, showErrorState: false)
    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
  }

  func testViewDidLoadGetPlaces() {
    sut.viewDidLoad()
    apiService.mockRawPlaces = RawPlaces(results: apiService.mockPlaces, error_message: nil)
    apiService.mockShouldFail = false
    sut.didUpdateLocations(locations: [Coordinate(lat: "200", lng: "200")])
    let expectedViewData = HomeViewData(places: apiService.mockPlaces,
                                        segments: [.bar, .cafe, .restaurant],
                                        selectedSegmentIndex: 0,
                                        showLoader: false, showErrorState: false)
    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
  }

  func testFailingGetPlacesShowErrorState() {
    sut.viewDidLoad()
    apiService.mockShouldFail = true
    sut.didUpdateLocations(locations: [Coordinate(lat: "200", lng: "200")])
    let expectedViewData = HomeViewData(places: [],
                                        segments: [.bar, .cafe, .restaurant],
                                        selectedSegmentIndex: 0,
                                        showLoader: false, showErrorState: true)
    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
  }

  func testTapRefreshGetPlaces() {
    sut.didRefresh()

    apiService.mockRawPlaces = RawPlaces(results: apiService.mockPlaces, error_message: nil)
    apiService.mockShouldFail = false
    sut.didUpdateLocations(locations: [Coordinate(lat: "200", lng: "200")])
    let expectedViewData = HomeViewData(places: apiService.mockPlaces,
                                        segments: [.bar, .cafe, .restaurant],
                                        selectedSegmentIndex: 0,
                                        showLoader: false, showErrorState: false)
    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
  }

  func testSortAscendingSortPlaces() {
    sut.viewDidLoad()
    apiService.mockRawPlaces = RawPlaces(results: apiService.mockPlaces, error_message: nil)
    apiService.mockShouldFail = false
    sut.didUpdateLocations(locations: [Coordinate(lat: "200", lng: "200")])
    let expectedViewData = HomeViewData(places: apiService.mockPlacesRatingAscending,
                                        segments: [.bar, .cafe, .restaurant],
                                        selectedSegmentIndex: 0,
                                        showLoader: false, showErrorState: false)
    sut.didTapSortRatingAscending()
    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
  }

  func testSortDescendingSortPlaces() {
    sut.viewDidLoad()
    apiService.mockRawPlaces = RawPlaces(results: apiService.mockPlaces, error_message: nil)
    apiService.mockShouldFail = false
    sut.didUpdateLocations(locations: [Coordinate(lat: "200", lng: "200")])
    let expectedViewData = HomeViewData(places: apiService.mockPlacesRatingDescending,
                                        segments: [.bar, .cafe, .restaurant],
                                        selectedSegmentIndex: 0,
                                        showLoader: false, showErrorState: false)
    sut.didTapSortRatingDescending()
    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
   }

  func testTapTryAgainGetPlaces() {
    sut.didTapTryAgain()

    apiService.mockRawPlaces = RawPlaces(results: apiService.mockPlaces, error_message: nil)
    apiService.mockShouldFail = false
    sut.didUpdateLocations(locations: [Coordinate(lat: "200", lng: "200")])
    let expectedViewData = HomeViewData(places: apiService.mockPlaces,
                                        segments: [.bar, .cafe, .restaurant],
                                        selectedSegmentIndex: 0,
                                        showLoader: false, showErrorState: false)
    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
  }
}
