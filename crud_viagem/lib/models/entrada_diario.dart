class EntradaDiario {
  final String id;
  final String titulo;
  final DateTime data;
  final String conteudo;
  final String viagemId;

  EntradaDiario({
    required this.id,
    required this.titulo,
    required this.data,
    required this.conteudo,
    required this.viagemId,
  });

  factory EntradaDiario.fromJson(Map<String, dynamic> json) {
    return EntradaDiario(
      id: json['id'],
      titulo: json['titulo'],
      data: DateTime.parse(json['data']),
      conteudo: json['conteudo'],
      viagemId: json['viagemId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'data': data.toIso8601String(),
      'conteudo': conteudo,
      'viagemId': viagemId,
    };
  }
}
