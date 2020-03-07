import UIKit

class ModuleBuilder<View: UIViewController> {

  class func buildModule() -> View {
    return Assembler.shared.resolver.resolve(View.self)!
  }

  static func buildModule<Context>(context: Context) -> View {
    return Assembler.shared.resolver.resolve(View.self, argument: context)!
  }

  static func buildModule<Coordinator>(coordinator: Coordinator) -> View {
    return Assembler.shared.resolver.resolve(View.self, argument: coordinator)!
  }

  class func buildModule<Context, Coordinator>(context: Context, coordinator: Coordinator) -> View {
    return Assembler.shared.resolver.resolve(View.self, arguments: context, coordinator)!
  }
}
