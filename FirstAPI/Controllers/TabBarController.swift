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
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return vc
    }()
    private lazy var wlcontroller: UIViewController = {
        let vc = WatchListController(viewModel: WatchListViewModel())
        
        let icon = UIImage(named: "save")?
            .resized(to: CGSize(width: 24, height: 24))
            .withRenderingMode(.alwaysTemplate)
        
        vc.tabBarItem = UITabBarItem(title: "WatchList", image: icon, tag: 1)
        return vc
    }()
}
 
