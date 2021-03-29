enum DomainError {
  unexpected,
  invalidCredentials,
}

extension DomainErrorExtension on DomainError {
  Map<DomainError, String> get domainErrors {
    return {
      DomainError.invalidCredentials: 'Credenciais inválidas.',
      DomainError.unexpected: 'Algo errado aconteceu. Tente novamente em breve.'
    };
  }

  String get description {
    return domainErrors[this] ?? '';
  }
}
