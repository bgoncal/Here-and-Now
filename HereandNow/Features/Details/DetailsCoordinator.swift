import UIKit

struct DetailsContext {
  let place: Place
}

class DetailsCoordinator {

  var rootViewController: UIViewController?

  func start(with place: Place) {
    let detailsViewController = ModuleBuilder<DetailsViewController>.buildModule(context: DetailsContext(place: place))

    if let navigationController = rootViewController as? UINavigationController {
      navigationController.pushViewController(detailsViewController, animated: true)
    } else {
      rootViewController?.present(detailsViewController, animated: true, completion: nil)
    }
  }
}
