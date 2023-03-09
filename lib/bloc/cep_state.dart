import 'package:busca_cep_bloc/models/cep_model.dart';

class CepState {
  final CepModel cep;
  final CepStatus status;

  const CepState._({
    this.cep,
    this.status = CepStatus.none,
  });

  const CepState.none() : this._();
  const CepState.loading() : this._(status: CepStatus.loading);
  const CepState.error() : this._(status: CepStatus.error);
  const CepState.success(CepModel cep)
      : this._(status: CepStatus.success, cep: cep);
}

enum CepStatus { loading, success, error, none }
