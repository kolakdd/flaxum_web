# Flaxum Web

Запуск проекта при помощи 

```sh
flutter run --web-header=Cross-Origin-Opener-Policy=same-origin --web-header=Cross-Origin-Embedder-Policy=require-corp
```

Использование генерации от rust_flutter_bridge

```sh
flutter_rust_bridge_codegen generate --watch
flutter_rust_bridge_codegen build-web
```
