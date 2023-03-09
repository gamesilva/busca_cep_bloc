import 'package:busca_cep_bloc/models/cep_model.dart';

class CepState {
  final CepModel cep;
  final CepStatus status;

  const CepState._({
    this.cep,
    this.status = CepStatus.loading,
  });

  const CepState.loading() : this._();
  const CepState.error() : this._(status: CepStatus.error);
  const CepState.success(CepModel cep)
      : this._(status: CepStatus.success, cep: cep);
}

enum CepStatus { loading, success, error }
