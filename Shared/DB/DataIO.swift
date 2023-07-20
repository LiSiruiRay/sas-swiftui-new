//
// DataIO.swift
// SAS
//
// Created by Ray on 7/19/23.
// Copyright © 2021 Google LLC.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import FirebaseCore
import FirebaseFirestore

class DataReader {
    @Published var db = Firestore.firestore()
    func getDateTest() {
        print("getDateTest called")
        let one_collection = db.collection("Meta")
        print("collection: \(one_collection)")
        
        let one_doc = one_collection.document("metadata")
        print("one doc: \(one_doc)")
        print("one doc id: \(one_doc.documentID)")
        
        db.collection("Meta/metadata/News").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
}
