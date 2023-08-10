class getAppointmentDetails {
  var data;
  var msg;
  var code;
  var path;
  var userId;
  var encryptedId;

  getAppointmentDetails(
      {this.data,
      this.msg,
      this.code,
      this.path,
      this.userId,
      this.encryptedId});

  getAppointmentDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
    code = json['code'];
    path = json['path'];
    userId = json['userId'];
    encryptedId = json['encryptedId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    data['code'] = this.code;
    data['path'] = this.path;
    data['userId'] = this.userId;
    data['encryptedId'] = this.encryptedId;
    return data;
  }
}

class Data {
  var id;
  var startDate;
  var endDate;
  var bookingDate;
  var appointmentTitle;
  var doctorId;
  var pharmaRepId;
  var timeZone;
  var duration;
  var pharmaCompanyId;
  var doctorName;
  var repName;
  var appointmentId;
  var attachment;
  var docImage;
  var docuId;
  var date;
  var data;
  var expert;
  var docFreeSlot;
  var slotId;
  var appointmenttype;
  var status;
  var userId;
  var type;
  var pharmaRepImage;
  var meetingJoinStatus;
  var cancelStatus;
  var patientId;
  var amount;
  var currency;
  var appoinmentId;
  var transactionId;
  var remark;
  var docClinic;
  var patImage;
  var patName;
  var nurseId;
  var nurseImage;
  var nurseName;
  var role;
  var appointmentUserId;
  var appointmentUserName;
  var appointmentUserImage;
  var appointmentSUserId;
  var appointmentSUserName;
  var appointmentSUserImage;
  var doctorConsultationId;
  var description;
  var daysWeek;
  var userRole;
  var myRole;
  var doctorsId;
  var nurseSuggestion;
  var ispopup;
  var refundStatus;
  var meetingId;
  var paymentStatus;
  var uploadStatus;
  var colorcode;
  var appId;
  var consultationType;

