// 3. information.dart (내 정보 화면)

import 'package:flutter/material.dart';
import 'global_data.dart'; // GlobalData import
import 'like_list.dart'; // 찜 목록 화면 import
import 'onboarding.dart'; // OnboardingScreen 경로 import
import 'experience_detail.dart'; // Experience 클래스를 사용하기 위해 import
import 'activity_list.dart'; // ActivityListScreen import

// ====================================================================
// MyInfoScreen: 내 정보 화면 구현 (StatefulWidget으로 변경 및 GlobalData 연동)
// ====================================================================

class MyInfoScreen extends StatefulWidget {
  final VoidCallback onSignOut;
  const MyInfoScreen({super.key, required this.onSignOut});

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  static const Color customAccentColor = Color(0xFF228B6A);

  // 🚨 [유지]: 찜 개수 갱신을 위해 필요한 리스너 (체험 카운트는 ValueListenableBuilder가 처리)
  @override
  void initState() {
    super.initState();
    // 찜 목록 변경 시 현재 화면을 갱신하도록 리스너 추가
    GlobalData.favoritedExperiencesNotifier.addListener(_onFavoritesChanged);
    // completedActivitiesNotifier는 ValueListenableBuilder가 처리합니다.
  }

  @override
  void dispose() {
    GlobalData.favoritedExperiencesNotifier.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onFavoritesChanged() {
    // ValueNotifier의 변경을 감지하여 setState 호출 (주로 찜 카운트와 같은 다른 요소 갱신용)
    setState(() {});
  }
  // ------------------------------------------

  void _showLogoutDialog(BuildContext context) {
    // 로그아웃 다이얼로그 로직 (유지)
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('로그아웃'),
          content: const Text('정말 로그아웃 하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: const Text('아니요', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('예', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                widget.onSignOut();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // build 메서드 진입 시 최신 GlobalData 값을 참조 (setState 호출 시 갱신됨)
    const Color accentColor = customAccentColor;

    // GlobalData에서 경력 정보 로드 및 '-' 처리 로직 (유지)
    final bool isSkipped = GlobalData.isSkipped;
    final String careerYear = isSkipped ? '-' : GlobalData.career;
    final String previousJob = isSkipped ? '-' : GlobalData.previousJob;
    final String gapYear = isSkipped ? '-' : GlobalData.gapYear;
    final String desiredJob = isSkipped ? '-' : GlobalData.desiredJob;
    final String desiredReturnTime = isSkipped ? '-' : GlobalData.desiredReturnTime;

    // GlobalData에서 다른 활동 개수 로드 (모두 0)
    final String badgeCount = GlobalData.badgeCount.toString();    // 배지 (0)
    final String reviewCount = GlobalData.reviewCount.toString();   // 리뷰 (0)

    // 🚨 [핵심 유지]: GlobalData의 getter를 통해 찜 개수 로드
    final String favoriteCount = GlobalData.favoriteCount.toString();

    final List<Map<String, dynamic>> userSkills = GlobalData.skills;
    final double currentProgress = GlobalData.currentProgress;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // 1. 상단 프로필 및 리턴맵 진행률 섹션 (유지)
            _buildProfileHeader(context, currentProgress),

            const SizedBox(height: 20),

            // 2. 나의 활동 (체험, 배지, 리뷰, 좋아요)
            // 🚨 [핵심 수정]: 체험 카운트는 ValueNotifier를 통해 실시간 갱신
            _buildMyActivities(
                context,
                badgeCount,
                reviewCount,
                favoriteCount
            ),

            const SizedBox(height: 20),

            // 3. 경력 요약 및 나의 목표 섹션에 실제 데이터 전달 (유지)
            _buildCareerAndGoalSummary(
              accentColor,
              careerYear: careerYear,
              previousJob: previousJob,
              gapYear: gapYear,
              desiredJob: desiredJob,
              desiredReturnTime: desiredReturnTime,
            ),

            const SizedBox(height: 20),

            // 4. 보유 스킬 섹션에 실제 데이터 전달 (유지)
            _buildSkillsSection(accentColor, userSkills),

            const SizedBox(height: 20),

            // 5. 찜한 체험 및 이력서 관리 섹션
            _buildFavoritesAndResumeSeparated(context, accentColor, favoriteCount),

            const SizedBox(height: 30),

            // 6. 로그아웃 버튼 (유지)
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => _showLogoutDialog(context),
                child: const Text(
                  '로그아웃',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // 상단 프로필 및 진행률 섹션 위젯 (유지)
  Widget _buildProfileHeader(BuildContext context, double progressValue) {
    // 진행률 값 받도록 수정
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // 프로필 정보와 수정 버튼 Row
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: customAccentColor,
                child: Icon(Icons.person, color: Colors.white, size: 35),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이름 옆에 수정 버튼 추가
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('은정 님', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        // 수정 버튼
                        TextButton(
                          onPressed: () {
                            // 정보 입력 화면으로 이동 (온보딩 화면 재사용)
                            Navigator.of(context).pushNamed('/onboarding');
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            '수정',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('새로운 시작을 준비하는 마케터', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          // 진행률 바를 위한 섹션
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(customAccentColor),
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 10),
              Text('${(progressValue * 100).toInt()}%',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: customAccentColor)),
            ],
          ),
          const SizedBox(height: 10), // 진행률 바 아래 간격 추가
        ],
      ),
    );
  }

  // 나의 활동 아이템 위젯 (수정) (유지)
  Widget _buildActivityItem(IconData icon, String title, String count, {VoidCallback? onTap, required Widget countWidget}) {
    // 🚨 [수정]: 카운트 텍스트 대신 Widget을 받도록 변경
    return InkWell(
      // InkWell로 감싸서 클릭 가능하게 만듦
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 30, color: customAccentColor),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 2),
          countWidget, // 🚨 [수정]: countWidget을 바로 사용
        ],
      ),
    );
  }

  // 나의 활동 섹션 위젯
  Widget _buildMyActivities(
      BuildContext context,
      String badgeCount,
      String reviewCount,
      String favoriteCount) {

    // 🚨 [핵심 수정]: ValueListenableBuilder를 사용하여 실시간으로 '체험' 카운트 갱신
    final Widget activityCountWidget = ValueListenableBuilder<Set<String>>(
      valueListenable: GlobalData.completedActivitiesNotifier,
      builder: (context, completedActivities, child) {
        return Text(
          '${completedActivities.length}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        );
      },
    );

    // 찜 개수용 Widget (이미 favoriteCount는 String이지만, 일관성을 위해 텍스트 위젯으로 감쌈)
    final Widget favoriteCountWidget = Text(
      favoriteCount,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
    );

    // 나머지 카운트 위젯
    final Widget badgeCountWidget = Text(
      badgeCount,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
    );
    final Widget reviewCountWidget = Text(
      reviewCount,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
    );


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 🚨 [핵심 수정]: 체험 아이템에 실시간 카운트 위젯과 이동 로직 연결
          _buildActivityItem(
            Icons.star,
            '체험',
            '',
            countWidget: activityCountWidget,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => const ActivityListScreen()));
            },
          ),
          _buildActivityItem(Icons.folder, '배지', '', countWidget: badgeCountWidget),
          _buildActivityItem(Icons.chat_bubble, '리뷰', '', countWidget: reviewCountWidget),
          // 찜 아이템 클릭 시 LikeListScreen으로 이동
          _buildActivityItem(
              Icons.favorite,
              '찜',
              '',
              countWidget: favoriteCountWidget,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const LikeListScreen()));
              }
          ),
        ],
      ),
    );
  }

  // 경력 요약 및 나의 목표 섹션 위젯 (유지)
  Widget _buildCareerAndGoalSummary(
      Color accentColor, {
        required String careerYear,
        required String previousJob,
        required String gapYear,
        required String desiredJob,
        required String desiredReturnTime,
      }) {
    // IntrinsicHeight를 사용하여 두 Expanded 위젯의 높이를 강제로 같게 만듭니다.
    return IntrinsicHeight(
      child: Row(
        children: [
          // 경력 요약
          Expanded(
            child: _buildSummaryBlock(
              title: '경력 요약',
              icon: Icons.business_center,
              // 경력 요약 박스의 오른쪽 마진을 8로 설정하여 다음 박스 사이 간격을 확보
              margin: const EdgeInsets.only(left: 20, right: 8),
              content: [
                {'label': '경력', 'value': careerYear},
                {'label': '이전 직무', 'value': previousJob},
                {'label': '공백', 'value': gapYear},
              ],
            ),
          ),
          // 나의 목표
          Expanded(
            child: _buildSummaryBlock(
              title: '나의 목표',
              icon: Icons.flag,
              // 나의 목표 박스의 오른쪽 마진을 20으로 설정하여 Activity 박스의 끝에 맞춤
              margin: const EdgeInsets.only(left: 7, right: 20),
              content: [
                {'label': '희망 직무', 'value': desiredJob},
                {'label': '시기', 'value': desiredReturnTime},
              ],
              // 'action' 필드를 제거하여 목표 수정 버튼을 삭제합니다.
              action: null,
            ),
          ),
        ],
      ),
    );
  }

  // 재사용 가능한 요약 블록 위젯 (유지)
  Widget _buildSummaryBlock({
    required String title,
    required IconData icon,
    required List<Map<String, String>> content,
    required EdgeInsets margin,
    Widget? action,
  }) {
    // margin을 Container에 직접 적용
    return Container(
      margin: margin,
      // Padding을 horizontal 20으로 늘려서 내용을 오른쪽으로 이동 (이전 수정 유지)
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // 내용을 상단에 배치 (이전 수정 유지)
        mainAxisAlignment: action != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: customAccentColor),
                  const SizedBox(width: 5),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...content.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 레이블 너비를 70으로 고정하여 최대한 레이블이 한 줄로 표시되도록 함 (이전 수정 유지)
                      SizedBox(
                        width: 70, // 레이블에 충분한 너비 제공
                        child: Text(item['label']!, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                      ),
                      // Spacer의 flex 비율을 2로 다시 증가시켜 데이터 값을 오른쪽으로 '한 칸' 더 밉니다.
                      const Spacer(flex: 2), // 간격 증가 (이전 1)
                      Expanded(
                        flex: 3, // 데이터가 차지할 공간 유지 (이전 3)
                        child: Text(
                          item['value']!,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          // 왼쪽 정렬 유지 (이전 수정 유지)
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
          // 내용 아래에 Spacer를 추가하여 남은 공간을 채우고 내용을 상단에 유지합니다. (이전 수정 유지)
          if (action == null) const Spacer(),
          if (action != null)
            Align(
              alignment: Alignment.centerRight,
              child: action,
            ),
        ],
      ),
    );
  }

  // 보유 스킬 섹션 위젯 (유지)
  Widget _buildSkillsSection(Color accentColor, List<Map<String, dynamic>> skills) {
    // hasSkills 지역 변수 정의
    final bool hasSkills = skills.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, size: 20, color: Colors.amber.shade700),
              const SizedBox(width: 5),
              const Text(
                '보유 스킬',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 스킬이 없을 때 '-'를 중앙에 배치
          if (!hasSkills)
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10), // 적절한 높이 확보
              child: const Text(
                '-',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          else
            ...skills.map((skill) {
              final String skillName = skill['name'] as String;
              final int level = skill['level'] as int;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _buildSkillBar(skillName, level, customAccentColor),
              );
            }).toList(),
        ],
      ),
    );
  }

  // 스킬 바 위젯 (유지)
  Widget _buildSkillBar(String skillName, int level, Color accentColor) {
    // level은 1~5점
    final double progress = level / 5.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(skillName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            _buildRatingStars(level),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade200,
          valueColor: const AlwaysStoppedAnimation<Color>(customAccentColor),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  // 별점 위젯 (유지)
  Widget _buildRatingStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber.shade700,
          size: 16,
        );
      }),
    );
  }

  // 찜한 체험 및 이력서 관리 섹션 위젯
  Widget _buildFavoritesAndResumeSeparated(
      BuildContext context, Color accentColor, String favoriteCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // 찜한 체험 박스
          Expanded(
            child: _buildQuickActionButtonContainer(
              label: '찜한 체험',
              count: favoriteCount, // 🚨 [연결]: GlobalData에서 가져온 찜 개수 사용
              icon: Icons.favorite_border,
              accentColor: accentColor,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const LikeListScreen()));
              },
            ),
          ),
          const SizedBox(width: 15),
          // 이력서 박스 (유지)
          Expanded(
            child: _buildQuickActionButtonContainer(
              label: '이력서',
              count: '보기/수정',
              icon: Icons.description,
              accentColor: accentColor,
              onTap: () {
                // 이력서 관리 액션
              },
            ),
          ),
        ],
      ),
    );
  }

  // 퀵 액션 버튼을 위한 독립된 컨테이너 위젯 (흰색 박스) (유지)
  Widget _buildQuickActionButtonContainer({
    required String label,
    required String count,
    required IconData icon,
    required Color accentColor,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), spreadRadius: 1, blurRadius: 5)],
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5), // 내부 패딩
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: accentColor),
                  const SizedBox(width: 5),
                  Text(
                    label,
                    style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                count,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: accentColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}