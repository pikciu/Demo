import UIKit

extension NSMutableAttributedString {
    
    public func append(_ attachment: NSTextAttachment) {
        append(NSAttributedString(attachment: attachment))
    }
    
    public func append(_ string: String) {
        append(NSAttributedString(string: string))
    }
}
