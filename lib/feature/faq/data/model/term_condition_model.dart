class TermsConditionModel {
  bool? apiSuccess;
  List<TermsCondition>? termsCondition;

  TermsConditionModel({this.apiSuccess, this.termsCondition});

  TermsConditionModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['fleet_admin_terms_condition_list'] != null) {
      termsCondition = <TermsCondition>[];
      json['fleet_admin_terms_condition_list'].forEach((v) {
        termsCondition!.add(TermsCondition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (termsCondition != null) {
      data['fleet_admin_terms_condition_list'] =
          termsCondition!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TermsCondition {
  int? id;
  String? titleName;
  String? value;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? deleted;

  TermsCondition(
      {this.id,
      this.titleName,
      this.value,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.deleted});

  TermsCondition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleName = json['title_name'];
    value = json['value'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title_name'] = titleName;
    data['value'] = value;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['deleted'] = deleted;
    return data;
  }
}
