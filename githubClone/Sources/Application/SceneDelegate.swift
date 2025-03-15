//import UIKit
//
//import RxRelay
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    
//    var window: UIWindow?
//    static let githubCodeRelay = PublishRelay<String>()
//    
//    func scene(
//        _ scene: UIScene,
//        willConnectTo session: UISceneSession,
//        options connectionOptions: UIScene.ConnectionOptions
//    ) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        
//        if let _ = UserDefaults.standard.string(forKey: "accessToken") {
////            let tabBarController = TabBarController()
////            window.rootViewController = tabBarController
////            window.rootViewController = UINavigationController(rootViewController: RepoViewController())
//          
//        } else {
//            let loginViewController = LoginViewController()
//            window.rootViewController = loginViewController
//        }
//        
//        self.window = window
//        window.makeKeyAndVisible()
//    }
//    
//    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        if let url = URLContexts.first?.url {
//            if url.absoluteString.starts(with: "githubclone://") {
//                if let githubCode = url.absoluteString.split(separator: "=").last.map({
//                    String($0)
//                }) {
//                    SceneDelegate.githubCodeRelay.accept(githubCode)
//                }
//            }
//        }
//    }
//}
//
//
