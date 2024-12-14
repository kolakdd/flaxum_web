# Flaxum Web

Запуск проекта при помощи 

Без rust bridge

```sh
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

С rust bridge

```sh
flutter run --web-header=Cross-Origin-Opener-Policy=same-origin --web-header=Cross-Origin-Embedder-Policy=require-corp
```
Для генерации json_annotation 

```bash
flutter pub run build_runner build
```

Использование генерации от rust_flutter_bridge

```sh
flutter_rust_bridge_codegen generate --watch
flutter_rust_bridge_codegen build-web
```


