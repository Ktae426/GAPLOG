import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';
import 'signup.dart';
import 'onboarding.dart';
import 'login_page.dart';
import 'global_data.dart'; // GlobalData import


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '경력단절자 앱',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        scaffoldBackgroundColor: Colors.green.shade50,
        useMaterial3: false,
      ),
      initialRoute: '/', 
      routes: {
        '/': (context) => const AuthenticationWrapper(),
        '/home': (context) => AppNavigator(onSignOut: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }),
        '/onboarding': (context) => OnboardingScreen(
          onDataSubmitted: () {
            // 정보 입력 완료 시 홈으로 이동
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
          },
          onSkip: () {
            // 건너뛰기 완료 시 홈으로 이동
            GlobalData.isSkipped = true;
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
          },
        ),
      },
    );
  }
}


class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool _isFirstLogin = true;

  void _signInSuccess() {
    setState(() {
      // 상태 변경 로직
    });

    if (_isFirstLogin || GlobalData.isSkipped) {
      _isFirstLogin = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Build가 완료된 후 온보딩 화면으로 리디렉션
        Navigator.of(context).pushNamedAndRemoveUntil('/onboarding', (route) => false);
      });
    } else {
      // 이미 온보딩을 완료했다면 홈으로 바로 이동 (재로그인)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      });
    }
  }

  void _signOut() {
    setState(() {
      // 로그아웃 시 상태 초기화
      _isFirstLogin = true;
      GlobalData.isSkipped = true;
      GlobalData.career = '0년';
      GlobalData.previousJob = '-';
      GlobalData.gapYear = '-';
      GlobalData.desiredJob = '-';
      GlobalData.desiredReturnTime = '-';
      GlobalData.skills = [];

      // 진행률 상태 초기화
      GlobalData.isExperienceCompleted = false;
      GlobalData.isEducationCompleted = false;
      GlobalData.isLicenseCompleted = false;
      GlobalData.isPartTimeCompleted = false;
      GlobalData.isPortfolioCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreen(onSignIn: _signInSuccess);
  }
}


class AuthScreen extends StatefulWidget {
  final VoidCallback onSignIn;
  const AuthScreen({super.key, required this.onSignIn});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum AuthMode { login, signup }

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.login;

  void _toggleAuthMode() {
    setState(() {
      if (_authMode == AuthMode.login) {
        _authMode = AuthMode.signup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_authMode == AuthMode.login) {
      return LoginScreen(
        onLogin: widget.onSignIn,
        onToggleToSignup: _toggleAuthMode,
      );
    } else {
      return SignupScreen(
        onSignupSuccess: widget.onSignIn,
        onToggleToLogin: _toggleAuthMode,
      );
    }
  }
}


class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;
  final VoidCallback onToggleToSignup;

  const LoginScreen({super.key, required this.onLogin, required this.onToggleToSignup});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const Color customLoginButtonColor = Color(0xFF228B6A);

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final email = _idController.text.trim();
    final password = _passwordController.text.trim();
    final id = _idController.text;

    print('--- 로그인 시도 ---');

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디와 비밀번호를 입력해 주세요.'), duration: Duration(seconds: 1)),
      );
      return;  // ❗ 입력 안되면 함수 종료
    }

    try {
      // Firebase 로그인
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("로그인 성공");
      widget.onLogin();  // 로그인 성공 후 기존 네비게이션 로직 실행

    } catch (e) {
      print("로그인 실패: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패: $e')),
      );
    }
    final user = FirebaseAuth.instance.currentUser;

    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    print(data['name']); // Firestore에서 가져온 데이터

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 120),

              // 1. 로고 이미지 및 앱 이름
              Image.asset(
                'images/logo.png',
                height: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                'GapLog',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 80),

              // 2. 아이디 입력 필드
              TextFormField(
                controller: _idController,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: '아이디',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: customLoginButtonColor),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 3. 비밀번호 입력 필드
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: customLoginButtonColor),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // 4. 회원가입 | 비밀번호 찾기 링크
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: widget.onToggleToSignup,
                    child: Text(
                      '회원가입',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  const Text('|', style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () => print('비밀번호 찾기 클릭!'),
                    child: Text(
                      '비밀번호 찾기',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // 5. 로그인 버튼
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customLoginButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}