  Data(
      {this.id,
      this.startDate,
      this.endDate,
      this.bookingDate,
      this.appointmentTitle,
      this.doctorId,
      this.pharmaRepId,
      this.timeZone,
      this.duration,
      this.pharmaCompanyId,
      this.doctorName,
      this.repName,
      this.appointmentId,
      this.attachment,
      this.docImage,
      this.docuId,
      this.date,
      this.data,
      this.expert,
      this.docFreeSlot,
      this.slotId,
      this.appointmenttype,
      this.status,
      this.userId,
      this.type,
      this.pharmaRepImage,
      this.meetingJoinStatus,
      this.cancelStatus,
      this.patientId,
      this.amount,
      this.currency,
      this.appoinmentId,
      this.transactionId,
      this.remark,
      this.docClinic,
      this.patImage,
      this.patName,
      this.nurseId,
      this.nurseImage,
      this.nurseName,
      this.role,
      this.appointmentUserId,
      this.appointmentUserName,
      this.appointmentUserImage,
      this.appointmentSUserId,
      this.appointmentSUserName,
      this.appointmentSUserImage,
      this.doctorConsultationId,
      this.description,
      this.daysWeek,
      this.userRole,
      this.myRole,
      this.doctorsId,
      this.nurseSuggestion,
      this.ispopup,
      this.refundStatus,
      this.meetingId,
      this.paymentStatus,
      this.uploadStatus,
      this.colorcode,
      this.appId,
      this.consultationType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    bookingDate = json['bookingDate'];
    appointmentTitle = json['appointmentTitle'];
    doctorId = json['doctorId'];
    pharmaRepId = json['pharmaRepId'];
    timeZone = json['timeZone'];
    duration = json['duration'];
    pharmaCompanyId = json['pharmaCompanyId'];
    doctorName = json['doctorName'];
    repName = json['repName'];
    appointmentId = json['appointmentId'];
    attachment = json['attachment'];
    docImage = json['docImage'];
    docuId = json['docuId'];
    date = json['date'];
    data = json['data'];
    expert = json['expert'];
    docFreeSlot = json['docFreeSlot'];
    slotId = json['slotId'];
    appointmenttype = json['appointmenttype'];
    status = json['status'];
    userId = json['userId'];
    type = json['type'];
    pharmaRepImage = json['pharmaRepImage'];
    meetingJoinStatus = json['meetingJoinStatus'];
    cancelStatus = json['cancelStatus'];
    patientId = json['patientId'];
    amount = json['amount'];
    currency = json['currency'];
    appoinmentId = json['appoinmentId'];
    transactionId = json['transactionId'];
    remark = json['remark'];
    docClinic = json['docClinic'];
    patImage = json['patImage'];
    patName = json['patName'];
    nurseId = json['nurseId'];
    nurseImage = json['nurseImage'];
    nurseName = json['nurseName'];
    role = json['role'];
    appointmentUserId = json['appointmentUserId'];
    appointmentUserName = json['appointmentUserName'];
    appointmentUserImage = json['appointmentUserImage'];
    appointmentSUserId = json['appointmentSUserId'];
    appointmentSUserName = json['appointmentSUserName'];
    appointmentSUserImage = json['appointmentSUserImage'];
    doctorConsultationId = json['doctorConsultationId'];
    description = json['description'];
    daysWeek = json['daysWeek'];
    userRole = json['userRole'];
    myRole = json['myRole'];
    doctorsId = json['doctorsId'];
    nurseSuggestion = json['nurseSuggestion'];
    ispopup = json['ispopup'];
    refundStatus = json['refundStatus'];
    meetingId = json['meetingId'];
    paymentStatus = json['paymentStatus'];
    uploadStatus = json['uploadStatus'];
    colorcode = json['colorcode'];
    appId = json['appId'];
    consultationType = json['consultationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['bookingDate'] = this.bookingDate;
    data['appointmentTitle'] = this.appointmentTitle;
    data['doctorId'] = this.doctorId;
    data['pharmaRepId'] = this.pharmaRepId;
    data['timeZone'] = this.timeZone;
    data['duration'] = this.duration;
    data['pharmaCompanyId'] = this.pharmaCompanyId;
    data['doctorName'] = this.doctorName;
    data['repName'] = this.repName;
    data['appointmentId'] = this.appointmentId;
    data['attachment'] = this.attachment;
    data['docImage'] = this.docImage;
    data['docuId'] = this.docuId;
    data['date'] = this.date;
    data['data'] = this.data;
    data['expert'] = this.expert;
    data['docFreeSlot'] = this.docFreeSlot;
    data['slotId'] = this.slotId;
    data['appointmenttype'] = this.appointmenttype;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['pharmaRepImage'] = this.pharmaRepImage;
    data['meetingJoinStatus'] = this.meetingJoinStatus;
    data['cancelStatus'] = this.cancelStatus;
    data['patientId'] = this.patientId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['appoinmentId'] = this.appoinmentId;
    data['transactionId'] = this.transactionId;
    data['remark'] = this.remark;
    data['docClinic'] = this.docClinic;
    data['patImage'] = this.patImage;
    data['patName'] = this.patName;
    data['nurseId'] = this.nurseId;
    data['nurseImage'] = this.nurseImage;
    data['nurseName'] = this.nurseName;
    data['role'] = this.role;
    data['appointmentUserId'] = this.appointmentUserId;
    data['appointmentUserName'] = this.appointmentUserName;
    data['appointmentUserImage'] = this.appointmentUserImage;
    data['appointmentSUserId'] = this.appointmentSUserId;
    data['appointmentSUserName'] = this.appointmentSUserName;
    data['appointmentSUserImage'] = this.appointmentSUserImage;
    data['doctorConsultationId'] = this.doctorConsultationId;
    data['description'] = this.description;
    data['daysWeek'] = this.daysWeek;
    data['userRole'] = this.userRole;
    data['myRole'] = this.myRole;
    data['doctorsId'] = this.doctorsId;
    data['nurseSuggestion'] = this.nurseSuggestion;
    data['ispopup'] = this.ispopup;
    data['refundStatus'] = this.refundStatus;
    data['meetingId'] = this.meetingId;
    data['paymentStatus'] = this.paymentStatus;
    data['uploadStatus'] = this.uploadStatus;
    data['colorcode'] = this.colorcode;
    data['appId'] = this.appId;
    data['consultationType'] = this.consultationType;
    return data;
  }
}
