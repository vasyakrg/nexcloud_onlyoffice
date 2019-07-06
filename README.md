# Create Nextcloud + OnlyOffice instances by GCP

## Описание

- Данный репозиторий служит описанием по созданию виртуальных машин в сервисе [GCP](https://console.cloud.google.com) для последующего разворачивания персонального хранилища на базе [Nextcloud](https://nextcloud.com/install/#instructions-server) и онлайн-редактора документов [ONLYOFFICE](https://www.onlyoffice.com/ru/connectors-nextcloud.aspx)
	- а так же задание пароля из сгенерированной строки для пользователя из переменной username
	- в корне проекта создается файл host с ip адресом созданных машин и логином и паролем

### Предварительные требования
- предполагается, что вы уже зарегистрированы в [GCP](https://console.cloud.google.com) и и создали персональный проект
- для начально работы (в MacOS) необходимо установить [terraform](https://www.terraform.io)
  > brew install terraform
  - и [Go](https://golang.org/)
  > brew install go

#### Создание виртуальной машины
- переименовываем файл **vars.tf.example** в **vars.tf**
- переименовываем файл **terraform.tfvars.example** в **terraform.tfvars**
- заполняем переменные по вашему усмотрению

- инициализируем:
 	> terraform init

- проверяем на ошибки:
	> terraform plan

- создаем ВМ:
 	> terraform apply

#### Финальная настройка скриптов
- зайти на машину nextcloud-app и запустить скрипт:
 	> sudo bash nextcloud_install_production.sh

	- далее руководствуйтесь предложениями скрипта и здравым смыслом

- зайти на машину onlyoffice-app и запустить скрипт:
	> sh docs-install.sh

	- при запросе пароля укажите - onlyoffice
	- далее руководствуйтесь предложениями скрипта и здравым смыслом

- Видео с подробными инструкциями доступно [тут]()

##### Автор
 - **Vassiliy Yegorov** - *Initial work* - [vasyakrg](https://github.com/vasyakrg)
