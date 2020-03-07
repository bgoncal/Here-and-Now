import Foundation
import Swinject

class Assembler {

  static var shared: Swinject.Assembler!

  static func createAssembly() -> Swinject.Assembler {
    let assemblies: [Assembly] = [
      AppCoordinatorAssembly(),
      OnboardingAssembly(),
      HomeAssembly()
    ]

    shared = Swinject.Assembler(assemblies)
    return shared
  }
}
