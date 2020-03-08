import Foundation
import Swinject

class Assembler {

  static var shared: Swinject.Assembler!

  static func createAssembly() -> Swinject.Assembler {
    let assemblies: [Assembly] = [
      AppCoordinatorAssembly(),
      OnboardingAssembly(),
      HomeAssembly(),
      ServicesAssembly(),
      DetailsAssembly()
    ]

    shared = Swinject.Assembler(assemblies)
    return shared
  }
}
