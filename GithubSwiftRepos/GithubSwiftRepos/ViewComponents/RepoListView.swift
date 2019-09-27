import UIKit

final class RepoListView: UIView {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        build()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension RepoListView: ViewCode {
    func buildViewHierarchy() {
        
    }
    
    func buildConstraints() {
        
    }
}
