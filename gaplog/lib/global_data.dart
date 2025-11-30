
import 'package:flutter/material.dart';
import 'experience_detail.dart';


class GlobalData {
  // --- A. 온보딩 및 사용자 경력 정보 ---
  static bool isSkipped = true;
  static String career = '0년';
  static String previousJob = '-';
  static String gapYear = '-';
  static String desiredJob = '-';
  static String desiredReturnTime = '-';
  static List<Map<String, dynamic>> skills = [];

  // --- B. 리턴맵 진행 상태 (체크리스트) ---
  static bool isExperienceCompleted = false;
  static bool isEducationCompleted = false;
  static bool isLicenseCompleted = false;
  static bool isPartTimeCompleted = false;
  static bool isPortfolioCompleted = false;


  static final ValueNotifier<Set<String>> completedActivitiesNotifier =
  ValueNotifier<Set<String>>({});


  static int get activityCount => completedActivitiesNotifier.value.length;



  static final ValueNotifier<List<Experience>> favoritedExperiencesNotifier =
  ValueNotifier<List<Experience>>([]);

  static int get favoriteCount => favoritedExperiencesNotifier.value.length;

  static void toggleFavorite(Experience experience) {
    final List<Experience> currentList = favoritedExperiencesNotifier.value;
    final bool isCurrentlyFavorite = currentList.any((exp) => exp.title == experience.title);

    if (isCurrentlyFavorite) {
      // 찜 해제
      currentList.removeWhere((exp) => exp.title == experience.title);
    } else {
      // 찜 추가
      currentList.add(experience);
    }

    favoritedExperiencesNotifier.value = List.from(currentList);
  }

  static void addCompletedActivity(String title) {
    if (!completedActivitiesNotifier.value.contains(title)) {
      final currentSet = completedActivitiesNotifier.value;
      currentSet.add(title);
      completedActivitiesNotifier.value = Set.from(currentSet);
    }
  }


  // 내 정보 화면의 활동 카운트
  static int badgeCount = 0;    // 배지
  static int reviewCount = 0;   // 리뷰

  // --- C. 진행률 계산을 위한 가중치 ---
  static const Map<String, double> stepWeights = {
    '체험': 0.05,
    '교육 수료': 0.20,
    '자격증': 0.20,
    '파트타임': 0.35,
    '포트폴리오 완성': 0.20,
  };

  // --- D. 진행률 계산 속성 ---
  static double get currentProgress {
    double progress = 0.0;
    if (isExperienceCompleted) progress += stepWeights['체험']!;
    if (isEducationCompleted) progress += stepWeights['교육 수료']!;
    if (isLicenseCompleted) progress += stepWeights['자격증']!;
    if (isPartTimeCompleted) progress += stepWeights['파트타임']!;
    if (isPortfolioCompleted) progress += stepWeights['포트폴리오 완성']!;
    return progress;
  }
}

// SkillInput 모델
class SkillInput {
  String skillName = '';
  int level = 0;
  Key key = UniqueKey();

  SkillInput({this.skillName = '', this.level = 0});
}