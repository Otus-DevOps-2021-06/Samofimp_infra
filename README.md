# Домашнее задание №5
## Подключение к someinternalhost в одну строку
~~~ bash
ssh -J appuser@bastion_host_ip appuser@psomeinternalhost_ip
~~~

# Домашнее задание №7
## Команда для запуска билда образа
~~~ bash
packer build -var-file=variables.json ./ubuntu16.json
~~~

Необходимо создать собственный **variables.json** в папке **packer**.

Пример файла с переменными находится в **packer/variables.json.example**.

## Обязательные параметры
* **folder_id**
* **service_account_key_file**
* **source_image_id**

## Опциональные параметры
* **image_name**
* **disk_type**

## Билд bake-образа
~~ bash
packer build -var-file=variables.json ./immutable.json
~~

## Развёртывание ВМ
Запустить скрипт **config-scripts/create-reddit-vm.sh**

Для параметра **--ssh-key** указать свой публичный ключ

# Домашнее задание №8, 9
## Развёртывание ВМ с помощью Terraform
~~~ bash
terraform init
terraform apply
~~~

Необходимо задать собственные переменные в файле **terraform.tfvars** по примеру из **terraform.tfvars.example**


# Домашнее задание №10

Конфигурационные файлы Ansible расположены в директории **ansible** соответственно.

## Ansible-playbook объяснение
При выполнении плейбука в секции PLAY RECAP отображается:
* ok - число успешно выполненных операций, которые не произвели никаких изменений в ВМ
* changed - число успешно выполненных операций, которые произвели изменения в ВМ
* unreachable - число операций, которые были провалены из-за проблем с доступом
* failed - число проваленных и невыполненных операций
* skipped - число пропущенных операций из-за заданных условий в секции **when**
* ignored - число операций, которые были выполнены с ошибкой, но проигнорированы из-за **ignore_errors: true**

При выполнении playbook с уже склонированным репозиторием никаких изменений на ВМ не происходит, поэтому в PLAY RECAP значение changed=0. Однако, после удаления репозитория и выполнения playbook происходит новое клонирование репозитория, изменения применяются и changed=1.

# Домашнее задание №11

Были разработаны Ansible плейбуки для инстанса с приложением, базой данных и плейбук для деплоя.

Запуск всех плейбуков в нужном порядке производится командой:
~~~ bash
ansible-playbook site.yml
~~~

Также для сборки образов Packer были изменены провижинеры на Ansible **packer_app.yml** и **packer_db.yml**.

# Домашнее задание №12

На основе плейбуков созданы раздельные роли - **app** и **db**.

Описаны окружения **prod** и **stage**.

Созданы пользователи, проведена работа с Ansible Vault.

Выполнение плейбука в **stage** окружении:
~~~ bash
ansible-playbook playbooks/site.yml
~~~
Выполнение плейбука в **prod** окружении:
~~~ bash
ansible-playbook -i environments/prod/inventory playbooks/site.yml
~~~

# Домашнее задание №13

Запуск машин с помощью Vagrant (производится в директории **ansible**):
~~~ bash
vagrant up
~~~
Удаление созданных машин:
~~~ bash
vagrant destroy -f
~~~

*Приложение проксируется с помощью nginx, доступно по адресу 10.10.10.20 на 80 порту.*

Произведено тестирование роли db (версия molecule=2.22). Выполняется проверка, что:
* сервис MongoDB запущен на машине,
* в файле конфигурации MongoDB задан bindIp,
* база данных слушает по порту 27017.
Директория: 
ansible/roles/db/molecule/default/tests

~~~ bash
molecule verify
~~~
