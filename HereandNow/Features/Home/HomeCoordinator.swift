import UIKit

class HomeCoordinator {

  var rootViewController: UIViewController?

  func start() -> UIViewController {
    let homeViewController = ModuleBuilder<HomeViewController>.buildModule()

    if let rootViewController = rootViewController {
      rootViewController.present(homeViewController, animated: true, completion: nil)
      self.rootViewController = homeViewController
    } else {
      return homeViewController
    }

    return rootViewController!
  }
}
