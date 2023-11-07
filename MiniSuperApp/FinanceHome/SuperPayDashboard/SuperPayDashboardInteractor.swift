//
//  SuperPayDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by Lyine on 2022/03/08.
//

import Foundation
import ModernRIBs
import Combine

protocol SuperPayDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashboardPresentable: Presentable {
    var listener: SuperPayDashboardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
	
		func updateBalance(_ balance: String)
}

protocol SuperPayDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol SuperPayDashboardInteractorDependency {
	var balance: ReadOnlyCurrentValuePublisher<Double> { get }
	var formatter: NumberFormatter { get }
}

final class SuperPayDashboardInteractor: PresentableInteractor<SuperPayDashboardPresentable>, SuperPayDashboardInteractable, SuperPayDashboardPresentableListener {

    weak var router: SuperPayDashboardRouting?
    weak var listener: SuperPayDashboardListener?
	
		private let dependency: SuperPayDashboardInteractorDependency
	
	private var cancellables: Set<AnyCancellable>

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
			presenter: SuperPayDashboardPresentable,
			dependency: SuperPayDashboardInteractorDependency
		) {
			self.dependency = dependency
			self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
			dependency.balance.sink { [weak self] balance in
				self?.dependency.formatter.string(from: NSNumber(value: balance)).map {
					self?.presenter.updateBalance($0)
				}
			}.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
