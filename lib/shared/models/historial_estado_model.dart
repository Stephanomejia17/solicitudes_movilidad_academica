class HistorialEstadoModel {
  const HistorialEstadoModel({
    required this.id,
    required this.solicitudId,
    required this.usuarioId,
    required this.estadoAnterior,
    required this.estadoNuevo,
    required this.fechaCambio,
    required this.pendingSync,
    this.comentario,
  });

  final String id;
  final String solicitudId;
  final String usuarioId;
  final String estadoAnterior;
  final String estadoNuevo;
  final String? comentario;
  final DateTime fechaCambio;
  final bool pendingSync;
}

