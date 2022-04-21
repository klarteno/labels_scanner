import 'dart:io';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:labels_scanner/app_component/data/store.dart';

class AppwriteService with ChangeNotifier {
  final appWriteEndPoint = 'https://localhost/v1';
  final projectId = '616e3d7396bfb';

  final userCollectionId = '617497ffb09f7';
  final userActivitiesCollectionId = '6174984332af8';
  final challengesCollectionId = '617872e12c3d8';
  final leaderboardCollectionId = '617873ddacaec';
  final uuid = const Uuid();

  late String _loggedInUserId;
  late String _loggedInUserName;
  late String _loggedInUserEmail;
  late String _loggedInUserDocId;

  final Client _client = Client();
  late Account _account;
  late Database _database;

  User? _current;
  User? get current => _current;

  Session? _session;
  Session? get session => _session;

  AppwriteService() {
    _client
        .setEndpoint(appWriteEndPoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
    _account = Account(_client);
    _database = Database(_client);
  }

  signIn({required String email, required String password}) async {
    try {
      _session = await _account
          .createSession(email: email, password: password)
          .catchError((error) {
        debugPrint('Error while signing up');
        debugPrint(error.toString());
        throw (error);
      });
    } catch (_e) {
      _session = null;
      throw Exception("Failed to register");
    }

    _loggedInUserId = session!.userId;
    debugPrint(session.toString());

    getLoggedInUserDetails();
    Store.set("session", json.encode(_session!.toMap()));

    notifyListeners();
  }

  getLoggedInUserDetails() async {
    debugPrint('Logged in user is $_loggedInUserId');

    Future<DocumentList> docListF = _database.listDocuments(
        collectionId: userCollectionId,
        queries: [
          Query.equal('user_id', _loggedInUserId)
        ], //['user_id=$_loggedInUserId'],
        limit: 1);

    var xxxxx = await _database.listDocuments(
        collectionId: userCollectionId,
        queries: [
          Query.equal('user_id', _loggedInUserId)
        ], //['user_id=$_loggedInUserId'],
        limit: 1);

    await docListF.then((docList) {
      debugPrint(docList.documents.length.toString());
      _loggedInUserName = docList.documents[0].data['user_name'];
      _loggedInUserEmail = docList.documents[0].data['email'];
      _loggedInUserDocId = docList.documents[0].$id;
    }).catchError((error) {
      debugPrint('Error while reading user details');
      debugPrint(error.toString());
    });
  }

  signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final result = await _account
          .create(
              userId: 'unique()', email: email, password: password, name: name)
          .catchError((error) {
        debugPrint('Error while signing up');
        debugPrint(error.toString());
        throw (error);
      });

      _current = result;
      notifyListeners();
    } catch (_e) {
      throw Exception("Failed to register");
    }
    //sleep(const Duration(seconds: 1));
  }

  void createNewChallenge(
      {required String challengeName, required String measureType}) async {
    try {
      String challengeId = uuid.v4();
      Document challengeDoc = await _database.createDocument(
        collectionId: challengesCollectionId,
        data: {
          'challenge_id': challengeId,
          'challenge_name': challengeName,
          'measure_type': measureType
        },
        read: ['*'],
        write: ['*'],
        documentId: "unique()",
      );
      debugPrint(challengeDoc.toString());
      debugPrint('New challenge created');

      Document leaderboardDoc = await _database.createDocument(
        collectionId: leaderboardCollectionId,
        data: {
          'challenge_id': challengeId,
          'challenge_name': challengeName,
          'user_id': _loggedInUserId,
          'user_name': _loggedInUserName,
          'email': _loggedInUserEmail,
          'rank': 0,
          'measure_type': measureType,
          'value': 0
        },
        read: ['*'],
        write: ['*'],
        documentId: "unique()",
      );
      debugPrint('Added the user to leaderboard for the new challenge');
      debugPrint(leaderboardDoc.toString());
    } catch (e) {
      debugPrint('Error while creating new challenge or leaderboard doc');
      debugPrint(e.toString());
    }
  }

  Future<DocumentList> getUserChallenges() async {
    debugPrint('User id is: $_loggedInUserId');
    DocumentList docList =
        await _database.listDocuments(collectionId: leaderboardCollectionId,
            // filters: ['user_id=$_loggedInUserId'],
            queries: [Query.equal('user_id', _loggedInUserId)]);

    debugPrint('Total documents are: ${docList.documents.length}');

    return docList;
  }

  Future<DocumentList> getLeaderBoard(String challengeId) async {
    debugPrint('Challenge id is: $challengeId');
    DocumentList docList =
        await _database.listDocuments(collectionId: leaderboardCollectionId,
            //filters: ['challenge_id=$challengeId'],
            queries: [Query.equal('user_id', _loggedInUserId)]);

    debugPrint('Total documents are: ${docList.documents.length}');

    return docList;
  }

  inviteUserToChallenge({
    required String email,
    required String challengeId,
    required String challengeName,
    required String measureType,
  }) async {
    try {
      DocumentList docList = await _database.listDocuments(
        collectionId: userCollectionId,
        //filters: ['email=$email'],
        queries: [Query.equal('email', email)],
        limit: 1,
      );

      if (docList.documents.isEmpty) {
        throw (Exception("User doesn't exist"));
      }

      String userId = docList.documents[0].data['user_id'];
      String userName = docList.documents[0].data['user_name'];
      debugPrint('User id is: $userId');
      Document userChallengeDoc = await _database.createDocument(
        collectionId: leaderboardCollectionId,
        data: {
          'challenge_id': challengeId,
          'challenge_name': challengeName,
          'user_id': userId,
          'user_name': userName,
          'email': email,
          'rank': 0,
          'measure_type': measureType,
          'value': 0
        },
        read: ['*'],
        write: ['*'],
        documentId: "unique()",
      );
      debugPrint('User challenge doc created');
      debugPrint(userChallengeDoc.toString());
    } catch (e) {
      debugPrint('Error while creating new challenge');
      debugPrint(e.toString());
      throw (e.toString());
    }
  }

  createUserActivity(String userId, String measureType, int value) async {
    try {
      debugPrint('Logged in user inside createActivity fn: $userId');
      Document userActivityDoc = await _database.createDocument(
        collectionId: userActivitiesCollectionId,
        data: {'user_id': userId, 'measure_type': measureType, 'value': value},
        read: ['*'],
        write: ['*'],
        documentId: "unique()",
      );
    } catch (e) {
      debugPrint('Error while creating user activity document');
      debugPrint(e.toString());
      throw (e.toString());
    }
  }
}
