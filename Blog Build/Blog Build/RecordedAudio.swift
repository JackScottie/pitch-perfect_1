//
//  RecordedAudio.swift
//  Blog Build
//
//  Created by Jack on 3/27/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}