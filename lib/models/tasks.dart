import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  int? isDone;
  int? isDelete;
  Task({
    required this.id,
    required this.title,
    this.isDone,
    this.isDelete,
  }) {
    isDone = isDone ?? 0;
    isDelete = isDelete ?? 0;
  }

  Task copyWith({
    String? id,
    String? title,
    int? isDone,
    int? isDelete,
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
      isDone: map['isDone'] ?? 0,
      isDelete: map['isDelete'] ?? 0,
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
