# Samofimp_infra
Samofimp Infra repository

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
