import Foundation
import Swinject
import CoreLocation

class ServicesAssembly: Assembly {
  func assemble(container: Container) {
    container.register(LocationServiceProtocol.self) { resolver -> LocationService in
      return LocationService(locationManager: CLLocationManager())
    }.inObjectScope(.container)

    container.autoregister(GoogleApiServiceProtocol.self, initializer: GoogleApiService.init)
  }
}
