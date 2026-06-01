class Approval {
  const Approval({
    required this.id,
    required this.requestId,
    required this.coordinatorId,
    required this.userId,
    required this.decision,
    required this.comment,
    required this.decidedAt,
  });

  final String id;
  final String requestId;
  final String coordinatorId;
  final String userId;
  final String decision;
  final String comment;
  final DateTime decidedAt;

  String get solicitudId => requestId;
  String get coordinadorId => coordinatorId;
  String get usuarioId => userId;
  String get decisionLabel => decision;
  String get comentario => comment;
  DateTime get fechaDecision => decidedAt;
}
