import 'package:flaxum_fileshare/models/object_.dart';

/// В каких файлах находится
/// пользователь в данный момент
enum Scope { own, trash, shared }

extension ScopeExtension on Scope {
  String toDisplayString() {
    switch (this) {
      case Scope.own:
        return "Мои файлы";
      case Scope.trash:
        return "Корзина";
      case Scope.shared:
        return "Общие файлы";
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

class Context {
  //None - root
  CurrentDirContext? current_dir;
  Scope? current_scope;
  Object_? uxo_pointer;

  Context(this.current_dir, this.current_scope, this.uxo_pointer);
}
