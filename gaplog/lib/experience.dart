

import 'package:flutter/material.dart';
import 'experience_detail.dart';
import 'community.dart';
import 'returnmap.dart';
import 'global_data.dart'; 

var allExperiencesData = [
  {
    'title': '3일 마케팅 체험: 소셜 콘텐츠 기획',
    'description': '단기간에 SNS 마케팅 기초부터 실전까지!',
    'company': '㈜소셜브릿지',
    'date': '3일',
    'location': '전국',
    'tags': '#마케팅',
    'icon': Icons.all_inclusive,
    'color': Colors.green.shade50,
    'is_favorite': true,
    'participants': 20,
    'rating': 4.7,
    'imagePath': 'images/marketing.png',
    'detailImagePath': 'images/marketing_detail.png',
    'detailDescription': '''
“3일 마케팅 체험 프로그램”은 SNS 기반 디지털 마케팅을 처음 접하는 사람도 부담 없이 따라올 수 있도록 구성된 단기 실습 과정입니다.

첫째 날에는 인스타그램·틱톡 등 주요 플랫폼의 트렌드 분석과 브랜드 계정 운영 방식, 콘텐츠 유형별 특징을 배우며 기본기를 다집니다.

둘째 날에는 실제 기업 사례를 바탕으로 타깃 설정, 기획 방향 정리, 콘텐츠 스토리보드 작성 등 실습 중심 교육을 진행합니다.

마지막 날에는 직접 카드뉴스·릴스·숏폼 영상을 기획·제작해보고, 실무자에게 피드백을 받으며 실제 마케팅팀이 일하는 흐름을 경험해 볼 수 있습니다.

3일이라는 짧은 기간이지만, SNS 콘텐츠 제작 흐름 전체를 직접 경험할 수 있어 마케팅 직무 입문자, 경력 단절 여성, 혹은 부업을 고려하는 분들에게 특히 추천되는 프로그램입니다.
''',
  },
  {
    'title': '공장 안전 관리 도우미',
    'description': '실무 경험 + 안전 자격증 취득 기회까지!',
    'company': '신성 제조업',
    'date': '2주',
    'location': '수원',
    'tags': '#안전관리',
    'icon': Icons.build,
    'color': Colors.green.shade50,
    'is_favorite': false,
    'participants': 40,
    'rating': 4.3,
    'imagePath': 'images/factory.png',
    'detailImagePath': 'images/factory_detail.png',
    'detailDescription': '''
"본 프로그램은 제조업 현장에서 필요한 안전 관리 실무를 기초부터 배우고, 관련 자격증 취득까지 연계하는 실전 중심 과정입니다.

2주 동안 산업안전·화재 예방·작업장 위험요소 점검·보호구 사용법 등 현장에서 바로 활용되는 실무를 경험하게 됩니다.

특히 여성 인력이 안정적으로 일할 수 있는 직종으로 선호도가 높아, 40대 이상 경력 단절 여성에게 새로운 커리어 전환 기회로 평가받고 있습니다.

교육 이수 후에는 산업안전 관련 초급 자격증 시험 응시를 지원하며, 공장·창고·제조라인 등 다양한 사업장에서 안전 관리 보조 인력으로 취업할 수 있는 실질적인 취업 연계도 제공됩니다.

몸을 많이 쓰는 작업이 아니라 관리·점검 중심이기 때문에 체력 부담이 적고, 장기적으로 안정적인 근무 환경을 기대할 수 있습니다."
''',
  },
  {
    'title': '데이터 라벨링 알바',
    'description': '재택 가능! 단순 반복 업무로 용돈 벌어요.',
    'company': 'AI 랩',
    'date': '3일',
    'location': '전국',
    'tags': '#보통 #인센티브지급 #초보가능',
    'icon': Icons.auto_stories,
    'color': Colors.green.shade50,
    'is_favorite': false,
    'participants': 58,
    'rating': 4.8,
    'imagePath': 'images/data.png',
    'detailImagePath': 'images/data_detail.png',
    'detailDescription': '''
"데이터 라벨링 업무는 인공지능(AI)이 학습할 수 있도록 이미지·텍스트·음성 데이터를 분류하고 태그를 붙이는 작업입니다.

컴퓨터 사용에 익숙하지 않아도 쉽게 배울 수 있으며, 대부분 재택으로 가능하기 때문에 시간 활용이 자유롭습니다.

작업 예시로는 사진 속 객체 표시, 간단한 문장 분류, 음성 텍스트 정리 등이 있으며, 반복적인 업무가 많아 초보자도 빠르게 적응할 수 있습니다.

이 프로그램에서는 5일 동안 기본 툴 사용법, 품질 기준, 작업 요령 등을 배우고 실제 작업을 수행해보며 실전 감각을 익히게 됩니다.

꾸준히 작업할 경우 부업·용돈벌이용으로 적합하며, 최근 AI 산업 성장으로 꾸준한 수요가 기대되는 분야입니다."
''',
  },
  {
    'title': '출장 인터넷 수리',
    'description': '인터넷 수리 기사를 8주 안에 배출할 수 있는 기회!',
    'company': 'SKT 협력사',
    'date': '8주',
    'location': '대전',
    'tags': '#다소복잡 #40만원 #장기',
    'icon': Icons.monitor,
    'color': Colors.green.shade50,
    'is_favorite': false,
    'participants': 30,
    'rating': 4.1,
    'imagePath': 'images/internet.png',
    'detailImagePath': 'images/internet_detail.png',
    'detailDescription': '''
"출장 인터넷 수리 전문가 과정”은 8주 동안 인터넷 회선 설치·점검·수리 기술을 집중적으로 배우는 실무형 교육입니다.

초보자를 기준으로 커리큘럼이 구성되어 있어 전문 지식이 없어도 시작할 수 있으며, 현직 기사와 함께 장비 사용법, 네트워크 기초, 광랜 구조, 단말기 세팅, 고객 응대 노하우까지 폭넓게 학습하게 됩니다.

교육 후에는 실제 현장에 동행하며 수리기사의 하루 업무 흐름을 경험하고, 협력사와의 취업 연계 기회도 제공됩니다.

기술 기반 직종이라 꾸준한 수요가 있고, 일정 수준의 숙련도를 갖추면 안정적인 수입도 기대할 수 있어 20–50대 지원자에게 인기가 높은 프로그램입니다.

8주라는 비교적 짧은 기간 동안 실무 중심 교육과 현장 경험을 통해 바로 취업 가능한 실전 스킬을 확보할 수 있습니다."
''',
  },
];


