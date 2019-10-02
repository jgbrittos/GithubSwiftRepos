import UIKit

final class RepoTableViewDataSource: NSObject {
    
    private(set) var repoList: [Repo] = []
    
    func set(_ list: [Repo]) {
        self.repoList = list
    }
    
    func clear() {
        self.repoList.removeAll()
    }
}

extension RepoTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension RepoTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "RepoItemTableViewCell", for: indexPath) as? RepoItemTableViewCell
            else { return UITableViewCell() }
        
        cell.set(repo: repoList[indexPath.row])
        
        return cell
    }
}
