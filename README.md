# Домашняя работа №6 курса Otus Linux.Professional 
## Управление пакетами. Дистрибьюция софта 

- Vagrantfile создает виртуальную машину и выполняет скрипт startup_script_server.sh, который:   
  Скачивает nginx пакет с исходными кодами;  
  Скачивает openssl пакет с исходными кодами;  
  Собирает пакет nginx с поддержкой openssl;  
  Устанавливает полученый пакет;  
  После установки размещает на локальном веб вервере репозиторий с полученым пакетом и пакетом mysql.