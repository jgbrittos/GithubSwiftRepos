import UIKit

final class RepoCell: UIView {
    
    private let photoImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        build()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension RepoCell: ViewCode {
    func buildViewHierarchy() {
        
    }
    
    func buildConstraints() {
        
    }
}
