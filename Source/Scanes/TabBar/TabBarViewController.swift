//
//  TabBarViewController.swift
//  MovieApp
//
//  Created by AliEren on 15.06.2022.
//

import Foundation
import UIKit

//final class TabBarViewController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupAppearance()
//        setupNavigation()
//
//    }
//
//    // MARK: - SetupNavigation
//    func setupNavigation() {
//        let homeViewController = MovieListViewController()
//        let favoriteViewController = FavoriteMoviesListViewController()
//        let viewControllerList = [homeViewController, favoriteViewController]
//        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
//        guard let items = tabBar.items else { return }
//        let images = ["house", "star"]
//        for counter in 0...1 {
//            items[counter].image = UIImage(systemName: images[counter])
//        }
//        tabBarController?.navigationItem.titleView?.isHidden = true
//    }
//
//    // MARK: - SetupAppearance
//    func setupAppearance() {
//        self.tabBar.backgroundColor = Colors.lightGrey
//        self.tabBar.isTranslucent = false
//        let blur = UIBlurEffect(style: UIBlurEffect.Style.light)
//        let blurView = UIVisualEffectView(effect: blur)
//        blurView.frame = self.tabBar.bounds
//        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.tabBar.addSubview(blurView)
//    }
//
//}



class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        if item.tag == 0 { // tab1(home)
            item.title = "Movies"
            tabBar.items?[1].title = ""
        }

        if item.tag == 1 { // tab2(search)
            item.title = "Favorites"
            tabBar.items?[0].title = ""
        }
    }
    
    // MARK: - SetupAppearance
    func setupAppearance() {
        self.tabBar.backgroundColor = Colors.lightGrey
        self.tabBar.isTranslucent = false
        let blur = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.tabBar.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tabBar.addSubview(blurView)
    }
    
    func setupNavigationBar() {
        let tab1 = MovieListViewController()
        let tab1BarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        tab1.tabBarItem = tab1BarItem
        tab1.tabBarItem.tag = 0
        let nav1 = UINavigationController()
        nav1.viewControllers = [tab1]

        let tab2 = FavoriteMoviesListViewController()
        let tab2BarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        tab2.tabBarItem = tab2BarItem
        tab2.tabBarItem.tag = 1
        let nav2 = UINavigationController()
        nav2.viewControllers = [tab2]
        
        self.viewControllers = [nav1, nav2]
        
    }

}
