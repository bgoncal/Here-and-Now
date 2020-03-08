import Foundation
import Swinject
import SwinjectAutoregistration

class DetailsAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(DetailsCoordinator.self, initializer: DetailsCoordinator.init)
    container.autoregister(DetailsViewModel.self, argument: Place.self, initializer: DetailsViewModel.init)
    container.register(DetailsViewController.self) { (resolver, context: DetailsContext) -> DetailsViewController in
      let view: DetailsViewController = .initializeOnMainStoryBoard()
      let viewModel = resolver.resolve(DetailsViewModel.self, argument: context.place)!
      view.viewModel = viewModel
      viewModel.view = view
      return view
    }
  }
}
