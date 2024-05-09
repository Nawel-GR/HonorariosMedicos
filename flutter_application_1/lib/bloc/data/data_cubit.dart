import 'package:flutter_app/api/api_service.dart';
import 'package:flutter_app/models/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  final ApiService _apiService = ApiService();

  DataCubit() : super(DataState());

  emitState({
    ClinicData? clinicData,
  }) {
    emit(DataState(
      clinicData: clinicData ?? state.clinicData,
    ));
  }

  Future resetState() async {
    emitState(
      clinicData: null,
    );
  }

  Future getData() async {
    //TODO: Implementar la llamada al servicio
  }

  Future postData() async {
    dynamic data = await _apiService.sendPdf();
    ClinicData clinicData = ClinicData.fromJson(data);
    emitState(
      clinicData: clinicData,
    );
  }

  Future obtainConsults() async {
    await _apiService.obtainConsult();
  }
}
