import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/onlineplayer.dart';

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
      'lobbyExists': true,
    });
  }

  Stream<List<OnlinePlayer>> transactions() {
    return transactionCollection
        .where('gameId', isEqualTo: gameId)
        .snapshots()
        .map(_gameFromSnapshot);
  }

  List<OnlinePlayer> _gameFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return OnlinePlayer(
          lobbyExists: doc.get('lobbyExists') ?? false,
          uidCount: doc.get('uidCount') ?? 1,
          gameId: doc.get('gameId') ?? 'sample',
          numberOfSquares: doc.get('numberOfSquares') ?? 3,
          m0: doc.get('m0') ?? '',
          m1: doc.get('m1') ?? '',
          m2: doc.get('m2') ?? '',
          m3: doc.get('m3') ?? '',
          m4: doc.get('m4') ?? '',
          m5: doc.get('m5') ?? '',
          m6: doc.get('m6') ?? '',
          m7: doc.get('m7') ?? '',
          m8: doc.get('m8') ?? '');
    }).toList();
  }

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
