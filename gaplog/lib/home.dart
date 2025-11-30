

import 'package:flutter/material.dart';

import 'experience_detail.dart';
import 'experience.dart';
import 'information.dart';
import 'global_data.dart';
import 'community.dart' show CommunityScreen;
import 'returnmap.dart' show ReturnMapScreen;


final Experience marketingExperienceHome = Experience(
  title: '3일 마케팅 체험: 소셜 콘텐츠 기획',
  description: '단기간에 SNS 마케팅 기초부터 실전까지!',
  company: '㈜소셜브릿지',
  date: '3일',
  location: '전국',
  tags: '#마케팅',
  icon: Icons.campaign,
  color: Colors.green.shade500,
  imagePath: 'images/marketing.png',
  detailImagePath: 'images/marketing_detail.png',
  detailDescription: '''
“3일 마케팅 체험 프로그램”은 SNS 기반 디지털 마케팅을 처음 접하는 사람도 부담 없이 따라올 수 있도록 구성된 단기 실습 과정입니다.

첫째 날에는 인스타그램·틱톡 등 주요 플랫폼의 트렌드 분석과 브랜드 계정 운영 방식, 콘텐츠 유형별 특징을 배우며 기본기를 다집니다.

둘째 날에는 실제 기업 사례를 바탕으로 타깃 설정, 기획 방향 정리, 콘텐츠 스토리보드 작성 등 실습 중심 교육을 진행합니다.

마지막 날에는 직접 카드뉴스·릴스·숏폼 영상을 기획·제작해보고, 실무자에게 피드백을 받으며 실제 마케팅팀이 일하는 흐름을 경험해 볼 수 있습니다.

3일이라는 짧은 기간이지만, SNS 콘텐츠 제작 흐름 전체를 직접 경험할 수 있어 마케팅 직무 입문자, 경력 단절 여성, 혹은 부업을 고려하는 분들에게 특히 추천되는 프로그램입니다.
''',
);
final Experience safetyExperienceHome = Experience(
  title: '공장 안전 관리 도우미',
  description: '실무 경험 + 안전 자격증 취득 기회까지!',
  company: '신성 제조업',
  date: '2주',
  location: '수원',
  tags: '#안전관리',
  icon: Icons.safety_divider,
  color: Colors.green.shade500,
  imagePath: 'images/factory.png',
  detailImagePath: 'images/factory_detail.png',
  detailDescription: '''
"본 프로그램은 제조업 현장에서 필요한 안전 관리 실무를 기초부터 배우고, 관련 자격증 취득까지 연계하는 실전 중심 과정입니다.

2주 동안 산업안전·화재 예방·작업장 위험요소 점검·보호구 사용법 등 현장에서 바로 활용되는 실무를 경험하게 됩니다.

특히 여성 인력이 안정적으로 일할 수 있는 직종으로 선호도가 높아, 40대 이상 경력 단절 여성에게 새로운 커리어 전환 기회로 평가받고 있습니다.

교육 이수 후에는 산업안전 관련 초급 자격증 시험 응시를 지원하며, 공장·창고·제조라인 등 다양한 사업장에서 안전 관리 보조 인력으로 취업할 수 있는 실질적인 취업 연계도 제공됩니다.

몸을 많이 쓰는 작업이 아니라 관리·점검 중심이기 때문에 체력 부담이 적고, 장기적으로 안정적인 근무 환경을 기대할 수 있습니다."
''',
);
final Experience dataExperienceHome = Experience(
  title: '데이터 라벨링 알바',
  description: '재택 가능! 단순 반복 업무로 용돈 벌어요.',
  company: 'AI랩',
  date: '5일',
  location: '전국',
  tags: '#초보가능',
  icon: Icons.bar_chart,
  color: Colors.green.shade500,
  imagePath: 'images/data.png',
  detailImagePath: 'images/data_detail.png',
  detailDescription: '''
"데이터 라벨링 업무는 인공지능(AI)이 학습할 수 있도록 이미지·텍스트·음성 데이터를 분류하고 태그를 붙이는 작업입니다.

컴퓨터 사용에 익숙하지 않아도 쉽게 배울 수 있으며, 대부분 재택으로 가능하기 때문에 시간 활용이 자유롭습니다.

작업 예시로는 사진 속 객체 표시, 간단한 문장 분류, 음성 텍스트 정리 등이 있으며, 반복적인 업무가 많아 초보자도 빠르게 적응할 수 있습니다.

이 프로그램에서는 5일 동안 기본 툴 사용법, 품질 기준, 작업 요령 등을 배우고 실제 작업을 수행해보며 실전 감각을 익히게 됩니다.

꾸준히 작업할 경우 부업·용돈벌이용으로 적합하며, 최근 AI 산업 성장으로 꾸준한 수요가 기대되는 분야입니다."
''',
);
final Experience internetExperienceHome = Experience(
  title: '출장 인터넷 수리',
  description: '인터넷 수리 기사를 8주 안에 배출할 수 있는 기회!',
  company: 'SKT 협력사',
  date: '8주',
  location: '대전',
  tags: '#초보가능',
  icon: Icons.router,
  color: Colors.green.shade500,
  imagePath: 'images/internet.png',
  detailImagePath: 'images/internet_detail.png',
  detailDescription: '''
"출장 인터넷 수리 전문가 과정”은 8주 동안 인터넷 회선 설치·점검·수리 기술을 집중적으로 배우는 실무형 교육입니다.

초보자를 기준으로 커리큘럼이 구성되어 있어 전문 지식이 없어도 시작할 수 있으며, 현직 기사와 함께 장비 사용법, 네트워크 기초, 광랜 구조, 단말기 세팅, 고객 응대 노하우까지 폭넓게 학습하게 됩니다.

교육 후에는 실제 현장에 동행하며 수리기사의 하루 업무 흐름을 경험하고, 협력사와의 취업 연계 기회도 제공됩니다.

기술 기반 직종이라 꾸준한 수요가 있고, 일정 수준의 숙련도를 갖추면 안정적인 수입도 기대할 수 있어 20–50대 지원자에게 인기가 높은 프로그램입니다.

8주라는 비교적 짧은 기간 동안 실무 중심 교육과 현장 경험을 통해 바로 취업 가능한 실전 스킬을 확보할 수 있습니다."
''',
);


