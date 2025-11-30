// onboarding.dart

import 'package:flutter/material.dart';

import 'global_data.dart'; // GlobalData import

// ====================================================================
// OnboardingScreen: 최초 로그인 후 경력 정보 입력 화면
// ====================================================================
class OnboardingScreen extends StatefulWidget {
  final VoidCallback onDataSubmitted;
  final VoidCallback onSkip;

  const OnboardingScreen({super.key, required this.onDataSubmitted, required this.onSkip});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isInitialEntry = GlobalData.isSkipped;

  late String _careerYear;
  late String _previousJob;
  late String _gapYear;
  late String _desiredJob;
  late String _desiredReturnTime;

  late List<SkillInput> _skillInputs;
  final int _maxSkills = 10;

  final List<String> _yearOptions = ['선택', '0년', '1년', '2년', '3년', '4년', '5년 이상'];
  final List<String> _returnTimeOptions = ['선택', '3개월 내', '6개월 내', '1년 내', '미정'];
  final List<String> _levelOptions = ['숙련도', '1', '2', '3', '4', '5'];

  static const Color customButtonColor = Color(0xFF228B6A);

  @override
  void initState() {
    super.initState();
    _careerYear = GlobalData.career;
    _previousJob = GlobalData.previousJob == '-' ? '' : GlobalData.previousJob;
    _gapYear = GlobalData.gapYear;
    _desiredJob = GlobalData.desiredJob == '-' ? '' : GlobalData.desiredJob;
    _desiredReturnTime = GlobalData.desiredReturnTime;

    // GlobalData의 스킬 데이터를 SkillInput 모델로 변환
    if (GlobalData.skills.isNotEmpty) {
      _skillInputs = GlobalData.skills.map((data) {
        return SkillInput(
          skillName: data['name'] as String? ?? '',
          level: data['level'] as int? ?? 0,
        );
      }).toList();
    } else {
      _skillInputs = [SkillInput()];
    }
  }

  void _addSkillInput() {
    if (_skillInputs.length < _maxSkills) {
      setState(() {
        _skillInputs.add(SkillInput());
      });
    }
  }

  void _removeSkillInput(SkillInput skill) {
    if (_skillInputs.length > 1) {
      setState(() {
        _skillInputs.removeWhere((s) => s.key == skill.key);
      });
    }
  }

