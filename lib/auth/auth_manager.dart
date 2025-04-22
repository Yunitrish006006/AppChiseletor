import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationManager extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _currentUser;
  String? _lastError;
  bool _initialized = false;

  AuthenticationManager() {
    _init();
  }

  Future<void> _init() async {
    try {
      await Firebase.initializeApp();
      _currentUser = _auth.currentUser;
      _auth.authStateChanges().listen(_onAuthStateChanged);
      _initialized = true;
      notifyListeners();
    } catch (e) {
      _lastError = 'Failed to initialize Firebase: $e';
      _initialized = true;
      notifyListeners();
    }
  }

  void _onAuthStateChanged(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _currentUser != null;
  String? get lastError => _lastError;
  User? get currentUser => _currentUser;

  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return '找不到該用戶';
      case 'wrong-password':
        return '密碼錯誤';
      case 'invalid-email':
        return '無效的電子郵件格式';
      case 'user-disabled':
        return '該帳戶已被停用';
      case 'too-many-requests':
        return '登入嘗試次數過多，請稍後再試';
      case 'operation-not-allowed':
        return '此登入方式未啟用';
      case 'email-already-in-use':
        return '此電子郵件已被使用';
      case 'weak-password':
        return '密碼強度不足';
      default:
        return e.message ?? '登入失敗';
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _lastError = null;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _lastError = _getFirebaseErrorMessage(e);
      throw _lastError!;
    } catch (e) {
      _lastError = '登入時發生未知錯誤';
      throw _lastError!;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw '已取消 Google 登入';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      _lastError = null;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _lastError = _getFirebaseErrorMessage(e);
      throw _lastError!;
    } catch (e) {
      _lastError = e.toString();
      throw _lastError!;
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      _lastError = null;
    } catch (e) {
      _lastError = '登出時發生錯誤';
      throw _lastError!;
    }
  }
}