List<Experience> convertToExperienceObjects() {
  return allExperiencesData.map((data) => Experience(
    title: data['title'] as String,
    description: data['description'] as String,
    company: data['company'] as String,
    date: data['date'] as String,
    location: data['location'] as String,
    tags: data['tags'] as String,
    icon: data['icon'] as IconData,
    color: data['color'] as Color,
    imagePath: data['imagePath'] as String,
    detailImagePath: data['detailImagePath'] as String,
    detailDescription: data['detailDescription'] as String,
  )).toList();
}

final List<Experience> allExperiences = convertToExperienceObjects();


class ExperienceListScreen extends StatefulWidget {
  final VoidCallback? onActivityCompleted;

  const ExperienceListScreen({super.key, this.onActivityCompleted});

  @override
  State<ExperienceListScreen> createState() => _ExperienceListScreenState();
}

class _ExperienceListScreenState extends State<ExperienceListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredExperiencesData = allExperiencesData;
  String _currentQuery = '';
  static const Color customAccentColor = Color(0xFF228B6A);

  // 찜 상태를 관리할 Set
  Set<String> _favoriteTitles = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _initializeFavorites();
    GlobalData.favoritedExperiencesNotifier.addListener(_initializeFavorites);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    GlobalData.favoritedExperiencesNotifier.removeListener(_initializeFavorites);
    _searchController.dispose();
    super.dispose();
  }

  void _initializeFavorites() {
    final currentFavoriteTitles = GlobalData.favoritedExperiencesNotifier.value.map((e) => e.title).toSet();
    setState(() {
      _favoriteTitles = currentFavoriteTitles;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    if (query == _currentQuery) return;

    setState(() {
      _currentQuery = query;
      if (query.isEmpty) {
        _filteredExperiencesData = allExperiencesData;
      } else {
        _filteredExperiencesData = allExperiencesData.where((data) {
          final title = data['title'] as String? ?? '';
          final location = data['location'] as String? ?? '';
          final tags = data['tags'] as String? ?? '';
          return title.toLowerCase().contains(query) ||
              location.toLowerCase().contains(query) ||
              tags.toLowerCase().contains(query);
        }).toList();
      }
    });
  }


  void _toggleFavorite(String title, Experience experience) {
    bool isCurrentlyFavorite = GlobalData.favoritedExperiencesNotifier.value.any((exp) => exp.title == title);

    GlobalData.toggleFavorite(experience);

    setState(() {
      final dataIndex = allExperiencesData.indexWhere((data) => data['title'] == title);
      if (dataIndex != -1) {
        allExperiencesData[dataIndex]['is_favorite'] = !isCurrentlyFavorite;
      }
      _onSearchChanged();
    });


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCurrentlyFavorite
            ? '찜 목록에서 해제되었습니다. (현재 찜 ${GlobalData.favoriteCount}개)'
            : '찜 목록에 추가되었습니다! (현재 찜 ${GlobalData.favoriteCount}개)'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _updateReturnMapStatus() {

    GlobalData.isExperienceCompleted = true;
    print("체험 단계 완료 상태: ${GlobalData.isExperienceCompleted}");
  }

  void _handleActivityCompletion() {
    _updateReturnMapStatus();
  }


  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '새로운 경험의 첫 걸음',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '작은 경험이 큰 변화로 이어져요.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: _buildSearchField(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            if (_filteredExperiencesData.isEmpty)
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                    child: Text("검색 결과가 없습니다.",
                        style: TextStyle(fontSize: 18, color: Colors.grey.shade600))),
              )
            else
              ..._filteredExperiencesData.asMap().entries.map((entry) {
                final int index = entry.key;
                final Map<String, dynamic> data = entry.value;
                final experience = Experience(
                  title: data['title'] as String,
                  description: data['description'] as String,
                  company: data['company'] as String,
                  date: data['date'] as String,
                  location: data['location'] as String,
                  tags: data['tags'] as String,
                  icon: data['icon'] as IconData,
                  color: data['color'] as Color,
                  imagePath: data['imagePath'] as String,
                  detailImagePath: data['detailImagePath'] as String,
                  detailDescription: data['detailDescription'] as String,
                );
                return _buildExperienceCard(context, experience, data.cast<String, Object>(), index);
              }).toList(),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 0.8),
      ),
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: '관심 지역이나 직무로 찾아보세요 (예: 대전)',
          hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 16),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // 단기 경험 카드 위젯
  Widget _buildExperienceCard(
      BuildContext context, Experience experience, Map<String, Object> data, int index) {
    final Color darkGreen = customAccentColor;
    final double matchRate = 95 - (allExperiencesData.indexWhere((d) => d['title'] == experience.title) * 25).toDouble();

    // 찜 상태 결정
    final bool isFavorite = GlobalData.favoritedExperiencesNotifier.value.any((exp) => exp.title == experience.title);
    final IconData favoriteIcon = isFavorite ? Icons.favorite : Icons.favorite_border;
    final Color favoriteColor = isFavorite ? Colors.red : Colors.grey.shade400;

    Color matchTextColor;
    String matchDescription;

    if (matchRate >= 90) {
      matchTextColor = darkGreen;
      matchDescription = '은정님께 딱 맞아요!';
    } else if (matchRate >= 50) {
      matchTextColor = Colors.orange.shade700;
      matchDescription = '은정님께 어울릴 수도 있어요.';
    } else {
      matchTextColor = Colors.red.shade600;
      matchDescription = '은정님께 맞지 않아요.';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ExperienceDetailScreen(
                  experience: experience,
                  onActivityCompleted: _handleActivityCompletion,
                )),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: darkGreen.withOpacity(0.3), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 매칭률 헤더
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'AI 매칭률 ${matchRate.toInt()}% - $matchDescription',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: matchTextColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(favoriteIcon, color: favoriteColor, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      _toggleFavorite(experience.title, experience);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: experience.color.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        experience.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(experience.icon, color: darkGreen, size: 24);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          experience.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 14, color: darkGreen),
                            Text('${data['location'] as String} • ${data['date'] as String}',
                                style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Text(experience.description, style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
              const SizedBox(height: 10),

              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: experience.tags
                    .split(' ')
                    .where((tag) => tag.isNotEmpty)
                    .map((tag) => _buildTag(tag))
                    .toList(),
              ),
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 14, color: darkGreen),
                      Text(' ${data['participants'] as int}명 참여중',
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                      const SizedBox(width: 10),
                      Icon(Icons.star, size: 14, color: Colors.amber.shade700),
                      Text(' ${data['rating'] as double}',
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                    ],
                  ),
                  Text('자세히 보기', style: TextStyle(color: darkGreen, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 태그 위젯
  Widget _buildTag(String tag) {
    if (tag.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        tag,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
      ),
    );
  }
}