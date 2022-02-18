//
//  MessagedErrorr.swift
//  CollectionViewTest
//
//  Created by Majit Uteniyazov on 18/02/22.
//

import Foundation

struct MessagedErrorr: LocalizedError {
    let message: String
    var errorDescription: String? { message }
}
