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
  func didTapManualSearch() {
    let alert = UIAlertController(title: "Hello!", message: "Manual search not available yet ✌🏻", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    rootViewController?.present(alert, animated: true, completion: nil)
  }

  func didTapOpeniPhoneSettings() {
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
      return
    }
    
    if UIApplication.shared.canOpenURL(settingsUrl) {
      UIApplication.shared.open(settingsUrl, completionHandler: nil)
    }
  }

  func didAuthorizedLocation() {
    homeCoordinator.rootViewController = rootViewController
    homeCoordinator.start()
  }
}
