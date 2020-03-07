import UIKit

protocol AppCoordinatorProtocol {
  var delegate: AppCoordinatorDelegate? { get set }
  var window: UIWindow? { get set }
  func start()
}

protocol AppCoordinatorDelegate: class {

}

class AppCoordinator: AppCoordinatorProtocol {

  private let onboardingCoordinator: OnboardingCoordinator
  private let homeCoordinator: HomeCoordinator
  private let locationService: LocationServiceProtocol

  var window: UIWindow?
  var rootViewController: UIViewController!
  weak var delegate: AppCoordinatorDelegate?

  init(onboardingCoordinator: OnboardingCoordinator,
       homeCoordinator: HomeCoordinator,
       locationService: LocationServiceProtocol) {
    self.onboardingCoordinator = onboardingCoordinator
    self.homeCoordinator = homeCoordinator
    self.locationService = locationService
  }

  func start() {
    if locationService.locationIsEnabled {
      rootViewController = homeCoordinator.start()
    } else {
      rootViewController = onboardingCoordinator.start()
    }
    window?.rootViewController = rootViewController
  }
}
