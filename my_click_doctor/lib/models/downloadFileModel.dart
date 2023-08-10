import 'dart:convert';

class DownloadFileModel {
  DownloadFileModel({
    this.list,
    this.msg,
    this.code,
    this.path,
    this.userId,
    this.encryptedId,
  });

  List<ListElement> list;
  String msg;
  int code;
  String path = "";
  dynamic userId;
  dynamic encryptedId;

  factory DownloadFileModel.fromJson(Map<String, dynamic> json) =>
      DownloadFileModel(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        msg: json["msg"],
        code: json["code"],
        path: json["path"],
        userId: json["userId"],
        encryptedId: json["encryptedId"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "msg": msg,
        "code": code,
        "path": path,
        "userId": userId,
        "encryptedId": encryptedId,
      };
}

class ListElement {
  ListElement({
    this.path,
    this.name,
    this.filetype,
    this.docId,
  });

  String path;
  dynamic name;
  String filetype;
  int docId;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        path: json["path"],
        name: json["name"],
        filetype: json["filetype"],
        docId: json["docId"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "name": name,
        "filetype": filetype,
        "docId": docId,
      };
}
