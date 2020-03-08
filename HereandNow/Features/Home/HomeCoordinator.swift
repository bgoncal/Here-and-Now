import UIKit

class HomeCoordinator {

  private let detailsCoordinator: DetailsCoordinator

  var rootViewController: UIViewController?

  init(detailsCoordinator: DetailsCoordinator) {
    self.detailsCoordinator = detailsCoordinator
  }

  @discardableResult
  func start() -> UIViewController {
    let homeViewController = ModuleBuilder<HomeViewController>.buildModule(coordinator: self as HomeViewModelDelegate)
    let navigationController = UINavigationController(rootViewController: homeViewController)

    if let rootViewController = rootViewController {
      navigationController.modalPresentationStyle = .fullScreen
      rootViewController.present(navigationController, animated: true, completion: nil)
      self.rootViewController = navigationController
    } else {
      rootViewController = navigationController
      return navigationController
    }

    return rootViewController!
  }
}

extension HomeCoordinator: HomeViewModelDelegate {
  func didTapPlace(_ place: Place) {
    detailsCoordinator.rootViewController = rootViewController
    detailsCoordinator.start(with: place)
  }
}
