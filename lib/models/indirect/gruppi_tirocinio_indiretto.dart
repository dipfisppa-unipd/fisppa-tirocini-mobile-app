import 'package:equatable/equatable.dart';

class GruppoTirocinioIndiretto extends Equatable{
  final String name;
  final int id;

  const GruppoTirocinioIndiretto(this.name, this.id);

  @override
  List<Object?> get props => [name, id];

}