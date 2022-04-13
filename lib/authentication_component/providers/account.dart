import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:labels_scanner/authentication_component/data/store.dart';

import '../services/client.dart';

class AccountProvider extends ChangeNotifier {
  User? _current;
  User? get current => _current;

  Session? _session;
  Session? get session => _session;

  late String _loggedInUserId;

  Future<Session?> get _cachedSession async {
    final cached = await Store.get("session");

    if (cached == null) {
      return null;
    }

    return Session.fromMap(json.decode(cached));
  }

  Future<bool> isValid() async {
    if (session == null) {
      final cached = await _cachedSession;

      if (cached == null) {
        return false;
      }

      _session = cached;
    }

    return _session != null;
  }

  Future<void> register(String email, String password, String? name) async {
    try {
      final result = await ApiClient.account.create(
          userId: 'unique()', email: email, password: password, name: name);

      _current = result;

      notifyListeners();
    } catch (_e) {
      throw Exception("Failed to register");
    }
  }

  signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final result = await ApiClient.account
          .create(
              userId: 'unique()', email: email, password: password, name: name)
          .catchError((error) {
        debugPrint('Error while signing up');
        debugPrint(error.toString());
        throw (error);
      });

      debugPrint('signing up:');

      debugPrint(result.toString());
      _current = result;

      notifyListeners();
    } catch (_e) {
      throw Exception("Failed to register");
    }
    //sleep(const Duration(seconds: 1));
  }

  Future<void> login(String email, String password) async {
    try {
      final result = await ApiClient.account
          .createSession(email: email, password: password);
      _session = result;

      Store.set("session", json.encode(result.toMap()));

      notifyListeners();
    } catch (e) {
      _session = null;
    }
  }

  signIn({required String email, required String password}) async {
    try {
      _session = await ApiClient.account
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

    Store.set("session", json.encode(_session!.toMap()));

    notifyListeners();
  }

  getLoggedInUserDetails(String _loggedInUserId) async {
    const userCollectionId = '617497ffb09f7';

    late String _loggedInUserName;
    late String _loggedInUserEmail;
    late String _loggedInUserDocId;
    debugPrint('Logged in user is $_loggedInUserId');

    Future<DocumentList> docListF = ApiClient.database.listDocuments(
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
}
