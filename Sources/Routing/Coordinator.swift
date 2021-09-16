//
//  Coordinator.swift
//
//
//  Created by Михаил Серегин on 16.09.2021.
//

import UIKit

public protocol Coordinator: AnyObject {
    // Обрабатывается по умолчанию в методе finish()
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    // то что отвечает за навигацию
    var navigationController: UINavigationController { get set }
    
    // Дочерние ккординаторы
    var childCoordinators: [Coordinator] { get set }
    
    // тип координатора, можно потом расширить до enum чтобы удобно было управлять завершением координатора и определять, дополнительную логику в зависимости от координатора
    var type: String { get }
    // В этот метода обычно вызывается первый экран флоу
    func start()
    
    // выполняется по завершению флоу
    func finish()
    
    // можно добавить базовый действия с навигацией, например dismiss()
    func dismiss()
    
    init(_ navigationController: UINavigationController)
}

public extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

public extension Coordinator {
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - CoordinatorOutput
public protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
