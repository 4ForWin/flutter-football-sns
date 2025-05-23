import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  kakao.User? kakaoUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      final user = await kakao.UserApi.instance.me();
      if (mounted) {
        setState(() {
          kakaoUser = user;
          isLoading = false;
        });
      }
    } catch (e) {
      print('사용자 정보 가져오기 실패: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        color: const Color(0xFFFFFFFF),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFFF5F5F5),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2BBB7D)),
                ),
              ),
              SizedBox(width: 16),
              Text(
                '프로필 정보를 불러오는 중...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 카카오 API에서 가져온 사용자 정보
    final profile = kakaoUser?.kakaoAccount?.profile;
    final nickname = profile?.nickname ?? '사용자';
    final email = kakaoUser?.kakaoAccount?.email ?? '이메일 정보 없음';
    final profileImageUrl = profile?.profileImageUrl;
    final thumbnailImageUrl = profile?.thumbnailImageUrl;

    // 프로필 이미지 우선순위: profileImageUrl > thumbnailImageUrl > 기본 이미지
    final imageUrl = profileImageUrl ?? thumbnailImageUrl;

    return Container(
      color: const Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFF5F5F5),
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
              onBackgroundImageError: imageUrl != null
                  ? (exception, stackTrace) {
                      print('프로필 이미지 로드 실패: $exception');
                      // 이미지 로드 실패 시 setState를 통해 기본 아이콘으로 변경할 수 있음
                    }
                  : null,
              child: imageUrl == null
                  ? Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.grey[600],
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nickname,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757B80),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // 새로고침 버튼
            IconButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                fetchUserInfo();
              },
              icon: const Icon(
                Icons.refresh,
                color: Color(0xFF757B80),
                size: 20,
              ),
              tooltip: '프로필 새로고침',
            ),
          ],
        ),
      ),
    );
  }
}
