import UIKit

extension UINavigationBar {
  func setupBarStyle() {
    let baseColor = UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0)
    let navBarTextAttr = [NSAttributedString.Key.foregroundColor: baseColor]

    isTranslucent = true
    prefersLargeTitles = true
    tintColor = baseColor
    titleTextAttributes = navBarTextAttr
    largeTitleTextAttributes = navBarTextAttr
    layoutIfNeeded()
  }
}
