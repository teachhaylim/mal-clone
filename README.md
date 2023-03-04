# mal_clone

## Essentials code generation commands

### Retrofit, Json Serialization

- flutter pub run build_runner build --delete-conflicting-outputs

### Code Analytics

#### Analyze

- dart run dart_code_metrics:metrics analyze lib
- flutter pub run dart_code_metrics:metrics analyze lib

#### Check unnecessary nullable parameters

- dart run dart_code_metrics:metrics check-unnecessary-nullable lib
- flutter pub run dart_code_metrics:metrics check-unnecessary-nullable lib

#### Check unused files

- dart run dart_code_metrics:metrics check-unused-files lib
- flutter pub run dart_code_metrics:metrics check-unused-files lib

#### Check unused localization

- dart run dart_code_metrics:metrics check-unused-l10n lib
- flutter pub run dart_code_metrics:metrics check-unused-l10n lib

#### Check unused code

- dart run dart_code_metrics:metrics check-unused-code lib
- flutter pub run dart_code_metrics:metrics check-unused-code lib