//
//  String+Extensions.swift
//  Memorize
//
//  Created by 4gt10 on 25.12.2023.
//

import Foundation

extension String {
    func localized(args: CVarArg...) -> String {
        String.localizedStringWithFormat(localized(), args)
    }
    
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}
