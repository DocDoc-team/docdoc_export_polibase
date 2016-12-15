Docdoc: Модуль интеграции с МИС PoliBase
===========================================

Данное программное обеспечение:

- разработано для любых версий ОС Windows, начиная с Windows 2000/XP и до Windows 10, и
предназначено для обеспечения интеграции на онлайн-расписание Клиники, 
работающей на МИС PoliBase, и Docdoc.ru.

- представляет из себя набор скриптов с открытым исходным кодом. 
Это в том числе позволяет убедиться в полной безопасности данного решения 
любому грамотному системному администратору.

- позволяет обеспечить автоматизированную интеграцию на онлайн-расписание
врачей.

---


УСТАНОВКА
---------

Установка заключается в распаковке архива с проектом в отдельную
папку. Например C:\docdoc_export, E:\integrations\docdoc\ftpexport
или любую иную.

Вы должны будете увидеть список из следующих файлов и подпапок:

      export/                   папка для временного хранения файлов выгрузки
      sql/                      SQL скрипты для чтения данных из БД PoliBase
      winscp/                   сторонний ftp клиент, внутри только бинарные файлы и конфиг
      tmp/                      временные файлы
      docdoc_do_export.bat      основной скрипт
      docdoc_export.bat         скрипт генерации файлов выгрузки
      docdoc_export_config.bat  конфигурационный файл
      docdoc_upload.bat         скрипт загрузки подготовленных файлов на FTP
      readme.md                 этот файл

---


СИСТЕМНЫЕ ТРЕБОВАНИЯ
--------------------

###Операционная система:

Клиентские системы Windows 2000, Windows XP SP2 и SP3 и выше

Серверные системы Windows Server 2003, 2008 и выше


###Требования к железу:

Минимальны, решение работоспособно на уровне компьютерной
техники 2000-х годов и выше.

Для примера, будет работать вполне неплохо на конфигурации с
Intel Pentium IV @2.6 ГГц (одноядерный, с HT)
и 16 Мб свободной оперативной памяти.

Естественно, желательна более современная конфигурация.


###Доступ в сеть интернет:

Скорость от 1 Мбит/с входящая, от 1 Мбит/с исходящая

---

На технике и связи с сетью уровня 2016-го года работа скриптов практически моментальна.

---

КРАТКОЕ РУКОВОДСТВО
-------------------

Все исполняемые shell-скрипты .bat находятся в корне папки.

Для настройки работы потребуется выполнить следующие шаги:

###Первый шаг - настройка конфигурационного файла docdoc_export_config.bat

- Настроить параметры подключения к БД PoliBase "con_str". Для выгрузки можно использовать любого пользователя, у которого есть права
на чтение соответствующих таблиц БД PoliBase.

Строка подключения должна иметь следующий формат:

<user>/<password>@<host>/<service>

, где

<user> - имя учетной записи

<password> - пароль учетной записи

<host> - сервер на котором установленно СУБД Oracle, использовать localhost если скрипт настраивается на том же сервере

<service> - идентификатор Oracle службы

