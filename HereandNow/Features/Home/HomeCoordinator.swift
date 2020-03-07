import UIKit

class HomeCoordinator {

  var rootViewController: UIViewController?

  func start() -> UIViewController {
    let homeViewController = ModuleBuilder<HomeViewController>.buildModule()
    let navigationController = UINavigationController(rootViewController: homeViewController)

    if let rootViewController = rootViewController {
      rootViewController.present(navigationController, animated: true, completion: nil)
      self.rootViewController = navigationController
    } else {
      return navigationController
    }

    return rootViewController!
  }
}
