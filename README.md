# Alex2421_infra


Задание Управление ресурсами yandex cloud через YC

testapp_IP = 178.154.231.86
testapp_port = 9292

Задание:

Создание виртуалки с запущенным сервисом скрипт находится instance.sh параметры в user-data.yml

yc compute instance create
--name reddit-app-auto
--hostname reddit-app2
--cores=2
--memory=4
--core-fraction=20
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4
--metadata serial-port-enable=1
--metadata-from-file user-data=./user-data.yml



Приложение доступно по адресу:  http://178.154.231.86:9292/