class AppNavigator extends StatefulWidget {
  final VoidCallback onSignOut;
  const AppNavigator({super.key, required this.onSignOut});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  int _currentIndex = 2; // 홈 탭으로 시작

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToTab(int index) {
    _onItemTapped(index);
  }

  // 탭 인덱스 매핑: 0: 리턴맵, 1: 검색(ExperienceListScreen), 2: 홈, 3: 커뮤니티, 4: 내 정보
  late final List<Widget> _screens = [
    // 0: 리턴맵
    ReturnMapScreen(onNavigateToSearch: () => _navigateToTab(1)),
    // 1: 검색
    const ExperienceListScreen(),
    // 2: 홈
    HomeScreen(
      key: UniqueKey(),
      onNavigateToCommunity: () => _navigateToTab(3),
      onNavigateToSearch: () => _navigateToTab(1),
      onNavigateToReturnMap: () => _navigateToTab(0),
    ),
    // 3: 커뮤니티
    const CommunityScreen(),
    // 4: 내 정보
    MyInfoScreen(key: UniqueKey(), onSignOut: widget.onSignOut),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF228B6A),
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: '리턴맵'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: '커뮤니티'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onNavigateToCommunity;
  final VoidCallback onNavigateToSearch;
  final VoidCallback onNavigateToReturnMap;

