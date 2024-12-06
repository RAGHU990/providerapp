// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthController with ChangeNotifier {
//   final SupabaseClient client;

//   AuthController(this.client);

//   User? _user;
//   User? get user => _user;

//   Future<void> signUp(String email, String password) async {
//     final response = await client.auth.signUp(email, password);
//     if (response.error == null) {
//       _user = response.user;
//       notifyListeners();
//     } else {
//       throw Exception(response.error!.message);
//     }
//   }

//   Future<void> signIn(String email, String password) async {
//     final response = await client.auth.signInWithPassword(
//       email: email,
//       password: password,
//     );
//     if (response.error == null) {
//       _user = response.user;
//       notifyListeners();
//     } else {
//       throw Exception(response.error!.message);
//     }
//   }

//   Future<void> signOut() async {
//     await client.auth.signOut();
//     _user = null;
//     notifyListeners();
//   }

//   void checkUser() {
//     _user = client.auth.currentUser;
//     notifyListeners();
//   }
// }






import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController with ChangeNotifier {
  final SupabaseClient client;

  AuthController(this.client) {
    checkUser();
  }

  User? _user;
  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> signUp(String email, String password) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        _user = response.user;
        notifyListeners();
      } else {
        throw Exception( 'Sign-up failed');
      }
    } catch (e) {
      rethrow; // Allow the caller to handle the exception
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        _user = response.user;
        notifyListeners();
      } else {
        throw Exception('Sign-in failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await client.auth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void checkUser() {
    _user = client.auth.currentUser;
    notifyListeners();
  }
}
