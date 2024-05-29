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
    // dynamic data = await _apiService.sendPdf();
    // ClinicData clinicData = ClinicData.fromJson(data);
    // Create dummy data for Professional
    Professional dummyProfessional = Professional(
      valor: "Dr. John Doe",
      confidence: 0.95,
    );

    // Create dummy data for Date
    Date dummyDate = Date(
      valor: "2024-05-22",
      confidence: 0.90,
    );

    // Create dummy data for TotalPaid
    TotalPaid dummyTotalPaid = TotalPaid(
      valor: 1500,
      confidence: 0.85,
    );

    // Create dummy data for Patients
    List<Patient> dummyPatients = [
      Patient(
        nombre: "Alice",
        total: 500,
        opago: 200,
        confidence: 0.92,
      ),
      Patient(
        nombre: "Bob",
        total: 700,
        opago: 300,
        confidence: 0.88,
      ),
      Patient(
        nombre: "Charlie",
        total: 300,
        opago: 100,
        confidence: 0.80,
      ),
    ];

    // Create dummy data for ClinicData
    ClinicData dummyClinicData = ClinicData(
      clinica: "General Clinic",
      professional: dummyProfessional,
      date: dummyDate,
      totalPaid: dummyTotalPaid,
      patients: dummyPatients,
    );
    emitState(
      clinicData: dummyClinicData,
    );
  }

  Future obtainConsults() async {
    await _apiService.obtainConsult();
  }
}
