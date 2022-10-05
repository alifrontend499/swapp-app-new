class TempModal {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  TempModal({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  // factory TempModal.fromJson(Map<String, dynamic> json) {
  //  return TempModal(
  //    postId: json['postId'],
  //    id: json['id'],
  //    name: json['name'],
  //    email: json['email'],
  //    body: json['body'],
  //  );
  // }
}