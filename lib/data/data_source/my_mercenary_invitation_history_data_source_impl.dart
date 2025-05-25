import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercenaryhub/data/data_source/my_mercenary_invitation_history_data_source.dart';
import 'package:mercenaryhub/data/data_source/my_team_application_history_data_source.dart';
import 'package:mercenaryhub/data/dto/my_mercenary_invitation_history_dto.dart';
import 'package:mercenaryhub/data/dto/my_team_application_history_dto.dart';
import 'package:mercenaryhub/data/dto/team_feed_dto.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';

class MyMercenaryInvitationHistoryDataSourceImpl
    implements MyMercenaryInvitationHistoryDataSource {
  final FirebaseFirestore _firebaseFirestore;

  MyMercenaryInvitationHistoryDataSourceImpl(this._firebaseFirestore);

  @override
  Future<List<MyMercenaryInvitationHistoryDto>>
      fetchInvitationHistories() async {
    try {
      final userMap = (await _firebaseFirestore
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .get())
          .data();

      final invitationList = List<Map<String, dynamic>>.from(
          userMap!['mercenaryInvitationHistory']);
      print('🥰🥰🥰🥰🥰🥰🥰');
      print(invitationList);
      print('🥰🥰🥰🥰🥰🥰🥰');

      if (invitationList != null) {
        return invitationList.map((feedMap) {
          return MyMercenaryInvitationHistoryDto.fromJson(feedMap);
        }).toList();
      }

      return [];
      // return querySnapshot.docs.map((doc) {
      //   final data = doc.data();
      //   return TeamFeedDto.fromJson({
      //     'id': doc.id,
      //     ...data,
      //   });
      // }).toList();
    } catch (e, s) {
      print('❌fetchInvitationHistories error: $e');
      print('❌fetchInvitationHistories error: $s');
      return [];
    }
  }

  // @override
  // Future<bool> cancelApply(String applyHistoryId) async {
  //   try {
  //     await _firebaseFirestore
  //         .collection('mercenaryApplyHistories')
  //         .doc(applyHistoryId)
  //         .update({
  //       'status': 'cancelled',
  //       'cancelledAt': DateTime.now().toIso8601String(),
  //     });
  //     return true;
  //   } catch (e) {
  //     print('cancelApply error: $e');
  //     return false;
  //   }
  // }

  // @override
  // Future<MyTeamApplicationHistoryDto?> fetchMercenaryApplyHistoryById(
  //     String applyHistoryId) async {
  //   try {
  //     final doc = await _firebaseFirestore
  //         .collection('mercenaryApplyHistories')
  //         .doc(applyHistoryId)
  //         .get();

  //     if (doc.exists) {
  //       return MyTeamApplicationHistoryDto.fromJson({
  //         'id': doc.id,
  //         ...doc.data()!,
  //       });
  //     }
  //     return null;
  //   } catch (e) {
  //     print('fetchMercenaryApplyHistoryById error: $e');
  //     return null;
  //   }
  // }

  @override
  void inviteToMercenary(String feedId) async {
    // 인자를 Feed타입으로 받고 싶은데 그러면 의존성 때문에 안될까 싶어 feedId로 하는 중
    final feed = (await _firebaseFirestore
            .collection('mercenaryFeeds')
            .doc(feedId)
            .get())
        .data();

    final docRef = _firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    // 추가한 피드를 넣기
    // 내가 신청한 팀
    feed!['feedId'] = feedId;
    feed['appliedAt'] = DateTime.now().toIso8601String();
    feed['status'] = 'pending';

    await docRef.update({
      'mercenaryInvitationHistory': FieldValue.arrayUnion([feed])
    });
  }
}
