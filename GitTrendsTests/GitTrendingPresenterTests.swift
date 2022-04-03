//
//  GitTrendingPresenterTests.swift
//  GitTrendsTests
//
//  Created by Ravikumar, Gowtham.
//

import XCTest
import UIKit
@testable import GitTrends

class GitTrendingPresenterTests: XCTestCase {
    private var presenter: GitPresenter?
    private let nav = UINavigationController()
    private let useCase = GitTrendingUseCaseSpy()
    private let view = GitTrendingView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: 100,
                                                     height: 100))

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testGitTrendingPresenter() {
        let navigator = GitTrendingViewNavigator(navigation: nav)
        presenter = GitTrendingViewPresenter(displayer: view,
                                             navigator: navigator,
                                             useCase: useCase)
        presenter?.startPresenting()
    }

    func testGitDetail() {
        let navigator = GitTrendingViewNavigator(navigation: nav)
        let model = GitTrendingRowViewModel(author: "", authorIcon: "", authorName: "", description: "", starCount: "", forkCount: "", repoURL: "")
        let row = GitTrendingRow.gitTrendingDetails(viewModel: model)
        navigator.toGitDetailView(model: row)
        XCTAssertTrue(nav.topViewController is GitDetailViewController)
    }

    func testUseCase() {
        let factory = GitTrendingViewModelFactory()
        useCase.fetchTopGitTrending(with: { (result) in
            switch result {
            case .success(let repos):
                let result = factory.viewModel(for: repos)
                XCTAssertTrue(result.rows.count > 0)
            case .failure: break
            }
        }, forcely: true)
    }

    func testRow() {
        let aModel = GitTrendingRowViewModel(author: "name", authorIcon: "", authorName: "Dinesh", description: "", starCount: "", forkCount: "", repoURL: "")
        let bModel = GitTrendingRowViewModel(author: "name", authorIcon: "", authorName: "Gowtham", description: "", starCount: "", forkCount: "", repoURL: "")
        let aRow = GitTrendingRow.gitTrendingDetails(viewModel: aModel)
        let bRow = GitTrendingRow.gitTrendingDetails(viewModel: bModel)

        XCTAssertTrue(aRow == bRow)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
