import 'package:mercenaryhub/data/data_source/agreement_remote_datasource.dart';
import 'package:mercenaryhub/domain/entity/agreement_entity.dart';
import 'package:mercenaryhub/domain/repositories/agreement_repository.dart';

class AgreementRepositoryImpl implements AgreementRepository {
  final AgreementRemoteDataSource remoteDataSource;

  AgreementRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> saveAgreement(String uid, AgreementEntity agreement) {
    return remoteDataSource.saveAgreement(uid, agreement);
  }
}
