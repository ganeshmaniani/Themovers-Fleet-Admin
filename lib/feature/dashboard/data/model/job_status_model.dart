class JobStatusModel {
  JobCount? jobCount;
  List<JobStatus>? jobStatus;
  bool? apiSuccess;
  String? apiMessage;

  JobStatusModel(
      {this.jobCount, this.jobStatus, this.apiSuccess, this.apiMessage});

  JobStatusModel.fromJson(Map<String, dynamic> json) {
    jobCount = json['count'] != null ? JobCount.fromJson(json['count']) : null;
    if (json['booking_status'] != null) {
      jobStatus = <JobStatus>[];
      json['booking_status'].forEach((v) {
        jobStatus!.add(JobStatus.fromJson(v));
      });
    }
    apiSuccess = json['Api_success'];
    apiMessage = json['Api_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobCount != null) {
      data['count'] = jobCount!.toJson();
    }
    if (jobStatus != null) {
      data['booking_status'] = jobStatus!.map((v) => v.toJson()).toList();
    }
    data['Api_success'] = apiSuccess;
    data['Api_message'] = apiMessage;
    return data;
  }
}

class JobCount {
  int? available;
  int? accepted;
  int? inProgress;
  int? completed;
  int? total;

  JobCount(
      {this.available,
      this.accepted,
      this.inProgress,
      this.completed,
      this.total});

  JobCount.fromJson(Map<String, dynamic> json) {
    available = json['Available'];
    accepted = json['Accepted'];
    inProgress = json['InProgress'];
    completed = json['Completed'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Available'] = available;
    data['Accepted'] = accepted;
    data['InProgress'] = inProgress;
    data['Completed'] = completed;
    data['Total'] = total;
    return data;
  }
}

class JobStatus {
  int? jobStatusId;
  String? jobStatusName;

  JobStatus({this.jobStatusId, this.jobStatusName});

  JobStatus.fromJson(Map<String, dynamic> json) {
    jobStatusId = json['booking_status_id'];
    jobStatusName = json['booking_status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_status_id'] = jobStatusId;
    data['booking_status_name'] = jobStatusName;
    return data;
  }
}
