

import 'package:flutter/material.dart';
import 'global_data.dart';


class Experience {
  final String title;
  final String description;
  final String company;
  final String date;
  final String location;
  final String tags;
  final IconData icon;
  final Color color;
  final String imagePath;
  final String detailImagePath;
  final String detailDescription;

  Experience({
    required this.title,
    required this.description,
    required this.company,
    required this.date,
    required this.location,
    required this.tags,
    required this.icon,
    required this.color,
    required this.imagePath,
    required this.detailImagePath,
    required this.detailDescription,
  });
}


class ExperienceDetailScreen extends StatefulWidget {
  final Experience experience;
  final VoidCallback? onActivityCompleted;

  const ExperienceDetailScreen({
    super.key,
    required this.experience,
    this.onActivityCompleted,
  });

  @override
  State<ExperienceDetailScreen> createState() => _ExperienceDetailScreenState();
}

class _ExperienceDetailScreenState extends State<ExperienceDetailScreen> {
  bool _isApplied = false;

  @override
  void initState() {
    super.initState();
    _isApplied = GlobalData.completedActivitiesNotifier.value.contains(widget.experience.title);
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    const Color customDarkGreen = Color(0xFF228B6A);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: customDarkGreen, size: 22),
        const SizedBox(width: 10),
        Text(
          '$label:',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // 하단 '신청하기' 버튼 위젯
  Widget _buildApplyButton(BuildContext context) {
    const Color customDarkGreen = Color(0xFF228B6A);

    final bool isButtonDisabled = _isApplied;
    final Color buttonColor = isButtonDisabled ? Colors.grey : customDarkGreen;
    final String buttonText = isButtonDisabled ? '신청 완료됨' : '신청하기';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: isButtonDisabled ? null : () {

              bool willProgressIncrease = !GlobalData.isExperienceCompleted;

              GlobalData.addCompletedActivity(widget.experience.title);

              setState(() {
                _isApplied = true;
              });

              if (willProgressIncrease) {
                if (widget.onActivityCompleted != null) {
                  widget.onActivityCompleted!();
                }
              }

              String snackbarText;
              if (willProgressIncrease) {
                snackbarText = '신청 완료되었습니다! (진행률 +5%)';
              } else {
                snackbarText = '신청 완료되었습니다!';
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(snackbarText)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    const Color customDarkGreen = Color(0xFF228B6A);

    const double cardVerticalMargin = 5.0;
    const double marginAfterImageCard = 15.0;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          // 뒤로가기 버튼을 누르면 화면을 닫고 이전 화면으로 복귀
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '경험 상세',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // 1. 이미지 섹션
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: widget.experience.detailImagePath.isNotEmpty
                            ? Image.asset(
                          widget.experience.detailImagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.campaign, size: 80, color: customDarkGreen),
                            );
                          },
                        )
                            : Container(
                          color: Colors.grey.shade200,
                          child: Icon(widget.experience.icon, size: 80, color: customDarkGreen),
                        ),
                      ),
                    ),
                  ),

                  // 2. 제목, 회사명, 태그 섹션 (소개 박스)
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.only(top: marginAfterImageCard, bottom: cardVerticalMargin),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.experience.title,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Company: ${widget.experience.company}',
                            style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: customDarkGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              widget.experience.tags,
                              style: TextStyle(
                                  fontSize: 13, color: customDarkGreen, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 3. 기간, 위치 등 상세 정보 섹션
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: const EdgeInsets.symmetric(vertical: cardVerticalMargin),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(Icons.calendar_today, 'Date', widget.experience.date),
                          const SizedBox(height: 12),
                          _buildInfoRow(Icons.location_on, 'Location', widget.experience.location),
                        ],
                      ),
                    ),
                  ),

                  // 4. 설명 섹션
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: const EdgeInsets.symmetric(vertical: cardVerticalMargin),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '상세 설명',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 10),
                          // detailDescription 필드 사용
                          Text(
                            widget.experience.detailDescription.isNotEmpty
                                ? widget.experience.detailDescription
                                : widget.experience.description,
                            style: TextStyle(fontSize: 15, color: Colors.grey.shade800, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 하단 고정 '신청하기' 버튼
          _buildApplyButton(context),
        ],
      ),
    );
  }
}