# Carros
![Coverage](./coverage_badge.svg?sanitize=true)

Flutter - App Exemplo com Clean Architecture

Possui apenas 3 telas para facilitar o entendimento.

<img src="./docs/video.gif" alt="drawing" width="300"/>

## Arquitetura
Baseado na proposta do Reso Coder: 
(https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)

<img src="./docs/CleanArchitecture-Flutter.png" alt="drawing" width="650"/>

<br />

## Testes (Unit / Widget)

O app possui testes em todas as camadas:
* Testes de Widget
* Presenter (ViewModel)
* UseCase / Domain
* Repository
* DataSource / API


### Run Tests
![Coverage](./coverage_badge.svg?sanitize=true)

flutter test --coverage

<img src="./docs/all_tests.png" alt="drawing" width="500"/>


### Test Code Coverage

<img src="./docs/coverage.png" alt="drawing" width="900"/>


## Testes de Integração

Além dos testes unitários e de Widgets, foi criado um teste de integração para demonstrar um fluxo completo de login com sucesso no aplicativo.

### Run Integration Tests
flutter drive \
  --driver=integration_test/driver.dart \
  --target=integration_test/app_test.dart