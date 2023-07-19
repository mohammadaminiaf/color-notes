// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddNoteParams {
  final String? id;
  final String? posterId;
  final DateTime? dateCreated;
  final String title;
  final String text;

  const AddNoteParams({
    required this.id,
    required this.posterId,
    required this.dateCreated,
    required this.title,
    required this.text,
  });
}
