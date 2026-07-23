//
//  TabBarController.swift
//  FirstAPI
//
//  Created by Servan on 01.07.26.
//
import UIKit
final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            npcontroller, wlcontroller
        ]
    }
    private lazy var npcontroller: UIViewController = {
        let vc =  ViewController(
            viewModel: [
                NowPlayingListViewModel(),
                UpcomingListViewModel(),
                TopRatedListViewModel(),
                PopularListViewModel(),
                TrendMovieListViewModel()
            ],
            
            watchlistmodel: WatchListViewModel()
        )
        vc.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        return vc
    }()
    private lazy var wlcontroller: UIViewController = {
        let vc = WatchListController(viewModel: WatchListViewModel())
        vc.tabBarItem = UITabBarItem(title: "WatchList", image: nil, tag: 0)
        return vc
    }()
}
 