  const HomeScreen({
    super.key,
    required this.onNavigateToCommunity,
    required this.onNavigateToSearch,
    required this.onNavigateToReturnMap,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 전역으로 사용할 커스텀 색상 정의
  static const Color customDarkGreen = Color(0xFF228B6A);

  Widget _buildSectionHeader(
      BuildContext context, {
        required String title,
        required String actionText,
        required VoidCallback onActionTap,
      }) {
    final bool showActionButton = actionText.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          if (showActionButton)
            TextButton(
              onPressed: onActionTap,
              child: Text(actionText,
                  style:
                  const TextStyle(fontSize: 14, color: customDarkGreen, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  // 단기 경험 블록
  Widget _buildExperienceBlock({
    required BuildContext context,
    required Experience experience,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Row(
          children: [
            // 아이콘/이미지 컨테이너
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: experience.imagePath.isNotEmpty
                    ? Image.asset(
                  experience.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(experience.icon, color: customDarkGreen, size: 36);
                  },
                )
                    : Icon(experience.icon, color: customDarkGreen, size: 36),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(experience.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          experience.description,
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => ExperienceDetailScreen(
                                  experience: experience,
                                  onActivityCompleted: null,
                                )),
                          );
                        },
                        child: const Text('자세히 보기',
                            style: TextStyle(color: customDarkGreen, fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 리턴맵 블록
  Widget _buildReturnMapBlock({required double progress, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          widget.onNavigateToReturnMap();
        },
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('다음 단계까지 체험 1개! 🎯',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(customDarkGreen),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('${(progress * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 커뮤니티 블록
  Widget _buildCommunityBlock({
    required Function(int) onTap,
  }) {
    final List<String> posts = [
      '[고민] 3일 마케팅 체험 끝내고 다음 단계로...',
      '[후기] 공장 안전 관리 도우미 후기 남길게요! 🌟',
      '[후기] 리턴맵 100% 채운 후기',
      '[후기] 오늘은 집 근처에 새로 생긴 도서관을...',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: List.generate(posts.length, (index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    print('홈 화면에서 게시글 ${index + 1} 클릭!');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(posts[index],
                              style: const TextStyle(fontSize: 15, height: 1.4), overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
                if (index < posts.length - 1) Divider(height: 1, color: Colors.grey.shade200),
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Experience marketingExperience = marketingExperienceHome;
    final Experience safetyExperience = safetyExperienceHome;
    final Experience dataExperience = dataExperienceHome;
    final Experience internetExperience = internetExperienceHome;

    // GlobalData에서 진행률을 직접 참조
    final double currentProgress = GlobalData.currentProgress;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('은정님, 반가워요!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                SizedBox(height: 5),
                Text('오늘의 추천 활동을 확인해보세요.', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ),

          // 단기 경험 섹션
          _buildSectionHeader(
            context,
            title: '나에게 맞는 단기 경험',
            actionText: '전체보기',
            onActionTap: widget.onNavigateToSearch, // 검색 탭으로 이동
          ),
          const SizedBox(height: 5),
          // 4개 항목을 모두 표시
          _buildExperienceBlock(context: context, experience: marketingExperience),
          _buildExperienceBlock(context: context, experience: safetyExperience),
          _buildExperienceBlock(context: context, experience: dataExperience),
          _buildExperienceBlock(context: context, experience: internetExperience),
          const SizedBox(height: 22), // 섹션 간 총 간격

          // 리턴맵 섹션
          _buildSectionHeader(
            context,
            title: '나의 리턴맵 보기',
            actionText: '', // '자세히' 텍스트 제거
            onActionTap: widget.onNavigateToReturnMap,
          ),
          const SizedBox(height: 5),
          // GlobalData에서 진행률을 참조
          _buildReturnMapBlock(progress: currentProgress, context: context),
          const SizedBox(height: 22), // 섹션 간 총 간격

          // 커뮤니티 섹션
          _buildSectionHeader(
            context,
            title: '커뮤니티',
            actionText: '전체보기',
            onActionTap: widget.onNavigateToCommunity, // 커뮤니티 탭으로 이동
          ),
          const SizedBox(height: 5),
          _buildCommunityBlock(onTap: (index) => print('홈 화면에서 게시글 $index 클릭!')),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}