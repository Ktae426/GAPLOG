// community.dart

import 'package:flutter/material.dart';
import 'global_data.dart';


class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  Widget _buildCommunitySectionHeader({
    required String title,
    required VoidCallback onActionTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          TextButton(
              onPressed: onActionTap,
              child: Text('전체보기',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600))),
        ],
      ),
    );
  }

  // 커뮤니티 게시판 블록 위젯 (인기, 후기, 고민, 자유)
  Widget _buildPostSection({
    required BuildContext context,
    required String title,
    required List<String> posts,
    required Color blockColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: blockColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCommunitySectionHeader(title: title, onActionTap: () => print('${title} 전체보기 클릭!')),
          ...List.generate(posts.length, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => CommunityDetailScreen(postTitle: posts[index])));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                width: double.infinity,
                child: Text(posts[index],
                    style: const TextStyle(fontSize: 15, height: 1.4), overflow: TextOverflow.ellipsis),
              ),
            );
          }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // 상단 아이콘 메뉴 위젯 (수정됨: 클릭 기능 추가)
  Widget _buildIconAction(String label, IconData icon) {
    return GestureDetector(
      onTap: () => print('$label 클릭됨!'), // 클릭 시 이벤트
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green.shade50,
            child: Icon(icon, color: Colors.green.shade600, size: 24),
          ),
          const SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('커뮤니티',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
            SizedBox(height: 4),
            Text('다양한 소식을 만나볼 수 있어요.', style: TextStyle(fontSize: 15, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications_none, size: 28, color: Colors.black87),
              onPressed: () => print('알림 클릭!')),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // 상단 아이콘 메뉴
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIconAction('스크랩', Icons.bookmark_border),
                  _buildIconAction('찜', Icons.favorite_border),
                  _buildIconAction('즐겨찾기', Icons.star_border),
                  _buildIconAction('내 활동', Icons.person_outline),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 1. 인기 게시판
            _buildPostSection(
              context: context,
              title: '인기 게시판',
              blockColor: Colors.green.shade50,
              posts: [
                '[고민] 3일 마케팅 체험 끝내고 다음 단계로...',
                '[후기] 공장 안전 관리 도우미 후기 남길게요! 🌟',
                '[후기] 리턴맵 100% 채운 후기',
                '[후기] 오늘은 집 근처에 새로 생긴 도서관을...'
              ],
            ),

            // 2. 후기 게시판
            _buildPostSection(
              context: context,
              title: '후기 게시판',
              blockColor: Colors.green.shade50,
              posts: [
                '[후기] 오늘은 집 근처에 새로 생긴 도서관을...',
                '[후기] 인천 모 직업전문학교 절대 다니지마...',
                '[후기] 재정관리사 따고 1년 후기, 지금 현재...',
                '[후기] 전문기술과정 비학위로 다녀본 후기...'
              ],
            ),

            // 3. 고민 게시판
            _buildPostSection(
              context: context,
              title: '고민 게시판',
              blockColor: Colors.green.shade50,
              posts: [
                '[고민] 곧 실직자 될 것 같은데 내일배움카드...',
                '[고민] 실업급여 강의 듣고 있는데, 1회 신청...',
                '[고민] 3일 마케팅 체험 끝내고 다음 단계로...'
              ],
            ),

            // 4. 자유 게시판
            _buildPostSection(
              context: context,
              title: '자유 게시판',
              blockColor: Colors.green.shade50,
              posts: [
                '[자유] 회사 이사님이 자꾸 나보고 계약기간...',
                '[자유] 잡코리아는 채용마감(서류검토) 뜨면...',
                '[자유] 포스코가 이직 사관학교라는데, 경력...'
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ====================================================================
// CommunityDetailScreen: 게시글 상세 화면
// ====================================================================

class CommunityDetailScreen extends StatelessWidget {
  final String postTitle;
  const CommunityDetailScreen({super.key, required this.postTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 상세'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            '선택된 게시글: "$postTitle"',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}