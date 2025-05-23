import 'package:mercenaryhub/domain/entity/agreement_entity.dart';

abstract class AgreementRepository {
  Future<void> saveAgreement(String uid, AgreementEntity agreement);
}
