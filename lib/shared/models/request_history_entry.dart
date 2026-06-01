import 'request_status.dart';

class RequestHistoryEntry {
  const RequestHistoryEntry({
    required this.requestId,
    required this.actorId,
    required this.from,
    required this.to,
    required this.comment,
    required this.createdAt,
  });

  final String requestId;
  final String actorId;
  final RequestStatus? from;
  final RequestStatus to;
  final String comment;
  final DateTime createdAt;
}
