import 'package:flaxum_fileshare/models/object_/object_.dart';

// В каких файлах находится
// пользователь в данный момент
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
  Object_? uxoPointer;
  List<String> nameStack;
  List<String> idStack;

  MainPosition(this.currentScope, this.uxoPointer, nameStack, idStack)
      : nameStack = [],
        idStack = [];
}