Самое простое - использовать учетную запись под которой работает сама Polibase.
Если вендор не предоставил вам пароль от СУБД, то его можно найти самостоятельно ознакомившись с [инструкцией](#markdown-header-oracle)

- Далее, необходимо прописать в "sql_cmd_path" полный путь до bin папки
Oracle (включая саму bin), в которой находится штатная утилита sqlplus.exe
("SQL*Plus"). Эта утилита умеет работать не только в интерактивном режиме,
но и позволяет себя использовать в режиме одной команды, что используется
в скрипте экспорта.

- После нужно настроить загрузку файлов через webDav или FTP сервер (доступ предоставляем мы).
Режим загрузки определяется в переменной uploadmode (ftp или webdav).
Далее нужно указать в "ftpuser" пользователя, в "ftppass" пароль для доступа,
в "ftpstartdir" относительный путь каталога в который будут сохраняться файлы.
Если для доступа в интернет у вас используется прокси сервер, то нужно
в переменной winscpsettings указать настройки подключения к нему. Обратите внимание, что в зависимости
от режима загрузки (ftp или webdav) настройка доступа разная. В конфиг файле уже заранее
подготовлен шаблон для каждого из режимов, Вам остается только указать имя пользователя ProxyUsername,
хост ProxyHost, хэш пароля ProxyPasswordEnc (его можно получить только сделав настройку соединения в интерфейсе winscp, и забрав
из конфига winscp/winscp.ini)

Остальные настройки "winscppath" путь до ftp клиента и "ftplogpath" лог файл ftp сессий,
оставляем без изменений.

###Второй шаг - проверка работы скрипта экспорта docdoc_export.bat

Запускаем docdoc_export.bat . Этот скрипт отвечает за выгрузку данных для
онлайн-расписания из таблиц Oracle в формат CSV в подпапку /export.

Подпапка /export должна быть доступна для записи учетной записи windows, 
из под которой запускается скрипт.

CSV формат файлов выбран стандартный для русскоязычной версии MS Excel :

- разделителем столбцов является точка-с-запятой ";",
- значения данных обрамлены в двойные кавычки
- в случае встречи символа <"> он экранируется как <"">
- конец строки в windows стиле (символы CR+LF)

Это позволяет, в частности, совершенно просто открывать эти файлы в 
MS Excel для просмотра.

Пример вывода в консоль при корректной отработке скрипта:

    Loading...
    Cleaning from old export files
    Generate new fresh export files
    - clinics
    - doctors
    - schedule
    - busyslots
    Export files generated.

В результате успешной отработки скрипта, в папке /export должны будут
создаться (или перезаписаться) соответственно файлы

    - clinics.csv
    - doctors.csv
    - schedule.csv
    - busyslots.cvs

которые можно просмотреть на корректность отдаваемых данных как в любом
текстовом редакторе, так и в табличном виде, открыв через Excel.


###Третий шаг - проверка работы скрипта выгрузки на FTP docdoc_upload.bat

Запускаем docdoc_upload.bat . Этот скрипт отвечает за отправку подготовленных
предыдущим (docdoc_export.bat) скриптом файлов данных для онлайн-расписания
из папки /export в сеть на FTP сервер Docdoc.

Подпапка /tmp должна быть доступна для записи учетной записи Windows, 
из под которой запускается скрипт.

Это требуется ввиду того, что в начале работы скрипта в /tmp генерируется
временный файл, в который записывается последовательность FTP команд для winscp.
Winscp это opensource ftp-клиент, мы в нашем скрипте поставляем только исполняемые файлы.
Устанавливать его в системе не требуется. Если в вашей системе имеется фаерволл, нужно
добавить для него разрешающие правила.

Лог ftp сессии сохраняется в файле указанном в переменной "ftplogpath",
по-умолчанию это "ftp.log".


###Четвёртый шаг - запуск автоматической выгрузки

Скрипт docdoc_do_export.bat для обеспечения автоматической выгрузки делает
ничто иное как последовательно запускает

- docdoc_export.bat для генерации свежих файлов для экспорта
- и затем сразу docdoc_upload.bat для закачки этих файлов на FTP

и более ничего.

Убедившись в шагах с первого по третий в содержании и работоспособности
скриптов, остаётся сделать финальный шаг для запуска интеграции.

Прописать docdoc_do_export.bat в планировщике задач на запуск
каждые 15 минут.

При большом общем потоке заявок в клинику и, соответственно, частом
изменении свободного расписания врача, может быть обосновано увеличение
частоты выгрузки до каждых 10 или даже 5 минут.

Делать выгрузку реже раза в 15 минут не рекомендуется, по очевидным 
соображениям заботы об актуальности данных о свободном времени врачей.


###Пятый шаг - рекомендации по безопасности

Для скрипта с конфигурационными настройками docdoc_export_config.bat,
а также до содержимого подпапки /tmp, рекомендуется  ограничить доступ
только для администраторов (и юзера, из под которого запускается скрипт,
в случае запуска скрипта не под администратором). Для всех остальных не
следует предоставлять доступ даже на чтение, ввиду хранения в этих файлах
конфиденциальных данных вроде логинов и паролей.

---

## Как получить пароль от Oracle базы

При установке пакета МИС PoliBase, пароль прописывается в конфиге polibase.ini
в каталоге установки. Например E:\CS Polibase ODAC


Поддержка
-----------

По вопросам по модулю и поддержке обращайтесь к нам в Docdoc.ru

Команда разработчиков Докдок
http://docdoc.ru