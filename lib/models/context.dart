/// В каких файлах находится
/// пользователь в данный момент
enum Scope { own, trash, shared }

class CurrentDirContext {
  final String id;
  final String name;

  CurrentDirContext(this.id, this.name);
}

class Context {
  //None - root
  final CurrentDirContext? current_dir;
  final Scope current_scope;

  Context(this.current_dir, this.current_scope);
}
