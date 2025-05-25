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
        print('❌ 로그인된 사용자가 없습니다.');
        return [];
      }

      print('🥰 DataSource: 사용자 ${currentUser.uid}의 초대 내역 조회 시작');

      final userDoc = await _firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        print('❌ 사용자 문서가 존재하지 않습니다.');

        // 사용자 문서가 없으면 빈 배열로 초기화
        await _firebaseFirestore.collection('users').doc(currentUser.uid).set({
          'mercenaryInvitationHistory': [],
        }, SetOptions(merge: true));

        return [];
      }

      final userData = userDoc.data()!;
      final invitationList =
          userData['mercenaryInvitationHistory'] as List<dynamic>? ?? [];

      print('🥰 DataSource: ${invitationList.length}개의 초대 내역 발견');

      if (invitationList.isEmpty) {
        return [];
      }

      return invitationList.map((feedMap) {
        final map = Map<String, dynamic>.from(feedMap);
        print('🥰 DataSource: 초대 내역 데이터: ${map['name']} - ${map['status']}');
        return MyMercenaryInvitationHistoryDto.fromJson(map);
      }).toList();
    } catch (e, s) {
      print('❌ fetchInvitationHistories error: $e');
      print('❌ fetchInvitationHistories stack: $s');
      return [];
    }
  }

  @override
  Future<bool> inviteToMercenary(String feedId) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return false;
      }

      print('🥰 DataSource: feedId $feedId로 용병 초대 시작');

      // 용병 피드 정보 가져오기
      final feedDoc = await _firebaseFirestore
          .collection('mercenaryFeeds')
          .doc(feedId)
          .get();

      if (!feedDoc.exists) {
        print('❌ 피드가 존재하지 않습니다: $feedId');
        return false;
      }

      final feedData = feedDoc.data()!;
      print('🥰 DataSource: 피드 데이터 조회 완료 - 용병명: ${feedData['name']}');

      // 초대 내역 데이터 생성
      final invitationData = {
        ...feedData,
        'feedId': feedId,
        'appliedAt': DateTime.now().toIso8601String(),
        'status': 'pending',
      };

      print('🥰 DataSource: 초대 데이터 생성 완료');

      // users 컬렉션에 추가
      final userDocRef =
          _firebaseFirestore.collection('users').doc(currentUser.uid);

      // 사용자 문서가 없으면 생성
      await userDocRef.set({
        'mercenaryInvitationHistory': [],
      }, SetOptions(merge: true));

      // 초대 내역 추가
      await userDocRef.update({
        'mercenaryInvitationHistory': FieldValue.arrayUnion([invitationData])
      });

      print('✅ DataSource: 용병 초대 데이터 저장 완료');
      return true;
    } catch (e, s) {
      print('❌ inviteToMercenary error: $e');
      print('❌ inviteToMercenary stack: $s');
      return false;
    }
  }
}
