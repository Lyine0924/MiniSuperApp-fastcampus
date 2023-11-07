//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by Lyine on 2023/11/07.
//

import Foundation

struct Formatter {
	static let balanceFormatter: NumberFormatter = {
		let f = NumberFormatter()
		f.numberStyle = .decimal
		return f
	}()
}
