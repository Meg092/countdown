class MatchHistoryEntity {
  final int? id;
  final String timestamp;
  final int duration;
  final String player1Name;
  final int player1Score;
  final String player2Name;
  final int player2Score;

  const MatchHistoryEntity({
    this.id,
    required this.timestamp,
    required this.duration,
    required this.player1Name,
    required this.player1Score,
    required this.player2Name,
    required this.player2Score,
  });

  factory MatchHistoryEntity.fromMap(Map<String, dynamic> map) {
    return MatchHistoryEntity(
      id: map['id'] as int?,
      timestamp: map['timestamp'] as String,
      duration: map['duration'] as int,
      player1Name: map['player1_name'] as String,
      player1Score: map['player1_score'] as int,
      player2Name: map['player2_name'] as String,
      player2Score: map['player2_score'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'timestamp': timestamp,
      'duration': duration,
      'player1_name': player1Name,
      'player1_score': player1Score,
      'player2_name': player2Name,
      'player2_score': player2Score,
    };
  }

  bool get isPlayer1Winner => player1Score > player2Score;

  bool get isPlayer2Winner => player2Score > player1Score;

  bool get isDraw => player1Score == player2Score;

  String? get winnerName {
    if (isPlayer1Winner) return player1Name;
    if (isPlayer2Winner) return player2Name;
    return null;
  }
}

