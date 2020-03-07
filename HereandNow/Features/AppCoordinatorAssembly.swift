import UIKit
import Swinject
import SwinjectAutoregistration

class AppCoordinatorAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(AppCoordinatorProtocol.self, initializer: AppCoordinator.init)
  }
}
