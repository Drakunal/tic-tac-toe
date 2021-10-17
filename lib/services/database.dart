import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class DatabaseService {
  final String gameId;

  DatabaseService({required this.gameId});

  //collection reference
  //creates a collection if not present, else makes the collection reference

  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection("onlinePlayers");
  //link is made with the collection named transactions

  Future addPlayers(int uidCount, String gameId, int numberOfSquares) async {
    return await transactionCollection.doc(gameId).set({
      'uidCount': uidCount, //1
      'gameId': gameId, //random,this is doc id
      'numberOfSquares': numberOfSquares, //3
      'm0': '',
      'm1': '',
      'm2': '',
      'm3': '',
      'm4': '',
      'm5': '',
      'm6': '',
      'm7': '',
      'm8': '',
    });
  }

  // Stream<List<t.Transaction>> transactions(String filterBy) {
  //   // print("Hi this is the $uid");
  //   // return transactionCollection
  //   //     .where('userId', isEqualTo: uid)
  //   //     .orderBy('date')
  //   //     .snapshots()
  //   //     .map(_transactionListFromSnapshot);

  //   String filterText = '';
  //   if (filterBy == 'Important') {
  //     filterText = '#ffbf00';
  //     print("Filter Text is $filterBy");
  //     return transactionCollection
  //         .where('userId', isEqualTo: uid)
  //         .where('star', isEqualTo: filterText)
  //         .orderBy('date')
  //         .snapshots()
  //         .map(_transactionListFromSnapshot);
  //   } else {
  //     print("Filter Text is $filterBy");
  //     return transactionCollection
  //         .where('userId', isEqualTo: uid)
  //         .orderBy('date')
  //         .snapshots()
  //         .map(_transactionListFromSnapshot);
  //   }
  // }

  // List<t.Transaction> _transactionListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     // print(doc.id);
  //     Color temp = HexColor(doc.get('star') ?? '#808080');
  //     return t.Transaction(
  //         id: doc.id,
  //         amount: doc.get('amount') ?? 0,
  //         details: doc.get('details') ?? ' ',
  //         type: doc.get('mode') ?? '',
  //         date: doc.get('date').toDate() ?? DateTime.now(),
  //         star: temp);
  //   }).toList();
  // }

  Future updateField(String m, String value) async {
    return await transactionCollection.doc(gameId).update({m: value});
  }

  Future joinPlayers() async {
    final snapShot = await transactionCollection.doc(gameId).get();
    if (snapShot.exists) {
      return await transactionCollection.doc(gameId).update({'uidCount': 2});
    }
  }
}
