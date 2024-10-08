//  Подсистема "Абстрактный тип данных массив"
//	Автор: Калякин Андрей Г.
//  https://github.com/KalyakinAG/adt-array
//  https://infostart.ru/1c/articles/1473034/

#Область ПрограммныйИнтерфейс

// Параметры:
//  Ключ - Строка - имя свойства объекта. Определяется для очереди с уникальными элементами
//  ФункцияСравнения - Строка - . Определяется для очереди с приоритетом
Функция Очередь(ЕстьУникальность = Ложь, ЕстьПриоритет = Ложь, Ключ = Неопределено, ФункцияСравнения = Неопределено, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Результат = Новый Структура("Элементы, ЕстьПриоритет, ЕстьУникальность, Контекст, Параметры", Новый Массив, ЕстьПриоритет, ЕстьУникальность);
	Если ЕстьПриоритет Тогда
		Результат.Вставить("ФункцияСравнения", ФункцияСравнения);
		Результат.Вставить("Контекст", Контекст);
		Результат.Вставить("Параметры", Параметры);
	КонецЕсли;
	Если ЕстьУникальность Тогда
		Результат.Вставить("Словарь", РаботаСМножеством.Множество(Ключ));
		Результат.Вставить("Ключ", Ключ);
	КонецЕсли;
	Возврат Результат;
КонецФункции

Функция ОчередьУникальныхЗначений(Ключ = Неопределено) Экспорт
	Возврат Очередь(Истина, Ложь, Ключ);
КонецФункции

// Параметры:
//  Ключ - Строка - имя свойства объекта. Определяется для очереди с уникальными элементами
//  ФункцияСравнения - Строка - . Определяется для очереди с приоритетом
Функция ПриоритетнаяОчередь(ФункцияСравнения, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Возврат Очередь(Ложь, Истина, , ФункцияСравнения, Контекст, Параметры);
КонецФункции

Функция ПриоритетнаяОчередьУникальныхЗначений(ФункцияСравнения, Ключ = Неопределено, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Возврат Очередь(Истина, Истина, Ключ, ФункцияСравнения, Контекст, Параметры);
КонецФункции

Процедура Положить(Очередь, Элемент) Экспорт
	Если Очередь.ЕстьУникальность Тогда
		Если РаботаСМножеством.Содержит(Очередь.Словарь, Элемент) Тогда
			Возврат;
		КонецЕсли;
		РаботаСМножеством.Добавить(Очередь.Словарь, Элемент);
	КонецЕсли;
	Если Очередь.ЕстьПриоритет Тогда
		РаботаСМассивом.ПоложитьВОчередьСПриоритетом(Очередь.Элементы, Элемент, Очередь.ФункцияСравнения, Очередь.Контекст, Очередь.Параметры);
	Иначе
		РаботаСМассивом.Положить(Очередь.Элементы, Элемент);
	КонецЕсли;
КонецПроцедуры

Процедура Добавить(Очередь, Элемент) Экспорт
	Положить(Очередь, Элемент);
КонецПроцедуры

Процедура Дополнить(_Множество, Элементы) Экспорт
	Для Каждого Элемент Из Элементы Цикл
		Положить(_Множество, Элемент);
	КонецЦикла;
КонецПроцедуры

//  isEmpty
Функция Пустая(Очередь) Экспорт
	Возврат НЕ ЗначениеЗаполнено(Очередь.Элементы);
КонецФункции

//  pop
Функция Взять(Очередь) Экспорт
	Элемент = РаботаСМассивом.Взять(Очередь.Элементы);
	Если Очередь.ЕстьУникальность Тогда
		РаботаСМножеством.Удалить(Очередь.Словарь, Элемент);
	КонецЕсли;
	Возврат Элемент;
КонецФункции

//  shift
Функция Сдвинуть(Очередь) Экспорт
	Элемент = РаботаСМассивом.Сдвинуть(Очередь.Элементы);
	Если Очередь.ЕстьУникальность Тогда
		РаботаСМножеством.Удалить(Очередь.Словарь, Элемент);
	КонецЕсли;
	Возврат Элемент;
КонецФункции

//  has
Функция Содержит(Очередь, Элемент) Экспорт
	Если Очередь.ЕстьУникальность Тогда
		Возврат РаботаСМножеством.Содержит(Очередь.Словарь, Элемент);
	КонецЕсли;
	Если Очередь.ЕстьПриоритет Тогда
		Возврат РаботаСМассивом.НайтиЭлементОчередиСПриоритетом(Очередь.Элементы, Элемент, 0, Очередь.Элементы.Количество(), Очередь.ФункцияСравнения);		
	КонецЕсли;
	Возврат РаботаСМассивом.НайтиЭлемент(Очередь.Элементы, "Элемент = Параметры", , Элемент) <> Неопределено;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
