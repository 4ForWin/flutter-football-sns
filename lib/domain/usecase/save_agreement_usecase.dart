import 'package:mercenaryhub/domain/entity/agreement_entity.dart';
import 'package:mercenaryhub/domain/repositories/agreement_repository.dart';

class SaveAgreementUseCase {
  final AgreementRepository repository;

  SaveAgreementUseCase(this.repository);

  Future<void> call(String uid, AgreementEntity agreement) {
    return repository.saveAgreement(uid, agreement);
  }
}
