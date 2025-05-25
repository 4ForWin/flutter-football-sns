import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApplicationStatusService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 팀 신청 상태 업데이트 (용병이 자신의 신청을 취소하는 경우)
  static Future<bool> updateTeamApplicationStatus({
    required String feedId,
    required String newStatus,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return false;
      }

      print('🔄 팀 신청 상태 업데이트 시작: $feedId -> $newStatus');

      final userDocRef = _firestore.collection('users').doc(currentUser.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        print('❌ 사용자 문서가 존재하지 않습니다.');
        return false;
      }

      final userData = userDoc.data()!;
      final applicationList = List<Map<String, dynamic>>.from(
          userData['teamApplicationHistory'] ?? []);

      // 해당 feedId의 상태 업데이트
      bool found = false;
      for (int i = 0; i < applicationList.length; i++) {
        if (applicationList[i]['feedId'] == feedId) {
          applicationList[i]['status'] = newStatus;
          applicationList[i]['updatedAt'] = DateTime.now().toIso8601String();
          found = true;
          break;
        }
      }

      if (!found) {
        print('❌ 해당 feedId의 신청 내역을 찾을 수 없습니다: $feedId');
        return false;
      }

      // 업데이트된 리스트로 저장
      await userDocRef.update({
        'teamApplicationHistory': applicationList,
      });

      print('✅ 팀 신청 상태 업데이트 완료: $feedId -> $newStatus');
      return true;
    } catch (e, s) {
      print('❌ updateTeamApplicationStatus error: $e');
      print('❌ Stack trace: $s');
      return false;
    }
  }

  /// 용병 초대 상태 업데이트 (팀이 자신의 초대를 취소하는 경우)
  static Future<bool> updateMercenaryInvitationStatus({
    required String feedId,
    required String newStatus,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return false;
      }

      print('🔄 용병 초대 상태 업데이트 시작: $feedId -> $newStatus');

      final userDocRef = _firestore.collection('users').doc(currentUser.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        print('❌ 사용자 문서가 존재하지 않습니다.');
        return false;
      }

      final userData = userDoc.data()!;
      final invitationList = List<Map<String, dynamic>>.from(
          userData['mercenaryInvitationHistory'] ?? []);

      // 해당 feedId의 상태 업데이트
      bool found = false;
      for (int i = 0; i < invitationList.length; i++) {
        if (invitationList[i]['feedId'] == feedId) {
          invitationList[i]['status'] = newStatus;
          invitationList[i]['updatedAt'] = DateTime.now().toIso8601String();
          found = true;
          break;
        }
      }

      if (!found) {
        print('❌ 해당 feedId의 초대 내역을 찾을 수 없습니다: $feedId');
        return false;
      }

      // 업데이트된 리스트로 저장
      await userDocRef.update({
        'mercenaryInvitationHistory': invitationList,
      });

      print('✅ 용병 초대 상태 업데이트 완료: $feedId -> $newStatus');
      return true;
    } catch (e, s) {
      print('❌ updateMercenaryInvitationStatus error: $e');
      print('❌ Stack trace: $s');
      return false;
    }
  }
}
