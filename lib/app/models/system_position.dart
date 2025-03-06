import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';

// В каких какой позиции находится система в данный момент
enum Scope { own, trash, shared, users }

extension ScopeExtension on Scope {
  String toDisplayString() {
    switch (this) {
      case Scope.own:
        return "Мои файлы";
      case Scope.trash:
        return "Корзина";
      case Scope.shared:
        return "Доступные мне";
      case Scope.users:
        return "Пользователи системы";
      default:
        return "Default";
    }
  }

  String toEndpoint() {
    switch (this) {
      case Scope.own:
        return "/object/own/list";
      case Scope.trash:
        return "/object/trash/list";
      case Scope.shared:
        return "/object/shared/list";
      case Scope.users:
        return "err";
      default:
        return "err";
    }
  }
}

class CurrentDirContext {
  final String id;
  final String name;

  CurrentDirContext(this.id, this.name);
}

class MainPosition {
  Scope? currentScope;
  FlaxumObject? uxoPointer;
  List<String> nameStack;
  List<String> idStack;

  MainPosition(this.currentScope, this.uxoPointer, nameStack, idStack)
      : nameStack = [],
        idStack = [];
}
