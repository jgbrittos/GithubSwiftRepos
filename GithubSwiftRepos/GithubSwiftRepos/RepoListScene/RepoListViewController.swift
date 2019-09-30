import UIKit

final class RepoListViewController: UIViewController {
    override func loadView() {
        view = setup()
    }
    
    private func setup() -> UIView {
        let view = RepoListView()
        let viewModel = RepoListViewModel()
        let repository = FetchListRepository(with: RequestManager())
        viewModel.set(repository: repository)
        
        return view
    }
}
