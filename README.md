# Flaxum Web

Запуск проекта для дебага

```sh
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

Для генерации json_annotation 

```bash
flutter pub run build_runner build
```

Для запуска в сети:

```sh
flutter run -d web-server --web-hostname 192.168.1.11 --web-port 8080 --web-browser-flag "--disable-web-security"
```

Изменить /assets/.env:

Адрес бекенда
```sh
BACKEND_ENDPOINT='http://0.0.0.0:3000'
```