import UIKit
import Swinject

class OnboardingCoordinator {

  private let homeCoordinator: HomeCoordinator
  var rootViewController: UIViewController?

  init(homeCoordinator: HomeCoordinator) {
    self.homeCoordinator = homeCoordinator
  }

  @discardableResult
  func start() -> UIViewController {
    let onboardingViewController = ModuleBuilder<OnboardingViewController>.buildModule(coordinator: self as OnboardingViewModelDelegate)
    rootViewController = onboardingViewController
    return onboardingViewController
  }
}

extension OnboardingCoordinator: OnboardingViewModelDelegate {
  func didAuthorizedLocation() {
    homeCoordinator.rootViewController = rootViewController
    homeCoordinator.start()
  }
}
