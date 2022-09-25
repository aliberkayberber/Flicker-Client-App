//
//  Photos.swift
//  Flickr Client App
//
//  Created by Ali Berkay BERBER on 1.09.2022.
//

import Foundation

struct Photos: Codable {
  let  page: Int?
  let  pages: Int?
  let  perpage: Int?
  let  total: Int?
  let  photo: [Photo]?
}
