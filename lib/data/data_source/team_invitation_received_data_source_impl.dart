import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/data/data_source/team_invitation_received_data_source.dart';
import 'package:mercenaryhub/data/dto/team_invitation_received_dto.dart';

class TeamInvitationReceivedDataSourceImpl
    implements TeamInvitationReceivedDataSource {
  final FirebaseFirestore _firebaseFirestore;

  TeamInvitationReceivedDataSourceImpl(this._firebaseFirestore);

  @override
  Future<List<TeamInvitationReceivedDto>> fetchTeamInvitations() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return [];
      }

      print('🥰 DataSource: 사용자 ${currentUser.uid}의 팀 초대 내역 조회 시작');

      // 현재는 용병이 받은 팀 초대를 저장할 컬렉션이 없으므로,
      // 임시로 teamInvitationReceived 필드를 users 컬렉션에 추가한다고 가정
      final userDoc = await _firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        print('❌ 사용자 문서가 존재하지 않습니다.');

        // 사용자 문서가 없으면 빈 배열로 초기화
        await _firebaseFirestore.collection('users').doc(currentUser.uid).set({
          'teamInvitationReceived': [],
        }, SetOptions(merge: true));

        return [];
      }

      final userData = userDoc.data()!;
      final invitationList =
          userData['teamInvitationReceived'] as List<dynamic>? ?? [];

      print('🥰 DataSource: ${invitationList.length}개의 팀 초대 내역 발견');

      if (invitationList.isEmpty) {
        return [];
      }

      return invitationList.map((invitationMap) {
        final map = Map<String, dynamic>.from(invitationMap);
        print('🥰 DataSource: 팀 초대 데이터: ${map['teamName']} - ${map['status']}');
        return TeamInvitationReceivedDto.fromJson(map);
      }).toList();
    } catch (e, s) {
      print('❌ fetchTeamInvitations error: $e');
      print('❌ fetchTeamInvitations stack: $s');
      return [];
    }
  }

  @override
  Future<bool> respondToTeamInvitation({
    required String feedId,
    required String response,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return false;
      }

      print('🥰 DataSource: feedId $feedId에 대한 응답 시작: $response');

      final userDocRef =
          _firebaseFirestore.collection('users').doc(currentUser.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        print('❌ 사용자 문서가 존재하지 않습니다.');
        return false;
      }

      final userData = userDoc.data()!;
      final invitationList = List<Map<String, dynamic>>.from(
          userData['teamInvitationReceived'] ?? []);

      // 해당 feedId의 상태 업데이트
      bool found = false;
      for (int i = 0; i < invitationList.length; i++) {
        if (invitationList[i]['feedId'] == feedId) {
          invitationList[i]['status'] = response;
          invitationList[i]['respondedAt'] = DateTime.now().toIso8601String();
          found = true;
          break;
        }
      }

      if (!found) {
        print('❌ 해당 feedId의 팀 초대 내역을 찾을 수 없습니다: $feedId');
        return false;
      }

      // 업데이트된 리스트로 저장
      await userDocRef.update({
        'teamInvitationReceived': invitationList,
      });

      print('✅ DataSource: 팀 초대 응답 완료');
      return true;
    } catch (e, s) {
      print('❌ respondToTeamInvitation error: $e');
      print('❌ respondToTeamInvitation stack: $s');
      return false;
    }
  }
}
