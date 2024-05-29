class Professional {
  String valor;
  double confidence;

  Professional({required this.valor, required this.confidence});

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      valor: json['value'],
      confidence: json['confidence'],
    );
  }
}

class Date {
  String valor;
  double confidence;

  Date({required this.valor, required this.confidence});

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      valor: json['value'],
      confidence: json['confidence'],
    );
  }
}

class TotalPaid {
  int valor;
  double confidence;

  TotalPaid({required this.valor, required this.confidence});

  factory TotalPaid.fromJson(Map<String, dynamic> json) {
    return TotalPaid(
      valor: json['value'],
      confidence: json['confidence'],
    );
  }
}

class Patient {
  String nombre;
  int total;
  int opago;
  double confidence;

  Patient(
      {required this.nombre,
      required this.total,
      required this.opago,
      required this.confidence});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      nombre: json['name'],
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
    var professionalData = json['data']['profesional'];
    var dateData = json['data']['date'];
    var totalPaidData = json['data']['total'];
    var patientsData = json['data']["pacients"];

    return ClinicData(
      clinica: json['clinic'],
      professional: Professional.fromJson(professionalData),
      date: Date.fromJson(dateData),
      totalPaid: TotalPaid.fromJson(totalPaidData),
      patients: List<Patient>.from(
          patientsData.map((patient) => Patient.fromJson(patient))),
    );
  }
}
