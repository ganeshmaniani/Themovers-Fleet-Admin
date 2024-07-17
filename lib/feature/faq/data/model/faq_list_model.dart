class FAQListModel {
  bool? apiSuccess;
  List<FaqList>? faqList;

  FAQListModel({this.apiSuccess, this.faqList});

  FAQListModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['fleet_admin_faq_list'] != null) {
      faqList = <FaqList>[];
      json['fleet_admin_faq_list'].forEach((v) {
        faqList!.add(FaqList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (faqList != null) {
      data['fleet_admin_faq_list'] = faqList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaqList {
  int? id;
  String? question;
  String? answer;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? deleted;

  FaqList(
      {this.id,
      this.question,
      this.answer,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.deleted});

  FaqList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['deleted'] = deleted;
    return data;
  }
}
