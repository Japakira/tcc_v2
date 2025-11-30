class Usuario {
  final String id;
  final String usuarioNome;
  final String usuarioEmail;
  final bool admin;
  final List<String> iniciativasIds;
  final String imagemUrl; // novo campo

  Usuario({
    required this.id,
    required this.usuarioNome,
    required this.usuarioEmail,
    required this.admin,
    required this.iniciativasIds,
    required this.imagemUrl,
  });

  factory Usuario.fromMap(Map<String, dynamic> data, String documentId) {
    return Usuario(
      id: documentId,
      usuarioNome: data['usuarioNome'] ?? '',
      usuarioEmail: data['usuarioEmail'] ?? '',
      admin: data['admin'] ?? false,
      iniciativasIds: List<String>.from(data['iniciativasIds'] ?? []),
      imagemUrl: data['imagemUrl'] ?? '', // novo
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'usuarioNome': usuarioNome,
      'usuarioEmail': usuarioEmail,
      'admin': admin,
      'iniciativasIds': iniciativasIds,
      'imagemUrl': imagemUrl, // novo
    };
  }
}
