import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener, CardOnFileDashboardListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
	func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
	
	private let superPayDashboardBuildable: SuperPayDashboardBuildable
	private var superPayRouting: Routing?
	
	private let cardOnFileDashboardBuidable: CardOnFileDashboardBuildable
	private var cardOnFileRouting: Routing?
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(
		interactor: FinanceHomeInteractable,
		viewController: FinanceHomeViewControllable,
		superPayDashboardBuildable: SuperPayDashboardBuildable,
		cardOnFileDashboardBuidable: CardOnFileDashboardBuildable
	) {
		self.superPayDashboardBuildable = superPayDashboardBuildable
		self.cardOnFileDashboardBuidable = cardOnFileDashboardBuidable
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
	
	func attahSuperPayDashboard() {
		
		if superPayRouting != nil {
			return
		}
		
		let router = superPayDashboardBuildable.build(withListener: interactor)
		
		// add subview
		let dashboard = router.viewControllable
		viewController.addDashboard(dashboard)
		
		self.superPayRouting = router
		attachChild(router)
	}
	
	func attachCardOnFileDashboard() {
		if cardOnFileRouting != nil {
			return
		}
		
		let router = cardOnFileDashboardBuidable.build(withListener: interactor)
		
		let viewControllable = router.viewControllable
		viewController.addDashboard(viewControllable)
		
		self.cardOnFileRouting = router
		
		attachChild(router)
	}
}
