import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  private let assembler = Assembler.createAssembly()
  private var appCoordinator: AppCoordinatorProtocol!
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    appCoordinator = assembler.resolver.resolve(AppCoordinatorProtocol.self)!
    appCoordinator.window = window
    appCoordinator.start()
    window?.makeKeyAndVisible()
    return true
  }
}
