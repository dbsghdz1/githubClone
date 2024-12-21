//
//  ViewModelType.swift
//  githubClone
//
//  Created by 김윤홍 on 12/21/24.
//

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}
