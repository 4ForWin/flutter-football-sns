import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/data/data_source/my_team_application_history_data_source.dart';
import 'package:mercenaryhub/data/dto/my_team_application_history_dto.dart';

class MyTeamApplicationHistoryDataSourceImpl
    implements MyTeamApplicationHistoryDataSource {
  final FirebaseFirestore _firebaseFirestore;

  MyTeamApplicationHistoryDataSourceImpl(this._firebaseFirestore);

  @override
  Future<List<MyTeamApplicationHistoryDto>> fetchApplicationHistories() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return [];
      }

      print('🥰 DataSource: 사용자 ${currentUser.uid}의 신청 내역 조회 시작');

      final userDoc = await _firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        print('❌ 사용자 문서가 존재하지 않습니다.');

        // 사용자 문서가 없으면 빈 배열로 초기화
        await _firebaseFirestore.collection('users').doc(currentUser.uid).set({
          'teamApplicationHistory': [],
        }, SetOptions(merge: true));

        return [];
      }

      final userData = userDoc.data()!;
      final applicationList =
          userData['teamApplicationHistory'] as List<dynamic>? ?? [];

      print('🥰 DataSource: ${applicationList.length}개의 신청 내역 발견');

      if (applicationList.isEmpty) {
        return [];
      }

      return applicationList.map((feedMap) {
        final map = Map<String, dynamic>.from(feedMap);
        print(
            '🥰 DataSource: 신청 내역 데이터: ${map['teamName']} - ${map['status']}');
        return MyTeamApplicationHistoryDto.fromJson(map);
      }).toList();
    } catch (e, s) {
      print('❌ fetchApplicationHistories error: $e');
      print('❌ fetchApplicationHistories stack: $s');
      return [];
    }
  }

  @override
  Future<bool> applyToTeam(String feedId) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return false;
      }

      print('🥰 DataSource: feedId $feedId로 팀 신청 시작');

      // 팀 피드 정보 가져오기
      final feedDoc =
          await _firebaseFirestore.collection('teamFeeds').doc(feedId).get();

      if (!feedDoc.exists) {
        print('❌ 피드가 존재하지 않습니다: $feedId');
        return false;
      }

      final feedData = feedDoc.data()!;
      print('🥰 DataSource: 피드 데이터 조회 완료 - 팀명: ${feedData['teamName']}');

      // 신청 내역 데이터 생성
      final applicationData = {
        ...feedData,
        'feedId': feedId,
        'appliedAt': DateTime.now().toIso8601String(),
        'status': 'pending',
      };

      print('🥰 DataSource: 신청 데이터 생성 완료');

      // users 컬렉션에 추가
      final userDocRef =
          _firebaseFirestore.collection('users').doc(currentUser.uid);

      // 사용자 문서가 없으면 생성
      await userDocRef.set({
        'teamApplicationHistory': [],
      }, SetOptions(merge: true));

      // 신청 내역 추가
      await userDocRef.update({
        'teamApplicationHistory': FieldValue.arrayUnion([applicationData])
      });

      print('✅ DataSource: 팀 신청 데이터 저장 완료');
      return true;
    } catch (e, s) {
      print('❌ applyToTeam error: $e');
      print('❌ applyToTeam stack: $s');
      return false;
    }
  }
}
