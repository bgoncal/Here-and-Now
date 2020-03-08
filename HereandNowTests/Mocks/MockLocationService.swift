import Foundation

class MockLocationService: LocationServiceProtocol {

  func requestLocation() {
    delegate?.didChangeAuthorization(approved: mockApprovedAuthorization)
  }

  var delegate: LocationServiceDelegate?

  var permissionRequested: Bool {
    return mockPermissionRequested
  }

  var locationIsEnabled: Bool {
    return mockLocationIsEnabled
  }

  var mockPermissionRequested = false
  var mockLocationIsEnabled = false
  var mockApprovedAuthorization = false
}
