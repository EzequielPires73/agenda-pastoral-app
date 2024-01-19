import 'dart:convert';

import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { idle, success, error }

enum UserState { idle, logged, loggedOut, error }

class AuthController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  var state = AuthState.idle;
  var isLoading = false;
  var errorMsg = '';
  Member? member;
  User? user;
  var userState = UserState.idle;

  Future<void> singinMember(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      var res = await _apiService.post(
          'auth/login/members', {"email": email, "password": password}, null);

      if (res['statusCode'] == '401' || res['user'] == null) {
        throw Exception('Dados incorretos.');
      }
      if (res['success']) {
        final shared = await SharedPreferences.getInstance();
        final tokenNotification = shared.getString('tokenNotification');
        await shared.setString('member', jsonEncode(res['user']));
        await shared.setString('member.access_token', res['access_token']);

        member = Member.fromJson(res['user']);
        state = AuthState.success;

        await pushNotificationTokenMember(tokenNotification);
        notifyListeners();
      }
    } catch (error) {
      errorMsg = error.toString();
      state = AuthState.error;
      notifyListeners();
    } finally {
      state = AuthState.idle;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> singinUser(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      var res = await _apiService.post(
          'auth/login', {"email": email, "password": password}, null);

      if (res['statusCode'] == '401' || res['user'] == null) {
        throw Exception('Dados incorretos.');
      }
      if (res['success']) {
        final shared = await SharedPreferences.getInstance();
        final tokenNotification = shared.getString('tokenNotification');
        await shared.setString('user', jsonEncode(res['user']));
        await shared.setString('user.access_token', res['access_token']);

        user = User.fromJson(res['user']);
        state = AuthState.success;

        await pushNotificationTokenUser(tokenNotification);
        notifyListeners();
      }
    } catch (error) {
      errorMsg = error.toString();
      state = AuthState.error;
      notifyListeners();
    } finally {
      state = AuthState.idle;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      final shared = await SharedPreferences.getInstance();
      await shared.remove('tokenNotification');
      if (user != null) {
        await pushNotificationTokenUser(null);
        await shared.remove('user');
        await shared.remove('user.access_token');
        user = null;
      }
      if (member != null) {
        await pushNotificationTokenMember(null);
        await shared.remove('member');
        await shared.remove('member.access_token');
        member = null;
      }
      notifyListeners();
    } catch (error) {
      print(error);
      notifyListeners();
    }
  }

  Future<void> loadUser() async {
    final shared = await SharedPreferences.getInstance();
    final userData = shared.getString('user');
    final memberData = shared.getString('member');
    if (userData != null) {
      user = User.fromJson(json.decode(userData));
      userState = UserState.logged;
      notifyListeners();
    } else if (memberData != null) {
      member = Member.fromJson(json.decode(memberData));
      userState = UserState.logged;
      notifyListeners();
    } else {
      userState = UserState.loggedOut;
      notifyListeners();
    }
  }

  Future<void> pushNotificationTokenMember(String? tokenNotification) async {
    final shared = await SharedPreferences.getInstance();
    final accessToken = shared.getString('member.access_token');
    await _apiService.post(
        'members/push-notification-token',
        tokenNotification != null ? {"token": tokenNotification} : null,
        {"authorization": "Bearer $accessToken"});
  }

  Future<void> pushNotificationTokenUser(String? tokenNotification) async {
    final shared = await SharedPreferences.getInstance();
    final accessToken = shared.getString('user.access_token');
    await _apiService.post(
        'users/push-notification-token',
        tokenNotification != null ? {"token": tokenNotification} : null,
        {"authorization": "Bearer $accessToken"});
  }
}
