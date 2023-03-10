//
//  WireframeProtocols.swift
//  CabifyProducts
//
//  Created by Òscar Muntal on 22/2/23.
//

import UIKit

protocol RootAwareWireframe: AnyObject {
    var rootViewController: UINavigationController? { get set }
    func setRoot(viewController: @escaping @autoclosure () -> UINavigationController)
}

extension RootAwareWireframe {
    func setRoot(viewController: @escaping @autoclosure () -> UINavigationController) {
        self.rootViewController = viewController()
    }
}

protocol Pushable {
    func push(viewController: @escaping @autoclosure () -> UIViewController)
}

extension Pushable where Self: RootAwareWireframe {
    func push(viewController: @escaping @autoclosure () -> UIViewController) {
        DispatchQueue.main.async {
            let viewController = viewController()
            self.rootViewController?.pushViewController(viewController, animated: true)
        }
    }
}

protocol Presentable {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

extension Presentable {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
}
