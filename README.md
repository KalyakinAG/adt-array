# Работа с массивом как с абстрактным типом данных на 1С

[![OpenYellow](https://img.shields.io/endpoint?url=https://openyellow.org/data/badges/1/382631462.json)](https://openyellow.org/grid?data=top&repo=382631462) ![Версия](https://img.shields.io/badge/Версия_1С-8.3.24-yellow)

Реализована библиотека по работе с массивом. В библиотеке доступны абстрактные функции: Отобрать (filter), НайтиЭлемент (find), Сортировать (sort), Отобразить (map), Преобразовать (reduce), Взять (pop), Положить (push), ДляКаждого (forEach).

Функции библиотеки доступны в серверном и клиентском контекстах.

Реализована также и объектная модель АТД массива. Объектная модель позволяет использовать при работе с АТД массивом текучий интерфейс.

[![Модель запроса](https://infostart.ru/bitrix/templates/sandbox_empty/assets/tpl/abo/img/logo.svg)](infostart.ru/1c/articles/1473034/)
### Оглавление:
- [Примеры](#примеры)
	- [Конструктор](#конструктор)
	- [Сортировать (sort)](#сортировать-sort)
	- [Отобрать (filter)](#отобрать-filter)
	- [Отобразить (map)](#отобразить-map)
	- [Преобразовать (reduce)](#преобразовать-reduce)
	- [Еще примеры](#еще-примеры)
	- [Совместно с БСП](#совместно-с-бсп)
	- [Пример использования оператора Спрямить (flat)](#пример-использования-оператора-спрямить-flat)
	- [Пример использования абстракций Диапазон и Срез](#пример-использования-абстракций-диапазон-и-срез)
- [Состав и установка](#состав-и-установка)
	- [Установить как расширение](#установить-как-расширение)
	- [Объединить с конфигурацией текущего проекта](#объединить-с-конфигурацией-текущего-проекта)
	- [Объединить с конфигурацией проекта KASL](#объединить-с-конфигурацией-проекта-kasl)
- [Зависимости](#зависимости)

## Примеры

Больше примеров смотрите в статьях:
- [Работа с абстрактным массивом](https://infostart.ru/1c/articles/1473034/)
- [Абстрактные типы, множества, очереди. Примеры использования](https://infostart.ru/1c/2093459/)

### Конструктор

```bsl
Фрукты = РаботаСМассивом.АТДМассив(СтрРазделить("вишня, арбузы, бананы", ", ", Ложь));
Фрукты.ДляКаждого("Сообщить(Элемент)");// [вишня, арбузы, бананы]
```
### Сортировать (sort)

```bsl
Фрукты.Сортировать();
Фрукты.ДляКаждого("Сообщить(Элемент)");// [арбузы, бананы, вишня]
```
### Отобрать (filter)

```bsl
Фрукты.Отобрать("СтрНайти(Элемент, ""а"") > 0");
Фрукты.ДляКаждого("Сообщить(Элемент)");// [арбузы, бананы]
```
### Отобразить (map)

```bsl
Фрукты.Отобразить("ВРег(Лев(Элемент, 1)) + Прав(Элемент, СтрДлина(Элемент) - 1)");
Фрукты.ДляКаждого("Сообщить(Элемент)");// [Арбузы, Бананы]
```
### Преобразовать (reduce)

```bsl
Количество = Фрукты.Преобразовать("Накопитель + 1", 0);
Сообщить(Количество);// 2
```
### Еще примеры

```bsl
Элементы.ДоговорКонтрагентов.СвязиПараметровВыбора = РаботаСМассивом.АТДМассив()
    .Положить(Новый СвязьПараметраВыбора("Отбор.Владелец", "Объект.Организация"))
    .ВФиксированныйМассив()
;
ДопустимыеТипы = Новый ОписаниеТипов(РаботаСМассивом.АТДМассив()
    .Положить(Тип("СправочникСсылка._ДемоНоменклатура"))
    .Положить(ОбщегоНазначения.ОписаниеТипаСтрока(20))
    .ВМассив())
;
Сотрудники = РаботаСМассивом.АТДМассив()
    .Положить(Новый Структура("Фамилия, Имя, Отчество", "Иванов", "Иван", "Иванович"))
    .Положить(Новый Структура("Фамилия, Имя, Отчество", "Иванов", "Иван", "Гермагенович"))
    .Положить(Новый Структура("Фамилия, Имя, Отчество", "Савельев", "Иван", "Иванович"))
    .Положить(Новый Структура("Фамилия, Имя, Отчество", "Андреев", "Иван", "Иванович"))
    .Положить(Новый Структура("Фамилия, Имя, Отчество", "Андреев", "Андрей", "Андреевич"))
;
Сотрудники.СортироватьПо("Фамилия, Имя, Отчество");
Сотрудники.ДляКаждого("Сообщить(СтрШаблон(""%1 %2 %3"", Элемент.Фамилия, Элемент.Имя, Элемент.Отчество))"); // [Андреев Андрей Андреевич, Андреев Иван Иванович, Иванов Иван Гермагенович, Иванов Иван Иванович, Савельев Иван Иванович]
```
### Совместно с БСП

```bsl
Файлы = Новый Массив;
РаботаСФайлами.ЗаполнитьПрисоединенныеФайлыКОбъекту(СсылкаНаДокумент, Файлы);
СсылкаНаПрисоединенныйФайл = РаботаСМассивом.АТДМассив(Файлы)
    .Отобрать("СтрНайти(Элемент.Наименование, ""#БДДС#"") > 0")
    .Отобрать("НЕ Элемент.ПометкаУдаления")
    .Взять()
;
```
### Пример использования оператора Спрямить (flat)

```bsl
МетаданныеРасширений = РаботаСМассивом.АТДМассив(СтрРазделить("Константы, Справочники, Документы, РегистрыСведений, РегистрыНакопления", ", ", Ложь))
    .Отобразить("РаботаСМассивом.АТДМассив(Метаданные[Элемент]).Отобрать(""Элемент.РасширениеКонфигурации() <> Неопределено"").ВМассив()")
    .Спрямить()
    .Отобразить("Новый Структура(""ПолноеИмя, Расширение"", Элемент.ПолноеИмя(), Элемент.РасширениеКонфигурации().Имя)")
    .Отобрать("НЕ СтрНачинаетсяС(Элемент.ПолноеИмя, ""Константа."")")
    .ВМассив()
;
Сообщить(ОбщийКлиентСервер.ОбъектВJSON(МетаданныеРасширений));
```
### Пример использования абстракций Диапазон и Срез

```bsl
//  Создание массива чисел от 1 до 100
ИсходныйМассив = РаботаСМассивом.Диапазон(1, 101);
Сообщить(ОбщийКлиентСервер.ОбъектВJSON(ИсходныйМассив));
//  Формирование подмассивов по 10 чисел
Шаг = 10;
Для Каждого Индекс Из РаботаСМассивом.Диапазон(0, 100, Шаг) Цикл
    Срез = РаботаСМассивом.Срез(ИсходныйМассив, Индекс, Индекс + Шаг);
    Сообщить(ОбщийКлиентСервер.ОбъектВJSON(Срез));
КонецЦикла;
```
## Состав и установка

Состав:
- Конфигурация (этот проект):
	- модуль библиотеки *РаботаСМассивом*
	- обработка *АТДМассив*, реализующая объектный интерфейс

Есть несколько вариантов установки:
1. Установить как расширение
2. Объединить с конфигурацией текущего проекта
3. Объединить с конфигурацией проекта KASL

Далее подробнее.
### Установить как расширение

Скачать расширение из последнего релиза проекта и установить в базу.
Требуется также установить расширения проектов из [зависимостей](#зависимости).
### Объединить с конфигурацией текущего проекта

Объединить с файлом конфигурации из последнего релиза проекта:
- Снять признак объединения с общих свойств
- Установить режим объединения с приоритетом в файле
Требуется также установить расширения проектов из [зависимостей](#зависимости).
### Объединить с конфигурацией проекта KASL

Объединить с файлом конфигурации из Демо-базы к статье [Работа с абстрактным массивом](https://infostart.ru/1c/articles/1473034/) или с конфигурацией **KASL.cf** из релиза:
- Установить режим объединения с приоритетом в файле
- Отметить по подсистемам файла:
	- KASL->[ОбщегоНазначения](https://github.com/KalyakinAG/common)
	- KASL->[АТДМассив](https://github.com/KalyakinAG/adt-array)
## Зависимости

- БСП (работает с версией 3 и выше)
- Общие модули из подсистемы [KASL->ОбщегоНазначения](https://github.com/KalyakinAG/common)
