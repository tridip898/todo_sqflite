class TaskModel {
  int? id;
  String? title;
  String? description;
  bool? status;

  TaskModel(
      {this.id, this.title, this.description, this.status = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status! ? 1 : 0
    };

  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        status: map['status'] == 1
    );
  }
}
