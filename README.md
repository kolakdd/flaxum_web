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

Для запуска в сети:

```sh
flutter run -d web-server --web-hostname 192.168.1.11 --web-port 8080 --web-browser-flag "--disable-web-security"
```