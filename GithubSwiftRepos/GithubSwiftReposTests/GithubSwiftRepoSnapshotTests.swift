import Quick
import Nimble
import Nimble_Snapshots
@testable import GithubSwiftRepos

final class GithubSwiftRepoSnapshotTests: QuickSpec {
    private lazy var repoList: RepoList = {
        return Util<RepoList>().decode(from: "mock_page_1")!
    }()
    
    override func spec() {

        describe("Testing Repo list view") {
            var sut: RepoListView!
    
            context("Test view with list of repos") {
                beforeEach {
                    sut = RepoListView()
                    sut.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
                    sut.show(repos: self.repoList.items)
                }

                it("should have the expected appearance") {
                    expect(sut) == snapshot()
                }
            }
        }
    }
}
