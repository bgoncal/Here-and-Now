import XCTest

class OnboardingTests: XCTestCase {

  var sut: OnboardingViewModel!
  var view = OnboardingViewMock()
  var locationServices = MockLocationService()

  override func setUp() {
    sut = OnboardingViewModel(locationService: locationServices)
    sut.view = view
  }


  func testViewDidAppearSetCorrectViewData() {
    sut.viewDidAppear()

    let expectedViewData = OnboardingViewData(locationAuthorized: false,
                                              permissionRequested: false)

    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
  }

  func testDidTapAllowChangeUIToAuthorizedState() {
    locationServices.mockApprovedAuthorization = true
    locationServices.mockPermissionRequested = true
    sut.didTapAllow()
    let expectedViewData = OnboardingViewData(locationAuthorized: true,
                                              permissionRequested: true)

    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
  }

  func testDidTapAllowAndDenyInDialogChangeUIToNotAuthorizedState() {
    locationServices.mockApprovedAuthorization = false
    locationServices.mockPermissionRequested = true
    sut.didTapAllow()
    let expectedViewData = OnboardingViewData(locationAuthorized: false,
                                              permissionRequested: true)

    let realViewData = sut.view?.viewData
    XCTAssert(realViewData == expectedViewData)
  }

}
