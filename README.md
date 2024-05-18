# tracking

tracking mobile app

## Getting Started


### List of commands to run:
#### Easy localization:

```shell
dart run easy_localization:generate -f keys -O lib/app/resources -S assets/translations -o strings_manager.g.dart
```

```shell
dart run build_runner build
```

```shell
dart fix
```

```shell
dart fix --dry-run
```

```shell
dart fix --apply
```

```shell
flutter logs
```

```shell
git add .
```

```shell
git push origin master
```

```shell
dart run build_runner build --delete-conflicting-outputs
```
```shell
dart run flutter_launcher_icons
```
```shell
flutter pub global activate rename
```
```shell
rename setAppName --targets ios,android --value "Itieit Tracking"
```
```shell
rename setBundleId --targets ios,android --value "com.itieit.tracking"
```
```shell
pod deintegrate && sudo gem install cocoapods-clean && pod clean && pod setup && pod install 
```
test1@itieit.com
P@ssw0rd