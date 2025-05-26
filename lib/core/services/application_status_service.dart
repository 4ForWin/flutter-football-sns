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
        return false;
      }

      final userDocRef = _firestore.collection('users').doc(currentUser.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        return false;
      }

      final userData = userDoc.data()!;
      final applicationList = List<Map<String, dynamic>>.from(
          userData['teamApplicationHistory'] ?? []);

      // 해당 feedId의 가장 최근 pending 상태 신청을 찾아서 업데이트
      bool found = false;
      for (int i = 0; i < applicationList.length; i++) {
        if (applicationList[i]['feedId'] == feedId &&
            applicationList[i]['status'] == 'pending') {
          applicationList[i]['status'] = newStatus;
          applicationList[i]['updatedAt'] = DateTime.now().toIso8601String();
          found = true;
          break; // 가장 최근 것만 업데이트
        }
      }

      if (!found) {
        return false;
      }

      // 업데이트된 리스트로 저장
      await userDocRef.update({
        'teamApplicationHistory': applicationList,
      });

      return true;
    } catch (e, s) {
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
        return false;
      }

      final userDocRef = _firestore.collection('users').doc(currentUser.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        return false;
      }

      final userData = userDoc.data()!;
      final invitationList = List<Map<String, dynamic>>.from(
          userData['mercenaryInvitationHistory'] ?? []);

      // 해당 feedId의 가장 최근 pending 상태 초대를 찾아서 업데이트
      bool found = false;
      for (int i = 0; i < invitationList.length; i++) {
        if (invitationList[i]['feedId'] == feedId &&
            invitationList[i]['status'] == 'pending') {
          invitationList[i]['status'] = newStatus;
          invitationList[i]['updatedAt'] = DateTime.now().toIso8601String();
          found = true;
          break; // 가장 최근 것만 업데이트
        }
      }

      if (!found) {
        return false;
      }

      // 업데이트된 리스트로 저장
      await userDocRef.update({
        'mercenaryInvitationHistory': invitationList,
      });

      return true;
    } catch (e, s) {
      return false;
    }
  }

  /// 특정 ID로 팀 신청 상태 업데이트 (더 정확한 업데이트를 위한 메서드)
  static Future<bool> updateTeamApplicationStatusById({
    required String applicationId,
    required String newStatus,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        return false;
      }

      final userDocRef = _firestore.collection('users').doc(currentUser.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        return false;
      }

      final userData = userDoc.data()!;
      final applicationList = List<Map<String, dynamic>>.from(
          userData['teamApplicationHistory'] ?? []);

      // 해당 applicationId를 찾아서 업데이트
      bool found = false;
      for (int i = 0; i < applicationList.length; i++) {
        if (applicationList[i]['applicationId'] == applicationId) {
          applicationList[i]['status'] = newStatus;
          applicationList[i]['updatedAt'] = DateTime.now().toIso8601String();
          found = true;
          break;
        }
      }

      if (!found) {
        return false;
      }

      await userDocRef.update({
        'teamApplicationHistory': applicationList,
      });

      return true;
    } catch (e, s) {
      return false;
    }
  }

  /// 특정 ID로 용병 초대 상태 업데이트 (더 정확한 업데이트를 위한 메서드)
  static Future<bool> updateMercenaryInvitationStatusById({
    required String invitationId,
    required String newStatus,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        return false;
      }

      final userDocRef = _firestore.collection('users').doc(currentUser.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        return false;
      }

      final userData = userDoc.data()!;
      final invitationList = List<Map<String, dynamic>>.from(
          userData['mercenaryInvitationHistory'] ?? []);

      // 해당 invitationId를 찾아서 업데이트
      bool found = false;
      for (int i = 0; i < invitationList.length; i++) {
        if (invitationList[i]['invitationId'] == invitationId) {
          invitationList[i]['status'] = newStatus;
          invitationList[i]['updatedAt'] = DateTime.now().toIso8601String();
          found = true;
          break;
        }
      }

      if (!found) {
        return false;
      }

      await userDocRef.update({
        'mercenaryInvitationHistory': invitationList,
      });

      return true;
    } catch (e, s) {
      return false;
    }
  }
}
