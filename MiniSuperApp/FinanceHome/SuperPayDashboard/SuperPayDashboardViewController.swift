	//
	//  SuperPayDashboardViewController.swift
	//  MiniSuperApp
	//
	//  Created by Lyine on 2022/03/08.
	//

import ModernRIBs
import UIKit

protocol SuperPayDashboardPresentableListener: AnyObject {
		// TODO: Declare properties and methods that the view controller can invoke to perform
		// business logic, such as signIn(). This protocol is implemented by the corresponding
		// interactor class.
}

final class SuperPayDashboardViewController: UIViewController, SuperPayDashboardPresentable, SuperPayDashboardViewControllable {
	
	weak var listener: SuperPayDashboardPresentableListener?
	
	private let headerStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .fill
		stackView.distribution = .equalSpacing
		stackView.axis = .horizontal
		return stackView
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 22, weight: .semibold)
		label.text = "슈퍼페이 잔고"
		return label
	}()
	
	private lazy var topupButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("충전하기", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.addTarget(self, action: #selector(topupButtonDidTap), for: .touchUpInside)
		return button
	}()
	
	private let balanceStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .fill
		stackView.distribution = .equalSpacing
		stackView.axis = .horizontal
		stackView.spacing = 4
		return stackView
	}()
	
	private let currencyLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 22, weight: .semibold)
		label.text = "원"
		label.textColor = .white
		return label
	}()
	
	private let balanceAmountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 22, weight: .semibold)
		label.textColor = .white
		return label
	}()
	
	init() {
		super.init(nibName: nil, bundle: nil)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupViews()
	}
	
	private func setupViews() {
		view.addSubview(headerStackView)
		view.addSubview(cardView)
		
		cardView.addSubview(balanceStackView)
		
		[titleLabel, topupButton].forEach {
			self.headerStackView.addArrangedSubview($0)
		}
		
		[balanceAmountLabel, currencyLabel].forEach {
			self.balanceStackView.addArrangedSubview($0)
		}
		
		NSLayoutConstraint.activate([
			headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
			headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			
			cardView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
			cardView.heightAnchor.constraint(equalToConstant: 180),
			cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
			
			balanceStackView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
			balanceStackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
		])
	}
	
	private let cardView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 16
		view.layer.cornerCurve = .continuous
		view.backgroundColor = .systemIndigo
		return view
	}()
	
	@objc
	private func topupButtonDidTap() {
		
	}
}
