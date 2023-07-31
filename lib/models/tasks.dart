import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  bool? isDone;
  bool? isDelete;
  Task({
    required this.id,
    required this.title,
    this.isDone,
    this.isDelete,
  }) {
    isDone = isDone ?? false;
    isDelete = isDelete ?? false;
  }

  Task copyWith({
    String? id,
    String? title,
    bool? isDone,
    bool? isDelete,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDelete: isDelete ?? this.isDelete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isDone': isDone,
      'isDelete': isDelete,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isDone: map['isDone'] == 1 ? true : false,
      isDelete: map['isDelete'] == 1 ? true : false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        isDone,
        isDelete,
      ];
}
