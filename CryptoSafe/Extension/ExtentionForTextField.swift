
import UIKit

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
    
    func outdent(size: CGFloat) {
        self.rightView = UIView(frame: CGRect(x: self.frame.maxX, y: self.frame.minY, width: size, height: self.frame.height))
        self.rightViewMode = .always
    }
}
