import UIKit
import Swinject

class OnboardingCoordinator {

  var rootViewController: UIViewController?

  @discardableResult
  func start() -> UIViewController {
    let onboardingViewController = ModuleBuilder<OnboardingViewController>.buildModule(coordinator: self as OnboardingViewModelDelegate)
    rootViewController = onboardingViewController
    return onboardingViewController
  }
}

extension OnboardingCoordinator: OnboardingViewModelDelegate {
  func didAuthorizedLocation() {

  }
}
