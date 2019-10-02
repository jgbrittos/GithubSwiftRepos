import UIKit

final class RepoListViewController: UIViewController {
    
    private var viewModel: RepoListViewModelDelegate?
    
    override func loadView() {
        view = setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchList()
    }
    
    private func setup() -> UIView {
        let view = RepoListView()
        let repository = FetchListRepository()
        viewModel = RepoListViewModel()
        viewModel?.set(repository: repository)
        viewModel?.set(view: view)
        return view
    }
}
