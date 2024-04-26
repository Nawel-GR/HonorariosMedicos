class Professional {
  String valor;
  String confidence;

  Professional({required this.valor, required this.confidence});

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      valor: json['valor'],
      confidence: json['confidence'],
    );
  }
}

class Date {
  String valor;
  String confidence;

  Date({required this.valor, required this.confidence});

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      valor: json['valor'],
      confidence: json['confidence'],
    );
  }
}

class TotalPaid {
  String valor;
  String confidence;

  TotalPaid({required this.valor, required this.confidence});

  factory TotalPaid.fromJson(Map<String, dynamic> json) {
    return TotalPaid(
      valor: json['valor'],
      confidence: json['confidence'],
    );
  }
}

class Patient {
  String nombre;
  int total;
  int opago;
  String confidence;

  Patient(
      {required this.nombre,
      required this.total,
      required this.opago,
      required this.confidence});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      nombre: json['nombre'],
      total: json['total'],
      opago: json['opago'],
      confidence: json['confidence'],
    );
  }
}

class ClinicData {
  String clinica;
  Professional professional;
  Date date;
  TotalPaid totalPaid;
  List<Patient> patients;

  ClinicData(
      {required this.clinica,
      required this.professional,
      required this.date,
      required this.totalPaid,
      required this.patients});

  factory ClinicData.fromJson(Map<String, dynamic> json) {
    var professionalData = json['Datos'][0]['Profesional'];
    var dateData = json['Datos'][1]['fecha'];
    var totalPaidData = json['Datos'][2]['totalpagado'];
    var patientsData = json['Datos'][3]['pacientes'];

    return ClinicData(
      clinica: json['clinica'],
      professional: Professional.fromJson(professionalData),
      date: Date.fromJson(dateData),
      totalPaid: TotalPaid.fromJson(totalPaidData),
      patients: List<Patient>.from(
          patientsData.map((patient) => Patient.fromJson(patient))),
    );
  }
}
