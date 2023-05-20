//
//  WARMUP.swift
//  FitnessApp
//
//  Created by Mac on 2023-05-20.
//

import Firebase
import FirebaseFirestore

struct WARMUP {
    let exe_name: String
    let exe_des: String
    let exe_hours: Int
    let exe_rep: Int

    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data()
        exe_name = snapshotValue["exe_name"] as! String
        exe_des = snapshotValue["exe_des"] as! String
        exe_hours = snapshotValue["exe_hours"] as! Int
        exe_rep = snapshotValue["exe_rep"] as! Int
    }
}