  // 기본 입력 필드 위젯
  Widget _buildTextField({
    required String label,
    required String hint,
    required Function(String?) onSaved,
    List<String>? options,
    String? initialValue,
    bool isRequired = true,
  }) {
    if (options != null && !options.contains('선택')) {
      options.insert(0, '선택');
    }
    String? effectiveValue = options != null && options.contains(initialValue) ? initialValue : (options != null ? options.first : initialValue);

    const EdgeInsets uniformContentPadding = EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              if (isRequired)
                const Text(
                  '*',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                ),
            ],
          ),
        ),
        options != null
            ? DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: uniformContentPadding,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          value: effectiveValue,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onSaved,
          onSaved: onSaved,
          validator: (value) => isRequired && (value == null || value.isEmpty || value == '선택') ? '필수 선택 항목입니다.' : null,
        )
            : TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: uniformContentPadding,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          initialValue: initialValue,
          onSaved: onSaved,
          validator: (value) => isRequired && (value == null || value.isEmpty) ? '필수 입력 항목입니다.' : null,
        ),
      ],
    );
  }

  // 정보 저장 로직
  void _submitData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      GlobalData.career = _careerYear;
      GlobalData.previousJob = _previousJob.isEmpty ? '-' : _previousJob;
      GlobalData.gapYear = _gapYear;
      GlobalData.desiredJob = _desiredJob.isEmpty ? '-' : _desiredJob;
      GlobalData.desiredReturnTime = _desiredReturnTime;
      GlobalData.isSkipped = false;

      GlobalData.skills = _skillInputs
          .map((s) => {'name': s.skillName, 'level': s.level})
          .where((s) {
        final name = s['name'] as String;
        final level = s['level'] as int;
        return name.isNotEmpty && level > 0;
      })
          .toList();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('정보가 성공적으로 저장되었습니다.'), duration: Duration(seconds: 1)),
      );

      if (_isInitialEntry) {
        widget.onDataSubmitted(); // 최초 진입 시 홈으로 이동
      } else {
        Navigator.of(context).pop(); // 수정 모드 시 이전 화면으로 복귀
      }
    }
  }

  // 닫기 (이전 화면으로 돌아가기) 로직
  void _closeScreen() {
    if (_isInitialEntry) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('정보 입력 건너뛰기'),
            content: const Text('정보를 입력하지 않으시면 맞춤 추천이 어려울 수 있어요. 건너뛰시겠어요?'),
            actions: <Widget>[
              TextButton(
                child: const Text('아니요', style: TextStyle(color: customButtonColor)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                child: const Text('예', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  GlobalData.isSkipped = true;
                  widget.onSkip();
                },
              ),
            ],
          );
        },
      );
    } else {
      // 수정 중 취소
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('수정 취소'),
            content: const Text('지금 나가면 입력한 정보가 저장되지 않아요. 그래도 나가시겠어요?'),
            actions: <Widget>[
              TextButton(
                child: const Text('아니오', style: TextStyle(color: customButtonColor)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                child: const Text('예', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보 입력', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: const [],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 100.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    '맞춤형 서비스를 제공하기 위해 경력 정보를 입력해 주세요.',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),

                  // --- A. 경력 정보 (필수) ---
                  _buildTextField(
                    label: '총 경력',
                    hint: '선택',
                    options: _yearOptions,
                    initialValue: _careerYear,
                    onSaved: (newValue) {
                      _careerYear = newValue ?? '0년';
                    },
                  ),
                  _buildTextField(
                    label: '이전 직무',
                    hint: '예: 마케팅, 회계 등',
                    initialValue: _previousJob,
                    // 세미콜론 누락 오류 수정
                    onSaved: (newValue) {
                      _previousJob = newValue ?? '';
                    },
                  ),
                  _buildTextField(
                    label: '공백 기간',
                    hint: '선택',
                    options: _yearOptions,
                    initialValue: _gapYear,
                    onSaved: (newValue) {
                      _gapYear = newValue ?? '0년';
                    },
                  ),
                  _buildTextField(
                    label: '희망 직무',
                    hint: '예: 디지털 마케팅, 데이터 분석',
                    initialValue: _desiredJob,
                    // 세미콜론 누락 오류 수정
                    onSaved: (newValue) {
                      _desiredJob = newValue ?? '';
                    },
                  ),
                  _buildTextField(
                    label: '희망 복귀 시기',
                    hint: '선택',
                    options: _returnTimeOptions,
                    initialValue: _desiredReturnTime,
                    onSaved: (newValue) {
                      _desiredReturnTime = newValue ?? '-';
                    },
                  ),

                  const SizedBox(height: 40),

                  // --- B. 보유 스킬 (동적) ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '보유 스킬 (선택)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  ..._skillInputs.map((skillInput) {
                    final int index = _skillInputs.indexOf(skillInput);

                    final Function()? removeFunction = index == 0 ? null : () => _removeSkillInput(skillInput);

                    return _buildSkillInputRow(
                      context,
                      skillInput: skillInput,
                      label: '스킬 ${index + 1}',
                      onRemove: removeFunction,
                    );
                  }).toList(),

                  if (_skillInputs.length < _maxSkills)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.add_circle, color: customButtonColor, size: 30),
                          onPressed: _addSkillInput,
                        ),
                      ),
                    ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // 하단 고정 버튼 섹션 (저장: 3, 닫기: 2 비율, 위치 재조정)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  // 저장 버튼 (Flex 3) - 왼쪽에 위치
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customButtonColor,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('저장', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // 닫기 버튼 (Flex 2) - 오른쪽에 위치
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _closeScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade400,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        child: const Text('닫기', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 스킬 및 숙련도 입력 행 위젯
  Widget _buildSkillInputRow(
      BuildContext context, {
        required SkillInput skillInput,
        required String label,
        required Function()? onRemove, // null이면 삭제 버튼 숨김
      }) {
    final String initialLevelString = skillInput.level > 0 && _levelOptions.contains(skillInput.level.toString())
        ? skillInput.level.toString()
        : _levelOptions.first;

    const EdgeInsets uniformContentPadding = EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0);

    final InputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey.shade400),
    );
    final InputBorder focusBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: customButtonColor, width: 2.0));
    final InputBorder skillDefaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: customButtonColor.withOpacity(0.8), width: 1.5),
    );

    return Padding(
      key: skillInput.key,
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            // 레이블과 입력 필드 간 간격 축소 (bottom: 4.0)
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 스킬 이름 입력 필드 (Flex 5)
              Expanded(
                flex: 5,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '보유 스킬 (예: 엑셀)',
                    contentPadding: uniformContentPadding,
                    border: defaultBorder,
                    enabledBorder: defaultBorder,
                    focusedBorder: focusBorder,
                  ),
                  initialValue: skillInput.skillName,
                  onSaved: (newValue) {
                    skillInput.skillName = newValue ?? '';
                  },
                  validator: (value) => (value != null && value.isNotEmpty && value.length < 2) ? '2자 이상 입력해주세요.' : null,
                ),
              ),
              const SizedBox(width: 10),

              // 숙련도 필드 및 레이블 (Flex 3)
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          '숙련도',
                          style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: uniformContentPadding,
                        border: skillDefaultBorder,
                        enabledBorder: skillDefaultBorder,
                        focusedBorder: focusBorder,
                      ),
                      value: initialLevelString,
                      items: _levelOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (v) {
                        final String value = v ?? _levelOptions.first;
                        skillInput.level = int.tryParse(value.replaceAll(_levelOptions.first, '0')) ?? 0;
                      },
                      onSaved: (v) {
                        final String value = v ?? _levelOptions.first;
                        skillInput.level = int.tryParse(value.replaceAll(_levelOptions.first, '0')) ?? 0;
                      },
                      validator: (value) => null,
                    ),
                  ],
                ),
              ),

              // 삭제 버튼
              if (onRemove != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red.shade400, size: 30),
                    onPressed: onRemove,
                  ),
                )
              else
                const SizedBox(width: 48),
            ],
          ),
        ],
      ),
    );
  }
}