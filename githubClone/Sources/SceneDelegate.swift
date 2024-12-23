import UIKit
 
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
 
        let viewController = LoginViewController()
        
        self.window = window
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            if let url = URLContexts.first?.url {
                if url.absoluteString.starts(with: "githubclone://") {
                    if let code = url.absoluteString.split(separator: "=").last.map({
                        String($0)
                    }) {
                        LoginManager.shared.getAccessToken(code: code)
                    }
                }
            }
        }
}
