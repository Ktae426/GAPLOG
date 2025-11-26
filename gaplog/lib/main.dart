import 'package:flutter/material.dart';

// 앱 진입
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GapLog 초기 로그인 UI',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        scaffoldBackgroundColor: Colors.green.shade50,
        useMaterial3: false,
      ),
      // 시작 화면을 LoginScreen으로 바로 설정합니다.
      home: const LoginScreen(),
    );
  }
}

// 로그인 화면
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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

  void _handleLogin() {
    final id = _idController.text;
    final password = _passwordController.text;

    // 로그인 로직 임시 출력
    print('--- 로그인 버튼 클릭 (UI 테스트 모드) ---');
    print('아이디: $id');
    print('비밀번호: $password');

    // UI 테스트 모드이므로 화면 전환 X
    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('아이디와 비밀번호를 입력해 주세요.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Colors.green.shade50;

    return Scaffold(
      backgroundColor: backgroundColor,
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
              Image.asset('images/logo.png', height: 100),
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
                decoration: InputDecoration(
                  hintText: '아이디',
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green.shade700),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 3. 비밀번호 입력 필드
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green.shade700),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // 4. 회원가입 | 비밀번호 찾기 링크 (클릭 시 print만 실행)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => print('회원가입 링크 클릭!'),
                    child: Text(
                      '회원가입',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  const Text('|', style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () => print('비밀번호 찾기 링크 클릭!'),
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
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
