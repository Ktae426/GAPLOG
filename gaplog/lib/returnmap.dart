// 2. returnmap.dart( 리턴맵 화면)

import 'package:flutter/material.dart';
import 'experience.dart'; // ExperienceListScreen이 여기에 있다고 가정
import 'experience_detail.dart';
import 'global_data.dart'; // GlobalData import

// ====================================================================
// ReturnMapDetailScreen: 리턴맵 상세 화면 (오류 발생하지 않도록 클래스 위치 유지)
// ====================================================================
class ReturnMapDetailScreen extends StatelessWidget {
  final String title;
  const ReturnMapDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title 상세'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Center(
        child: Text(
          '$title 상세 정보 화면입니다.',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// ====================================================================
// ReturnMapScreen: 리턴맵 화면 구현 (StatefulWidget) (수정됨)
// ====================================================================
class ReturnMapScreen extends StatefulWidget {
  // 🚨 [유지]: 검색 탭(ExperienceListScreen)으로 이동하기 위한 콜백
  final VoidCallback onNavigateToSearch;
  const ReturnMapScreen({super.key, required this.onNavigateToSearch});

  @override
  State<ReturnMapScreen> createState() => _ReturnMapScreenState();
}

class _ReturnMapScreenState extends State<ReturnMapScreen> {
  static const Color customAccentColor = Color(0xFF228B6A);
  static const Color customDarkGreen = Color(0xFF228B6A);

  // _updateCompletionStatus 함수를 클래스 내부에 정의하여 오류를 해결합니다.
  void _updateCompletionStatus(String stepName, bool isCompleted) {
    setState(() {
      if (stepName == '체험') {
        GlobalData.isExperienceCompleted = isCompleted;
      } else if (stepName == '교육 수료') {
        GlobalData.isEducationCompleted = isCompleted;
      } else if (stepName == '자격증') {
        GlobalData.isLicenseCompleted = isCompleted;
      } else if (stepName == '파트타임') {
        GlobalData.isPartTimeCompleted = isCompleted;
      } else if (stepName == '포트폴리오 완성') {
        GlobalData.isPortfolioCompleted = isCompleted;
      }
      // UI 갱신을 위해 setState 호출
    });
  }

  void _completeExperienceCallback() {
    _updateCompletionStatus('체험', true);
  }

  // 전체 진행률 위젯
  Widget _buildOverallProgress() {
    final double progressValue = GlobalData.currentProgress;

    String statusText;
    if (progressValue >= 1.0) {
      statusText = '여정을 완료했습니다!👏';
    } else if (progressValue > 0) {
      statusText = '목표까지 함께 가고 있어요!';
    } else {
      statusText = '아직 시작하지 않았어요.';
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '전체 진행률',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${(progressValue * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(customDarkGreen),
              minHeight: 12,
              borderRadius: BorderRadius.circular(6),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                statusText,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 단계별 여정 블록 위젯
  Widget _buildJourneyBlock({
    required BuildContext context,
    required String title,
    required String statusText,
    required bool isCompleted,
    required bool isCurrent,
    required bool isClickable,
    VoidCallback? specialOnTap,
  }) {
    final VoidCallback? onTap = isClickable
        ? specialOnTap ??
            () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => ReturnMapDetailScreen(title: title)),
          );
        }
        : null;

    IconData icon;
    Color iconColor;
    if (isCompleted) {
      icon = Icons.check_circle;
      iconColor = customAccentColor;
    } else if (isCurrent) {
      icon = Icons.folder_open;
      iconColor = customAccentColor;
    } else {
      icon = Icons.folder_open;
      iconColor = Colors.grey.shade500;
    }

    double opacity = isClickable || isCompleted ? 1.0 : 0.6;

    Widget? currentTag = isCurrent
        ? Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '현재 단계',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red.shade600),
      ),
    )
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Opacity(
        opacity: opacity,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 30),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (currentTag != null) currentTag,
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 14,
                          color: isCompleted || isCurrent ? Colors.grey.shade600 : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 5단계 상태 결정 로직
    final bool experienceIsCompleted = GlobalData.isExperienceCompleted;
    final bool educationIsCompleted = GlobalData.isEducationCompleted;
    // final bool licenseIsCompleted = GlobalData.isLicenseCompleted; // 사용하지 않음
    // final bool partTimeIsCompleted = GlobalData.isPartTimeCompleted; // 사용하지 않음
    // final bool portfolioIsCompleted = GlobalData.isPortfolioCompleted; // 사용하지 않음

    // 1단계: 체험
    final String experienceTitle = '체험';
    final bool experienceIsCurrent = !experienceIsCompleted;
    final bool experienceIsClickable = experienceIsCurrent;
    final String experienceStatusText = experienceIsCompleted ? '완료했어요!🎉' : '지금 도전하고 있어요';

    // 2단계: 교육 수료 (체험 완료 시 활성화)
    final String educationTitle = '교육 수료';
    final bool educationIsCurrent = experienceIsCompleted && !educationIsCompleted;
    final bool educationIsClickable = experienceIsCompleted && !educationIsCompleted; // 경험 완료 시 활성화
    final String educationStatusText = educationIsCompleted ? '완료했어요!🎉' : (educationIsCurrent ? '지금 도전하고 있어요' : '아직 도전 전이에요');

    // 3단계 이후: 모두 비활성화 및 "도전 전이에요" 상태로 잠금
    final String defaultStatusText = '아직 도전 전이에요';
    final bool defaultIsCompleted = false;
    final bool defaultIsCurrent = false;
    final bool defaultIsClickable = false;

    // ====================================================================

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text(
          '나의 재도약 여정',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '함께 한 걸음씩 나아가요.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ),
        // 🚨 [핵심 수정]: 하단에 PreferredSize(AppBar 하단에 추가 정보 표시)가 아닌 경우,
        // 불필요한 바를 제거하기 위해 `bottom` 위젯 아래에 더미 위젯이 없도록 함.
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. 전체 진행률 섹션
            _buildOverallProgress(),

            const SizedBox(height: 30),

            // 2. 단계별 여정 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '단계별 여정',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // 1단계: 체험 (현재 활성 상태)
            _buildJourneyBlock(
              context: context,
              title: experienceTitle,
              statusText: experienceStatusText,
              isCompleted: experienceIsCompleted,
              isCurrent: experienceIsCurrent,
              isClickable: experienceIsClickable,
              specialOnTap: experienceIsClickable
                  ? () {
                // 🚨 [핵심 유지]: Navigator.push 대신 탭 전환 콜백 함수 사용
                widget.onNavigateToSearch();
              }
                  : null,
            ),

            // 2단계: 교육 수료 (체험 완료 시 활성화)
            _buildJourneyBlock(
              context: context,
              title: educationTitle,
              statusText: educationStatusText,
              isCompleted: educationIsCompleted,
              isCurrent: educationIsCurrent,
              isClickable: educationIsClickable,
              specialOnTap: educationIsClickable
                  ? () {
                // 임시 로직: 클릭 시 완료 처리 (테스트 목적)
                _updateCompletionStatus(educationTitle, true);
              }
                  : null,
            ),

            // 3단계: 자격증 (비활성화)
            _buildJourneyBlock(
              context: context,
              title: '자격증',
              statusText: defaultStatusText,
              isCompleted: defaultIsCompleted,
              isCurrent: defaultIsCurrent,
              isClickable: defaultIsClickable,
            ),

            // 4단계: 파트타임 (비활성화)
            _buildJourneyBlock(
              context: context,
              title: '파트타임',
              statusText: defaultStatusText,
              isCompleted: defaultIsCompleted,
              isCurrent: defaultIsCurrent,
              isClickable: defaultIsClickable,
            ),

            // 5단계: 포트폴리오 완성 (비활성화)
            _buildJourneyBlock(
              context: context,
              title: '포트폴리오 완성',
              statusText: defaultStatusText,
              isCompleted: defaultIsCompleted,
              isCurrent: defaultIsCurrent,
              isClickable: defaultIsClickable,
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}