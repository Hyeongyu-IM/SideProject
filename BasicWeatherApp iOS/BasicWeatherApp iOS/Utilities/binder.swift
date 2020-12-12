//
//  binder.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/07.
//

import Foundation

final class Binder<T> {
  
  typealias Listener = (T) -> Void
    
  var listener: Listener?
  
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  init(_ value: T) {
    self.value = value
  }

  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
