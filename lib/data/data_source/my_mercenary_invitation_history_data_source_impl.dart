import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/data/data_source/my_mercenary_invitation_history_data_source.dart';
import 'package:mercenaryhub/data/dto/my_mercenary_invitation_history_dto.dart';

class MyMercenaryInvitationHistoryDataSourceImpl
    implements MyMercenaryInvitationHistoryDataSource {
  final FirebaseFirestore _firebaseFirestore;

  MyMercenaryInvitationHistoryDataSourceImpl(this._firebaseFirestore);

  @override
  Future<List<MyMercenaryInvitationHistoryDto>>
      fetchInvitationHistories() async {
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
        // 사용자 문서가 없으면 빈 배열로 초기화
        await _firebaseFirestore.collection('users').doc(currentUser.uid).set({
          'mercenaryInvitationHistory': [],
        }, SetOptions(merge: true));

        return [];
      }

      final userData = userDoc.data()!;
      final invitationList =
          userData['mercenaryInvitationHistory'] as List<dynamic>? ?? [];

      if (invitationList.isEmpty) {
        return [];
      }

      return invitationList.map((feedMap) {
        final map = Map<String, dynamic>.from(feedMap);
        return MyMercenaryInvitationHistoryDto.fromJson(map);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> inviteToMercenary(String feedId) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return false;
      }

      // 용병 피드 정보 가져오기
      final feedDoc = await _firebaseFirestore
          .collection('mercenaryFeeds')
          .doc(feedId)
          .get();

      if (!feedDoc.exists) {
        return false;
      }

      final feedData = feedDoc.data()!;

      // 고유한 초대 ID 생성
      final invitationId = _firebaseFirestore.collection('dummy').doc().id;
      final now = DateTime.now().toIso8601String();

      // 초대 내역 데이터 생성
      final invitationData = {
        'invitationId': invitationId, // 고유 ID 추가
        ...feedData,
        'feedId': feedId,
        'appliedAt': now,
        'status': 'pending',
      };

      // users 컬렉션에 추가
      final userDocRef =
          _firebaseFirestore.collection('users').doc(currentUser.uid);

      // 사용자 문서가 없으면 생성
      await userDocRef.set({
        'mercenaryInvitationHistory': [],
      }, SetOptions(merge: true));

      // 기존 초대 내역 확인 (중복 방지)
      final userDoc = await userDocRef.get();
      final existingInvitations = List<Map<String, dynamic>>.from(
          userDoc.data()?['mercenaryInvitationHistory'] ?? []);

      // 동일한 feedId로 pending 상태의 초대가 있는지 확인
      final hasPendingInvitation = existingInvitations.any((invitation) =>
          invitation['feedId'] == feedId && invitation['status'] == 'pending');

      if (hasPendingInvitation) {
        return false; // 이미 초대한 경우
      }

      // 새로운 초대 내역을 배열의 맨 앞에 추가 (최신순 정렬)
      existingInvitations.insert(0, invitationData);

      // 업데이트
      await userDocRef.update({
        'mercenaryInvitationHistory': existingInvitations,
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
