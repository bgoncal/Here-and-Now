import UIKit
import Swinject

class HomeAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(HomeCoordinator.self, initializer: HomeCoordinator.init)
    container.autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
    container.register(HomeViewController.self) { resolver -> HomeViewController in
      let view: HomeViewController = .initializeOnMainStoryBoard()
      return view
    }
  }
}
