class Viagem {
  final String id;
  final String nome;
  final DateTime dataInicio;
  final DateTime dataFim;
  final String destino;
  final String descricao;

  Viagem({
    required this.id,
    required this.nome,
    required this.dataInicio,
    required this.dataFim,
    required this.destino,
    required this.descricao,
  });

  factory Viagem.fromJson(Map<String, dynamic> json) {
    return Viagem(
      id: json['id'],
      nome: json['nome'],
      dataInicio: DateTime.parse(json['dataInicio']),
      dataFim: DateTime.parse(json['dataFim']),
      destino: json['destino'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'dataInicio': dataInicio.toIso8601String(),
      'dataFim': dataFim.toIso8601String(),
      'destino': destino,
      'descricao': descricao,
    };
  }
}