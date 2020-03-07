import Foundation
import CoreLocation

protocol LocationServiceProtocol {
  func requestLocation()
  var delegate: LocationServiceDelegate? { get set }
  var permissionRequested: Bool { get }
  var locationIsEnabled: Bool { get }
}

protocol LocationServiceDelegate: class {
  func didChangeAuthorization(approved: Bool)
  func didUpdateLocations(locations: [Coordinate])
}

extension LocationServiceDelegate {
  func didChangeAuthorization(approved: Bool) { }
  func didUpdateLocations(locations: [Coordinate]) { }
}

class LocationService: NSObject, LocationServiceProtocol {

  private let locationManager: CLLocationManager

  var delegate: LocationServiceDelegate?
  var locationIsEnabled: Bool {
   if CLLocationManager.locationServicesEnabled() {
      switch CLLocationManager.authorizationStatus() {
      case .notDetermined,  .restricted, .denied:
        return false
      case .authorizedAlways, .authorizedWhenInUse:
        return true
      default:
        return false
      }
    } else {
      return false
    }
  }

  var permissionRequested: Bool {
    if CLLocationManager.locationServicesEnabled() {
      switch CLLocationManager.authorizationStatus() {
      case .notDetermined:
        return false
      case .authorizedAlways, .authorizedWhenInUse, .restricted, .denied:
        return true
      default:
        return false
      }
    } else {
      return false
    }
  }

  init(locationManager: CLLocationManager) {
    self.locationManager = locationManager
  }

  func requestLocation() {
    locationManager.requestWhenInUseAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }
  }
}

extension LocationService: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let coordinates = locations.map { location -> Coordinate in
      let lat = String(location.coordinate.latitude)
      let long = String(location.coordinate.longitude)
      return Coordinate(lat: lat, long: long)
    }
    delegate?.didUpdateLocations(locations: coordinates)
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    delegate?.didChangeAuthorization(approved: locationIsEnabled)
  }
}
