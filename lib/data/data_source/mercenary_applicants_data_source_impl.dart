import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/data/data_source/mercenary_applicants_data_source.dart';
import 'package:mercenaryhub/data/dto/mercenary_applicant_dto.dart';

class MercenaryApplicantsDataSourceImpl
    implements MercenaryApplicantsDataSource {
  final FirebaseFirestore _firebaseFirestore;

  MercenaryApplicantsDataSourceImpl(this._firebaseFirestore);

  @override
  Future<List<MercenaryApplicantDto>> fetchMercenaryApplicants(
      String teamUid) async {
    try {
      print('🥰 DataSource:  $teamUid의 용병 지원자 조회 시작');

      // teamApplications 컬렉션에서 해당 팀에 지원한 내역들 조회
      final querySnapshot = await _firebaseFirestore
          .collection('teamApplications')
          .where('teamUid', isEqualTo: teamUid)
          .orderBy('appliedAt', descending: true)
          .get();

      print('🥰 DataSource: ${querySnapshot.docs.length}개의 지원 내역 발견');

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        final applicationData = {
          'applicationId': doc.id,
          ...data,
        };

        print(
            '🥰 DataSource: 지원자 데이터 - ${data['mercenaryName']} (${data['status']})');
        return MercenaryApplicantDto.fromJson(applicationData);
      }).toList();
    } catch (e, s) {
      print('❌ fetchMercenaryApplicants error: $e');
      print('❌ fetchMercenaryApplicants stack: $s');
      return [];
    }
  }

  @override
  Future<bool> respondToMercenaryApplication({
    required String applicationId,
    required String response,
  }) async {
    try {
      print('🥰 DataSource: 용병 지원 응답 시작 - $applicationId -> $response');

      await _firebaseFirestore
          .collection('teamApplications')
          .doc(applicationId)
          .update({
        'status': response,
        'respondedAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      print('✅ DataSource: 용병 지원 응답 완료');
      return true;
    } catch (e, s) {
      print('❌ respondToMercenaryApplication error: $e');
      print('❌ respondToMercenaryApplication stack: $s');
      return false;
    }
  }

  @override
  Future<MercenaryApplicantDto?> fetchMercenaryApplicantById(
      String applicationId) async {
    try {
      print('🥰 DataSource: 지원 내역 상세 조회 - $applicationId');

      final doc = await _firebaseFirestore
          .collection('teamApplications')
          .doc(applicationId)
          .get();

      if (!doc.exists) {
        print('⚠️ DataSource: 지원 내역을 찾을 수 없음 - $applicationId');
        return null;
      }

      final data = doc.data()!;
      final applicationData = {
        'applicationId': doc.id,
        ...data,
      };

      print('✅ DataSource: 지원 내역 상세 조회 완료');
      return MercenaryApplicantDto.fromJson(applicationData);
    } catch (e, s) {
      print('❌ fetchMercenaryApplicantById error: $e');
      print('❌ fetchMercenaryApplicantById stack: $s');
      return null;
    }
  }

  @override
  Future<bool> updateApplicationStatus({
    required String applicationId,
    required String newStatus,
  }) async {
    try {
      print('🥰 DataSource: 지원 상태 업데이트 - $applicationId -> $newStatus');

      await _firebaseFirestore
          .collection('teamApplications')
          .doc(applicationId)
          .update({
        'status': newStatus,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      print('✅ DataSource: 지원 상태 업데이트 완료');
      return true;
    } catch (e, s) {
      print('❌ updateApplicationStatus error: $e');
      print('❌ updateApplicationStatus stack: $s');
      return false;
    }
  }

  @override
  Future<List<String>> fetchMyTeamFeedIds() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return [];
      }

      print('🥰 DataSource: 사용자 ${currentUser.uid}의 팀 피드 ID 조회');

      final querySnapshot = await _firebaseFirestore
          .collection('teamFeeds')
          .where('uid', isEqualTo: currentUser.uid)
          .get();

      final feedIds = querySnapshot.docs.map((doc) => doc.id).toList();
      print('✅ DataSource: ${feedIds.length}개의 팀 피드 ID 조회 완료');

      return feedIds;
    } catch (e, s) {
      print('❌ fetchMyTeamFeedIds error: $e');
      print('❌ fetchMyTeamFeedIds stack: $s');
      return [];
    }
  }

  @override
  Future<int> getApplicantCount(String teamFeedId) async {
    try {
      print('🥰 DataSource: 팀 피드 $teamFeedId의 지원자 수 조회');

      final querySnapshot = await _firebaseFirestore
          .collection('teamApplications')
          .where('teamFeedId', isEqualTo: teamFeedId)
          .get();

      final count = querySnapshot.docs.length;
      print('✅ DataSource: 지원자 수 - $count명');

      return count;
    } catch (e, s) {
      print('❌ getApplicantCount error: $e');
      print('❌ getApplicantCount stack: $s');
      return 0;
    }
  }

  @override
  Future<int> getPendingApplicationCount() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('❌ 로그인된 사용자가 없습니다.');
        return 0;
      }

      print('🥰 DataSource: 사용자 ${currentUser.uid}의 대기중인 지원 수 조회');

      final querySnapshot = await _firebaseFirestore
          .collection('teamApplications')
          .where('teamUid', isEqualTo: currentUser.uid)
          .where('status', isEqualTo: 'pending')
          .get();

      final count = querySnapshot.docs.length;
      print('✅ DataSource: 대기중인 지원 수 - $count개');

      return count;
    } catch (e, s) {
      print('❌ getPendingApplicationCount error: $e');
      print('❌ getPendingApplicationCount stack: $s');
      return 0;
    }
  }

  @override
  Future<bool> createMercenaryApplication(
      Map<String, dynamic> applicationData) async {
    try {
      print('🥰 DataSource: 용병 지원 내역 생성 시작');

      final docRef = _firebaseFirestore.collection('teamApplications').doc();

      final data = {
        ...applicationData,
        'appliedAt': DateTime.now().toIso8601String(),
        'createdAt': DateTime.now().toIso8601String(),
        'status': 'pending',
      };

      await docRef.set(data);

      print('✅ DataSource: 용병 지원 내역 생성 완료 - ${docRef.id}');
      return true;
    } catch (e, s) {
      print('❌ createMercenaryApplication error: $e');
      print('❌ createMercenaryApplication stack: $s');
      return false;
    }
  }

  @override
  Future<bool> deleteMercenaryApplication(String applicationId) async {
    try {
      print('🥰 DataSource: 용병 지원 내역 삭제 - $applicationId');

      await _firebaseFirestore
          .collection('teamApplications')
          .doc(applicationId)
          .delete();

      print('✅ DataSource: 용병 지원 내역 삭제 완료');
      return true;
    } catch (e, s) {
      print('❌ deleteMercenaryApplication error: $e');
      print('❌ deleteMercenaryApplication stack: $s');
      return false;
    }
  }

  @override
  Future<MercenaryApplicantDto?> fetchApplicationByMercenaryAndTeam({
    required String mercenaryUid,
    required String teamFeedId,
  }) async {
    try {
      print('🥰 DataSource: 용병-팀 지원 내역 조회 - $mercenaryUid -> $teamFeedId');

      final querySnapshot = await _firebaseFirestore
          .collection('teamApplications')
          .where('mercenaryUid', isEqualTo: mercenaryUid)
          .where('teamFeedId', isEqualTo: teamFeedId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('⚠️ DataSource: 지원 내역이 없음');
        return null;
      }

      final doc = querySnapshot.docs.first;
      final data = doc.data();
      final applicationData = {
        'applicationId': doc.id,
        ...data,
      };

      print('✅ DataSource: 용병-팀 지원 내역 조회 완료');
      return MercenaryApplicantDto.fromJson(applicationData);
    } catch (e, s) {
      print('❌ fetchApplicationByMercenaryAndTeam error: $e');
      print('❌ fetchApplicationByMercenaryAndTeam stack: $s');
      return null;
    }
  }

  @override
  Future<Map<String, int>> getApplicationStatistics(String teamUid) async {
    try {
      print('🥰 DataSource: $teamUid의 지원 통계 조회');

      final querySnapshot = await _firebaseFirestore
          .collection('teamApplications')
          .where('teamUid', isEqualTo: teamUid)
          .get();

      final statistics = <String, int>{
        'total': 0,
        'pending': 0,
        'accepted': 0,
        'rejected': 0,
        'cancelled': 0,
      };

      for (final doc in querySnapshot.docs) {
        final status = doc.data()['status'] as String? ?? 'pending';
        statistics['total'] = (statistics['total'] ?? 0) + 1;
        statistics[status] = (statistics[status] ?? 0) + 1;
      }

      print('✅ DataSource: 지원 통계 조회 완료 - ${statistics['total']}건');
      return statistics;
    } catch (e, s) {
      print('❌ getApplicationStatistics error: $e');
      print('❌ getApplicationStatistics stack: $s');
      return {
        'total': 0,
        'pending': 0,
        'accepted': 0,
        'rejected': 0,
        'cancelled': 0
      };
    }
  }
}
