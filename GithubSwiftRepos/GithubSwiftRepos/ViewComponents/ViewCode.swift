import UIKit

protocol ViewCode: UIView {
    func build()
    func buildViewHierarchy()
    func buildConstraints()
    func finalSetup()
}

extension ViewCode {
    func build() {
        buildViewHierarchy()
        buildConstraints()
        finalSetup()
    }
    
    func finalSetup() {}
}
