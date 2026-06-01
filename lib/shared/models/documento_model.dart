class DocumentoModel {
  const DocumentoModel({
    required this.id,
    required this.solicitudId,
    required this.tipoDocumento,
    required this.nombreArchivo,
    required this.estado,
    required this.fechaSubida,
    required this.pendingSync,
  });

  final String id;
  final String solicitudId;
  final String tipoDocumento;
  final String nombreArchivo;
  final String estado;
  final DateTime fechaSubida;
  final bool pendingSync;
}

