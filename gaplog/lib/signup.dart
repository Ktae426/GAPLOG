
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback onSignupSuccess;
  final VoidCallback onToggleToLogin;

  const SignupScreen({super.key, required this.onSignupSuccess, required this.onToggleToLogin});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // 입력 필드 컨트롤러
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  // 닉네임 컨트롤러
  final TextEditingController _nicknameController = TextEditingController();

  // 커스텀 색상 정의
  static const Color customButtonColor = Color(0xFF228B6A);
  static const Color cancelColor = Color(0xFFFFA000);

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nicknameController.dispose(); // 닉네임 컨트롤러 dispose
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      // 폼 유효성 검사 통과 시
      print('회원가입 정보 입력 완료 및 유효성 검사 통과.');
      print('닉네임: ${_nicknameController.text}');

      // 회원가입 완료 후 로그인 화면으로 돌아감
      widget.onToggleToLogin();

      // 사용자에게 성공 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('회원가입이 완료되었습니다. 로그인해 주세요.'), duration: Duration(seconds: 2)),
      );
    }
  }

  // 필드 제목 위젯
  Widget _buildFieldTitle(String title, {required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, top: 20.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          if (isRequired)
            const Text(
              '*',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
        ],
      ),
    );
  }

  // 기본 텍스트 필드 위젯
  Widget _buildTextField({
    TextEditingController? controller,
    String? hintText,
    Widget? suffix,
    bool obscureText = false,
    String? Function(String?)? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: customButtonColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        suffixIcon: suffix,
      ),
      validator: validator,
      autovalidateMode: autovalidateMode,
    );
  }

  // 재사용 가능한 드롭다운 위젯: 항목 목록을 외부에서 받도록 수정
  Widget _buildDropdown({required String label, required List<String> items}) {
    // DropdownButtonFormField의 초기 value는 items 목록에 포함되어야 합니다.
    String? initialValue = items.contains(label) ? label : items.first;

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      // items 목록을 사용하여 드롭다운 항목 생성
      value: initialValue,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        print('$label 선택: $newValue');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    // 생년월일 선택 목록 데이터 생성
    final List<String> years = List<String>.generate(101, (i) => (1925 + i).toString()).reversed.map((y) => '$y년').toList();
    years.insert(0, '년도'); // 첫 항목은 '년도'로 설정

    final List<String> months = List<String>.generate(12, (i) => (i + 1).toString()).map((m) => '$m월').toList();
    months.insert(0, '월');

    final List<String> days = List<String>.generate(31, (i) => (i + 1).toString()).map((d) => '$d일').toList();
    days.insert(0, '일');

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('회원가입', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '회원이 되어 다양한 혜택을 경험해 보세요!',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // 1. 아이디
              _buildFieldTitle('아이디', isRequired: true),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _idController,
                      decoration: InputDecoration(
                        hintText: '아이디 입력(6~20자)',
                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return '아이디를 입력해 주세요.';
                        if (value.length < 6) return '아이디는 6자 이상 입력해야 합니다.';
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => print('ID 중복 확인 클릭'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customButtonColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      child: const Text('중복 확인', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),

              // 2. 비밀번호
              _buildFieldTitle('비밀번호', isRequired: true),
              _buildTextField(
                controller: _passwordController,
                hintText: '비밀번호 입력(문자, 숫자, 특수문자 포함 8~20자)',
                obscureText: true,
                // 비밀번호 유효성 검사 강화
                validator: (value) {
                  if (value == null || value.isEmpty) return '비밀번호를 입력해 주세요.';

                  // 1. 길이 검사 (8자 이상, 20자 이하)
                  if (value.length < 8 || value.length > 20) {
                    return '비밀번호는 8자 이상 20자 이하로 입력해야 합니다.';
                  }

                  // 2. 복잡성 검사: 영문, 숫자, 특수문자 포함
                  String pattern = r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,20}$';
                  RegExp regExp = RegExp(pattern);

                  if (!regExp.hasMatch(value)) {
                    return '영문, 숫자, 특수문자를 모두 포함해야 합니다.';
                  }

                  return null;
                },
              ),

              // 3. 비밀번호 확인
              _buildFieldTitle('비밀번호 확인', isRequired: true),
              _buildTextField(
                controller: _confirmPasswordController,
                hintText: '비밀번호 재입력',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return '비밀번호를 다시 입력해 주세요.';
                  if (value != _passwordController.text) {
                    return '비밀번호가 일치하지 않습니다.';
                  }
                  if (_passwordController.text.isEmpty) {
                    return '비밀번호를 먼저 입력해 주세요.';
                  }
                  return null;
                },
              ),

              // 4. 이름
              _buildFieldTitle('이름', isRequired: true),
              _buildTextField(
                  hintText: '이름을 입력해주세요',
                  validator: (v) {
                    if (v == null || v.isEmpty) return '이름을 입력해 주세요.';
                    return null;
                  }),

              // 5. 닉네임
              _buildFieldTitle('닉네임', isRequired: true),
              _buildTextField(
                  controller: _nicknameController,
                  hintText: '닉네임을 입력해주세요 (2~10자)',
                  validator: (v) {
                    if (v == null || v.isEmpty) return '닉네임을 입력해 주세요.';
                    if (v.length < 2 || v.length > 10) return '닉네임은 2자 이상 10자 이하로 입력해야 합니다.';
                    return null;
                  }),

              // 6. 주소
              _buildFieldTitle('주소', isRequired: true),
              _buildTextField(hintText: '주소를 입력해주세요', validator: (v) => null),
              const SizedBox(height: 10),
              // 상세 주소
              TextFormField(
                decoration: InputDecoration(
                  hintText: '상세 주소',
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),

              // 7. 전화번호
              _buildFieldTitle('전화번호', isRequired: true),
              _buildTextField(hintText: '휴대폰 번호 입력 (\'-\' 제외 11자리 입력)', validator: (v) => null),

              // 8. 이메일 주소
              _buildFieldTitle('이메일 주소', isRequired: false),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(flex: 5, child: _buildTextField(hintText: '이메일 주소', validator: (v) => null)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text('@', style: TextStyle(fontSize: 16)),
                  ),
                  Expanded(flex: 4, child: _buildTextField(hintText: '', validator: (v) => null)), // 도메인 입력 필드
                  SizedBox(
                    width: 80, // 고정 너비 설정
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      ),
                      value: '선택',
                      items: ['선택', 'naver.com', 'gmail.com', 'daum.net']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        print('이메일 도메인 선택: $newValue');
                      },
                    ),
                  ),
                ],
              ),

              // 9. 생년월일
              _buildFieldTitle('생년월일', isRequired: false),
              Row(
                children: [
                  // 연도 목록 전달
                  Expanded(child: _buildDropdown(label: '년도', items: years)),
                  const SizedBox(width: 8),
                  // 월 목록 전달
                  Expanded(child: _buildDropdown(label: '월', items: months)),
                  const SizedBox(width: 8),
                  // 일 목록 전달
                  Expanded(child: _buildDropdown(label: '일', items: days)),
                ],
              ),

              const SizedBox(height: 40),

              // 하단 버튼 섹션
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleSignup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customButtonColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        ),
                        child: const Text('가입 완료', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: widget.onToggleToLogin, // 로그인 화면으로 돌아가기
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cancelColor, // 노란색 계열
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        ),
                        child: const Text('가입 취소', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}