//
//  ViewController.swift
//  GitTrends
//
//  Created by Ravikumar, Gowtham.
//

import UIKit

class GitTrendingViewController: UIViewController {
    private var presenter: GitPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
    }

    private func setUp() {
        self.title = "Github Trends"
        let view = gitTrendingView()
        let navigator = GitTrendingViewNavigator(navigation: self.navigationController)
        let service = APIService()
        let useCase = GitTrendingUseCase(apiService: service, cache: DiskURLCache.default)
        presenter = GitTrendingViewPresenter(displayer: view,
                                             navigator: navigator,
                                             useCase: useCase)
        presenter?.startPresenting()
    }

    private func gitTrendingView() -> GitTrendingView {

        let view = GitTrendingView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: self.view.frame.width,
                                                 height: self.view.frame.height))
        self.view.addSubview(view)
        return view
    }

    deinit {
        presenter?.stopPresenting()
    }
}
