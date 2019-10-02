//
//  GithubSwiftReposTests.swift
//  GithubSwiftReposTests
//
//  Created by João Gabriel de Britto e Silva on 27/09/19.
//  Copyright © 2019 JGBrittoS. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import GithubSwiftRepos

class GithubSwiftReposTests: QuickSpec {
    private var sut: RepoListViewModel!
    private var mockView: MockView! {
        didSet {
            self.sut.set(view: mockView)
        }
    }
    private var mockRepository: MockRepository! {
        didSet {
            self.sut.set(repository: mockRepository)
        }
    }
    private lazy var repoList: RepoList = {
        return Util<RepoList>().decode(from: "mock_page_1")!
    }()
    
    override func spec() {
        describe("Testing ViewModel, because it is the Business Logic main container") {
            beforeEach {
                self.sut = RepoListViewModel()
                self.mockView = MockView()
                self.mockRepository = MockRepository()
                expect(self.mockView.setViewModelWasCalled).to(beTrue())
            }
            
            context("Fetching with success Github API") {
                beforeEach {
                    self.mockRepository.result = .success(self.repoList)
                    self.sut.fetchList()
                }
                
                it("should call repository") {
                    expect(self.mockRepository.fetchRepoListWasCalled).to(beTrue())
                }
                
                it("should show repos on view") {
                    expect(self.mockView.showReposWasCalled).to(beTrue())
                    expect(self.mockView.repos).notTo(beNil())
                }
            }
            
            context("Fetching with success Github API infinite scroll") {
                beforeEach {
                    self.mockRepository.result = .success(self.repoList)
                    self.sut.fetchList()
                }
                
                it("should call repository") {
                    expect(self.mockRepository.fetchRepoListWasCalled).to(beTrue())
                }
                
                it("should show 4 repos on view") {
                    expect(self.mockView.repos).to(haveCount(8))
                }
                    
                it("should show new repos on view after infinite scroll") {
                    self.sut.fetchNewRepos()
                    expect(self.mockView.repos).to(haveCount(8))
                }
            }
            
            context("Fetching Github API has failed") {
                beforeEach {
                    self.mockRepository.result = .failure(nil)
                    self.sut.fetchList()
                }
                
                it("should call repository") {
                    expect(self.mockRepository.fetchRepoListWasCalled).to(beTrue())
                }
                
                it("should not have any repo to show") {
                    expect(self.mockView.repos).to(beNil())
                }
            }
        }
    }
}

private class MockView: RepoListViewDelegate {
    var setViewModelWasCalled = false
    var showReposWasCalled = false
    var repos: [Repo]?
    
    func set(viewModel: RepoListViewModelDelegate) {
        setViewModelWasCalled = true
    }
    
    func show(repos: [Repo]) {
        showReposWasCalled = true
        self.repos = repos
    }
}

private class MockRepository: FetchListRepositoryProtocol {
    enum FetchEvent {
        case success(RepoList)
        case failure(Error?)
    }
    
    var result: FetchEvent?
    var fetchRepoListWasCalled = false
    
    func fetchRepoList(page: Int, success: @escaping (RepoList) -> Void, failure: @escaping (Error?) -> Void) {
        fetchRepoListWasCalled = true
        
        switch result {
        case let .success(repoList):
            success(repoList)
        case let .failure(error):
            failure(error)
        case .none:
            break
        }
    }
}
