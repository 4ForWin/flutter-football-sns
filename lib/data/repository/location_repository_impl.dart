import 'package:mercenaryhub/data/data_source/location_data_source.dart';
import 'package:mercenaryhub/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource _locationDataSource;

  LocationRepositoryImpl(this._locationDataSource);

  @override
  Future<String> getLocation() async {
    String location = await _locationDataSource.getLocation();
    return location;
  }
}
