// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoList {
  String id;
  String content;
  bool isDone;
  
  TodoList({
    required this.id,
    required this.content,
    this.isDone = false,
  });

  factory TodoList.fromjson(Map<String, dynamic> json) {
    return TodoList(
        id: json['id'], content: json['content'], isDone: json['isDone']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'content':content,
      'isDone':isDone
    };
  }
}
