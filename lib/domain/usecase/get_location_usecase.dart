import 'package:mercenaryhub/domain/repository/location_repository.dart';

class GetLocationUsecase {
  LocationRepository _locationRepository;

  GetLocationUsecase(this._locationRepository);

  Future<String> execute() async {
    return await _locationRepository.getLocation();
  }
}
