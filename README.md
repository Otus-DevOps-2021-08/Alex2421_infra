-Подготовка образов с помощью packer

Выполненные работы

1. Создаем новую ветку packer-base и переносим скрипты из предыдущего ДЗ в config-scripts

2. Устанавливаем packer

Создаем сервисный аккаунт в yc
SVC_ACCT="......."
FOLDER_ID="......"
yc iam service-account create --name $SVC_ACCT --folder-id $FOLDER_ID
предоставляем пользователю права editor

3. ACCT_ID=$(yc iam service-account get $SVC_ACCT |  grep ^id | awk '{print $2}')
yc resource-manager folder add-access-binding --id $FOLDER_ID --role editor --service-account-id $ACCT_ID
создаем IAM ключ

yc iam key create --service-account-id $ACCT_ID --output /home/appuser/key.json

4. Создаем шаблон packer

mkdir packer
touch packer\ubuntu16.json
mkdir packer\scripts
cp config-scripts\install_ruby.sh packer\scripts\
cp config-install_mongodb.sh packer\scripts\
Заполняем шаблон ubuntu16.json

{
    "builders": [
        {
            "type": "yandex",
            "service_account_key_file": "./key.json",
            "folder_id": "b1g12ajnlaesj6c89gcd",
            "source_image_family": "ubuntu-1804-lts",
            "image_name": "reddit-base-{{timestamp}}",
            "image_family": "reddit-base",
            "ssh_username": "ubuntu",
            "platform_id": "standard-v1",
            "use_ipv4_nat": "true"

        }
    ],
    "provisioners": [
        {
            "type": "shell",
            "script": "scripts/install_ruby.sh",
            "execute_command": "sudo {{.Path}}"
        },
        {
            "type": "shell",
            "script": "scripts/install_mongodb.sh",
            "execute_command": "sudo {{.Path}}"
        }
    ]
}

- Проверяем и собираем образ
packer validate ./ubuntu16.json
packer build ./ubuntu16.json

- Помимо описанной в ДЗ проблемы (отсутвием "use_ipv4_nat": "true") столкнулся c такой проблемой:

==> yandex: Error creating network: server-request-id = 20472c4c-1dea-baed-b75c-4077f496dbba client-request-id = 08fe7700-5bdb-430d-a21f-f35d1e0f50f2 client-trace-id = 4e4eff9e-3140-4e19-9306-9abde5652fa.....................................

- Исправил удаление лишних сетевых профилей в YC. 

Проверяем работу нашего образа
Создаем файлы с переменными variables.json и variables.json.example
{
  "key": "key.json",
  "fid": "abcde",
  "image": "ubuntu-1604-lts"
}
Добвляем variables.json в .gitignore
Параметризуем другие переменные
"disk_name": "reddit-base",
"disk_size_gb": "20",

Для валидации в travis необходимо создать key.json идентичный рабочему
{
   "id": "abcd",
   "service_account_id": "efj",
   "created_at": "2021-09-20T13:09:29Z",
   "key_algorithm": "RSA_2048",
   "public_key": "-----BEGIN PUBLIC KEY-----\n",
   "private_key": "-----BEGIN PRIVATE KEY-----\n"
}
