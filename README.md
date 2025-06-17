Пакет позволяет быстро подготовить к работе crond (апплет busybox) на устройствах Keenetic/Netcraze, поддерживающих Entware.

За основу взята [инструкция](https://web.archive.org/web/20231004003915/https://forums.zyxmon.org/viewtopic.php?f=5&t=5257) от [zyxmon](https://github.com/zyxmon).

Установка:
1. **Офлайн вариант:**
	- Скачать пакет и загрузить на устройство/внешний накопитель
	- Выполнить команду `opkg install "/путь_к_пакету/crond-busybox_1.0_all.ipk"`
2. **Онлайн вариант:**
	- Выполнить команду `opkg update && opkg install wget-ssl ca-bundle && opkg install https://github.com/dimon27254/crond-busybox/releases/download/1.0/crond-busybox_1.0_all.ipk`
3. Указать свои задачи для cron с помощью команды `crontab -e`
