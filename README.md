# Alex2421_infra


//Для подключения к Host через ssh используются алиасы добавляем их в ~/.ssh/config:


  HostName 178.154.221.235
  Port 22
  User appuser
  IdentityFile ~/.ssh/appuser


Host someinternalhost
  HostName 10.128.0.5
  ProxyJump bastion
  Port 22
  User appuser
  IdentityFile ~/.ssh/appuser


//После настроек можно использовать:

alias someinternalhost='ssh someinternalhost'

//IP адреса
bastion = 178.154.222.53
someinternalhost = 10.128.0.11


//Дополнительное задание:

WEB-интерфейс pritunl: https://178.154.222.53/setup 
