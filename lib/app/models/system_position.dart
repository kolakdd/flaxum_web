import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';

// В каких какой позиции находится система в данный момент
enum Scope { own, trash, shared }

extension ScopeExtension on Scope {
  String toDisplayString() {
    switch (this) {
      case Scope.own:
        return "Мои файлы";
      case Scope.trash:
        return "Корзина";
      case Scope.shared:
        return "Доступные мне";
      default:
        return "Default";
    }
  }
}

class CurrentDirContext {
  final String id;
  final String name;

  CurrentDirContext(this.id, this.name);
}

class MainPosition {
  //None - root
  Scope? currentScope;
  FlaxumObject? uxoPointer;
  List<String> nameStack;
  List<String> idStack;

  MainPosition(this.currentScope, this.uxoPointer, nameStack, idStack)
      : nameStack = [],
        idStack = [];
}
