import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/domain/entity/agreement_entity.dart';

class AgreementRemoteDataSource {
  final FirebaseFirestore firestore;

  AgreementRemoteDataSource(this.firestore);

  Future<void> saveAgreement(String uid, AgreementEntity agreement) {
    return firestore.collection('users').doc(uid).set({
      'agreements': {
        'terms': agreement.terms,
        'privacy': agreement.privacy,
        'location': agreement.location,
        'agreedAt': agreement.agreedAt.toIso8601String(),
      }
    }, SetOptions(merge: true));
  }
}
