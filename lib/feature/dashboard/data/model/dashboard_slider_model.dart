class DashboardSliderModel {
  bool? apiSuccess;
  List<SlideImages>? slideImages;
  String? path;

  DashboardSliderModel({this.apiSuccess, this.slideImages, this.path});

  DashboardSliderModel.fromJson(Map<String, dynamic> json) {
    apiSuccess = json['Api_success'];
    if (json['fleet_slide_images'] != null) {
      slideImages = <SlideImages>[];
      json['fleet_slide_images'].forEach((v) {
        slideImages!.add(SlideImages.fromJson(v));
      });
    }
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Api_success'] = apiSuccess;
    if (slideImages != null) {
      data['fleet_slide_images'] = slideImages!.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    return data;
  }
}

class SlideImages {
  int? id;
  String? name;
  String? file;
  int? createdBy;
  String? createdAt;
  String? deleted;
  String? deletedReason;
  int? updatedBy;
  String? updatedAt;

  SlideImages(
      {this.id,
      this.name,
      this.file,
      this.createdBy,
      this.createdAt,
      this.deleted,
      this.deletedReason,
      this.updatedBy,
      this.updatedAt});

  SlideImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    file = json['file'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    deleted = json['deleted'];
    deletedReason = json['deleted_reason'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['file'] = file;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['deleted'] = deleted;
    data['deleted_reason'] = deletedReason;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    return data;
  }
}
