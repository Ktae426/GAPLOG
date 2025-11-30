// activity_list.dart

import 'package:flutter/material.dart';
import 'global_data.dart';
import 'experience_detail.dart';
import 'experience.dart' show allExperiences;

class ActivityListScreen extends StatefulWidget {
  const ActivityListScreen({super.key});

  @override
  State<ActivityListScreen> createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  static const Color customAccentColor = Color(0xFF228B6A);


  List<Experience> _getCompletedExperiences(Set<String> completedTitles) {
    return allExperiences.where((experience) {
      return completedTitles.contains(experience.title);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<Set<String>>(
          valueListenable: GlobalData.completedActivitiesNotifier,
          builder: (context, completedTitles, child) {
            return Text('신청한 체험 목록 (${completedTitles.length}개)');
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: GlobalData.completedActivitiesNotifier,
        builder: (context, completedTitles, child) {
          final completedExperiences = _getCompletedExperiences(completedTitles);

          if (completedExperiences.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_border, size: 60, color: Colors.grey.shade400),
                    const SizedBox(height: 20),
                    Text(
                      '신청한 체험 활동이 없습니다.',
                      style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 10, bottom: 50),
            itemCount: completedExperiences.length,
            itemBuilder: (context, index) {
              final experience = completedExperiences[index];
              return _buildExperienceCard(context, experience);
            },
          );
        },
      ),
    );
  }


  Widget _buildExperienceCard(BuildContext context, Experience experience) {
    final Color darkGreen = customAccentColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '신청 완료',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF228B6A),
                ),
              ),
              const SizedBox(height: 10),


              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => ExperienceDetailScreen(
                        experience: experience,
                        onActivityCompleted: null,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                  Text('${experience.location} • ${experience.date}',
                                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // 설명
                    Text(experience.description, style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
                    const SizedBox(height: 10),

                    // 태그 목록
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('자세히 보기', style: TextStyle(color: darkGreen, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
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