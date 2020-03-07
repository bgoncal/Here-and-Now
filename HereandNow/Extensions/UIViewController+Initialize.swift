import UIKit

extension UIViewController {
  static func initializeOnMainStoryBoard<T>() -> T where T: UIViewController {
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    return mainStoryBoard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
  }
}
