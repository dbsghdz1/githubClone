//
//  TabBarController.swift
//  githubClone
//
//  Created by 김윤홍 on 12/22/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
    }
    
    private func viewConfig() {
        let viewControllers = TabbarItem.allCases.map { item -> UINavigationController in
            let vc = item.viewController
            vc.view.backgroundColor = .systemBackground
            vc.navigationItem.title = item.navigtaionItemTitle
            vc.navigationItem.largeTitleDisplayMode = .always
            
            
            let nav = UINavigationController(rootViewController: vc)
            nav.title = item.navigtaionItemTitle
            nav.tabBarItem.image = item.tabbarImage
            nav.navigationBar.prefersLargeTitles = true
            
            return nav
        }
        setViewControllers(viewControllers, animated: false)
        tabBar.tintColor = UIColor.blue
    }
    
}

extension TabBarController {
    
    enum TabbarItem: CaseIterable {
        case home
        case noti
        case search
        case profile
        
        var viewController: UIViewController {
            switch self {
            case .home:
                return RepoViewController()
            case .noti:
                return RepoViewController()
            case .search:
                return RepoViewController()
            case .profile:
                return RepoViewController()
            }
        }
        
        var tabbarImage: UIImage? {
            switch self {
            case .home:
                return UIImage(systemName: "house.fill")
            case .noti:
                return UIImage(systemName: "house.fill")
            case .search:
                return UIImage(systemName: "house.fill")
            case .profile:
                return UIImage(systemName: "house.fill")
            }
        }
        
        var navigtaionItemTitle: String {
            switch self {
            case .home:
                return "홈"
            case .noti:
                return "알림"
            case .search:
                return "탐색"
            case .profile:
                return "프로필"
            }
        }
    }
}
