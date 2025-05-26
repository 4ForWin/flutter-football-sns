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
        return [];
      }

      final userDoc = await _firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        return [];
      }

      final userData = userDoc.data()!;
      final applicationList =
          userData['teamApplicationHistory'] as List<dynamic>? ?? [];

      if (applicationList.isEmpty) {
        return [];
      }

      return applicationList.map((feedMap) {
        final map = Map<String, dynamic>.from(feedMap);
        return MyTeamApplicationHistoryDto.fromJson(map);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> applyToTeam(String feedId) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return false;
      }

      final userDocRef =
          _firebaseFirestore.collection('users').doc(currentUser.uid);

      return await _firebaseFirestore.runTransaction((transaction) async {
        // 먼저 현재 사용자 문서 읽기
        final userDoc = await transaction.get(userDocRef);

        List<Map<String, dynamic>> existingApplications = [];

        if (userDoc.exists) {
          final userData = userDoc.data()!;
          existingApplications = List<Map<String, dynamic>>.from(
              userData['teamApplicationHistory'] ?? []);
        }

        // 중복 체크
        final hasPendingApplication = existingApplications.any(
            (app) => app['feedId'] == feedId && app['status'] == 'pending');

        if (hasPendingApplication) {
          return false;
        }

        // 팀 피드 정보 가져오기
        final feedDoc = await transaction
            .get(_firebaseFirestore.collection('teamFeeds').doc(feedId));

        if (!feedDoc.exists) {
          return false;
        }

        final feedData = feedDoc.data()!;

        // 고유한 신청 ID 생성
        final applicationId = _firebaseFirestore.collection('dummy').doc().id;
        final now = DateTime.now().toIso8601String();

        // 신청 내역 데이터 생성
        final applicationData = {
          'applicationId': applicationId,
          ...feedData,
          'feedId': feedId,
          'appliedAt': now,
          'status': 'pending',
        };

        // 새로운 신청 내역을 배열의 맨 앞에 추가
        existingApplications.insert(0, applicationData);

        // 트랜잭션으로 업데이트
        transaction.set(
            userDocRef,
            {
              'teamApplicationHistory': existingApplications,
            },
            SetOptions(merge: true));

        return true;
      });
    } catch (e) {
      return false;
    }
  }
}
