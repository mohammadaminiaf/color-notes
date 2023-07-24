class AddNoteParams {
  final String? id;
  final String? posterId;
  final DateTime? dateCreated;
  final String title;
  final String text;
  final int colorIndex;

  const AddNoteParams({
    required this.id,
    required this.posterId,
    required this.dateCreated,
    required this.title,
    required this.text,
    required this.colorIndex,
  });
}
