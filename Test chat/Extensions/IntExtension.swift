//
//  IntExtension.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 09/08/2019.
//  Copyright © 2019 Yuri Kudrinetskiy. All rights reserved.
//

import Foundation

extension Int {
    func withPluralForm(form1: String, form2: String, form5: String) -> String {
        return stringWithSpaces + " " + pluralForm(form1: form1, form2: form2, form5: form5)
    }

    private func pluralForm(form1: String, form2: String, form5: String) -> String {
        let n = labs(self) % 100
        let n1 = Int(n % 10)
        if (n > 10 && n < 20) { return form5 }
        if (n1 > 1 && n1 < 5) { return form2 }
        if (n1 == 1) { return form1 }
        return form5
    }
}
