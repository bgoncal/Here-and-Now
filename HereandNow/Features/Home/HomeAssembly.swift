import UIKit
import Swinject

class HomeAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(HomeCoordinator.self, initializer: HomeCoordinator.init)
    container.autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
    container.register(HomeViewController.self) { (resolver, coordinator: HomeViewModelDelegate) -> HomeViewController in
      let view: HomeViewController = .initializeOnMainStoryBoard()
      let viewModel = resolver.resolve(HomeViewModel.self)!
      viewModel.view = view
      view.viewModel = viewModel
      viewModel.delegate = coordinator
      return view
    }
  }
}
