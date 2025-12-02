import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 로그인 성공 → 다음 화면 이동
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Te  print("❌ 로그인 실패: $e");

            String message = "로그인에 실패했습니다. 이메일 또는 비밀번호를 확인해주세요.";

            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: Duration(seconds: 2),
          ),
        );xt('로그인 성공')),
      );
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      print("❌ 로그인 실패: $e");

      String message = "로그인에 실패했습니다. 이메일 또는 비밀번호를 확인해주세요.";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        ),
      );
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "로그인",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "이메일",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "비밀번호",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _loading ? null : _login,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("로그인"),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text("회원가입 하기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
