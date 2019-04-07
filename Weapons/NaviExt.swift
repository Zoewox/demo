import UIKit

extension UINavigationController {
    //将子页面的状态条样式设置为由最上层控制器提供，即本身
    open override var childForStatusBarStyle: UIViewController?{
        return topViewController
    }
}


