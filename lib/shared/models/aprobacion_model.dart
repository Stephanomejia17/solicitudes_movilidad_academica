class AprobacionModel {
  const AprobacionModel({
    required this.id,
    required this.solicitudId,
    required this.coordinadorId,
    required this.usuarioId,
    required this.decision,
    required this.comentario,
    required this.fechaDecision,
    required this.pendingSync,
  });

  final String id;
  final String solicitudId;
  final String coordinadorId;
  final String usuarioId;
  final String decision;
  final String comentario;
  final DateTime fechaDecision;
  final bool pendingSync;
}

