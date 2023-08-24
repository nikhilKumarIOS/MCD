class DoctorProfile {
  DoctorProfile({
    this.docProfile,
    this.msg,
    this.code,
    this.userId,
    this.encryptedId,
  });

  final DocProfile docProfile;
  final String msg;
  final int code;
  final dynamic userId;
  final dynamic encryptedId;

  factory DoctorProfile.fromJson(Map<String, dynamic> json) => DoctorProfile(
        docProfile: DocProfile.fromJson(json['docProfile']),
        msg: json['msg'],
        code: json['code'],
        userId: json['userId'],
        encryptedId: json['encryptedId'],
      );

  Map<String, dynamic> toJson() => {
        'docProfile': docProfile.toJson(),
        'msg': msg,
        'code': code,
        'userId': userId,
        'encryptedId': encryptedId,
      };
}

class DocProfile {
  DocProfile({
    this.id,
    this.firstName,
    this.secondName,
    this.contractStartDate,
    this.contarctEndDate,
    this.yearsOfExperience,
    this.medicalRegistrationNo,
    this.photoUrl,
    this.city,
    this.country,
    this.streetNumber,
    this.zipcode,
    this.shortIntroduction,
    this.gander,
    this.dob,
    this.docSpeciality,
    this.doctorType,
    this.diseaseArea,
  });

  final int id;
  final String firstName;
  final String secondName;
  final DateTime contractStartDate;
  final dynamic contarctEndDate;
  final int yearsOfExperience;
  final String medicalRegistrationNo;
  final dynamic photoUrl;
  final String city;
  final String country;
  final String streetNumber;
  final String zipcode;
  final String shortIntroduction;
  final String gander;
  final DateTime dob;
  final List<DocSpeciality> docSpeciality;
  final int doctorType;
  final String diseaseArea;

  factory DocProfile.fromJson(Map<String, dynamic> json) => DocProfile(
        id: json['id'],
        firstName: json['firstName'],
        secondName: json['secondName'],
        contractStartDate: DateTime.parse(json['contractStartDate']),
        contarctEndDate: json['contarctEndDate'],
        yearsOfExperience: json['yearsOfExperiecne'],
        medicalRegistrationNo: json['medicalRegistrationNo'],
        photoUrl: json['photoUrl'],
        city: json['city'],
        country: json['country'],
        streetNumber: json['streetNumber'],
        zipcode: json['zipcode'],
        shortIntroduction: json['shortIntroduction'],
        gander: json['gander'],
        dob: DateTime.parse(json['dob']),
        docSpeciality: List<DocSpeciality>.from(
            json['docSpeciality'].map((x) => DocSpeciality.fromJson(x))),
        doctorType: json['doctorType'],
        diseaseArea: json['diseaseArea'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'secondName': secondName,
        'contractStartDate': contractStartDate.toIso8601String(),
        'contarctEndDate': contarctEndDate,
        'yearsOfExperiecne': yearsOfExperience,
        'medicalRegistrationNo': medicalRegistrationNo,
        'photoUrl': photoUrl,
        'city': city,
        'country': country,
        'streetNumber': streetNumber,
        'zipcode': zipcode,
        'shortIntroduction': shortIntroduction,
        'gander': gander,
        'dob': dob.toIso8601String(),
        'docSpeciality':
            List<dynamic>.from(docSpeciality.map((x) => x.toJson())),
        'doctorType': doctorType,
        'diseaseArea': diseaseArea,
      };
}

class DocSpeciality {
  DocSpeciality({
    this.id,
    this.name,
    this.catId,
    this.firstName,
  });

  final int id;
  final dynamic name;
  final int catId;
  final String firstName;

  factory DocSpeciality.fromJson(Map<String, dynamic> json) => DocSpeciality(
        id: json['id'],
        name: json['name'],
        catId: json['catId'],
        firstName: json['firstName'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'catId': catId,
        'firstName': firstName,
      };
}
