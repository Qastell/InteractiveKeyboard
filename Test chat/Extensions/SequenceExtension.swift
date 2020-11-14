//
//  SequenceExtension.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 27/07/2019.
//  Copyright © 2019 Yuri Kudrinetskiy. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element : Hashable {
    func intersects<S : Sequence>(with sequence: S) -> Bool where S.Iterator.Element == Iterator.Element {
        let sequenceSet = Set(sequence)
        return contains(where: sequenceSet.contains)
    }
}
