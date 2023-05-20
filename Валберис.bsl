
// Сервисные процедуры и функции

Функция СтруктураВJSON(Структура)

	ЗаписьJSON = Новый ЗаписьJSON;
	ПараметрыЗаписи = Новый ПараметрыЗаписиJSON(, "    ");
	ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписи);
	ЗаписатьJSON(ЗаписьJSON, Структура);
	Результат = ЗаписьJSON.Закрыть();

	Возврат Результат;

КонецФункции

Функция JSONВСтруктуру(ТекстJSON)

	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(ТекстJSON);
	Результат = ПрочитатьJSON(ЧтениеJSON);

	Возврат Результат;

КонецФункции

Процедура СообщитьОбОшибке(ТекстОшибки)

	Сообщить(ТекстОшибки);
	ЗаписьЖурналаРегистрации("wb_ВыгрузитьОстаткиТоваров", УровеньЖурналаРегистрации.Ошибка, , , ТекстОшибки);

КонецПроцедуры

// Регистрация внешней обработки

Функция СведенияОВнешнейОбработке(ВерсияБСП = "") Экспорт

	Результат = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке(ВерсияБСП);

	Результат.БезопасныйРежим = Ложь;
    Результат.Вид 	 		  = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
    Результат.Версия 		  = "0.05";

    НоваяКоманда = Результат.Команды.Добавить();
    НоваяКоманда.Представление 		  = "Wildberries: выгрузить остатки товаров";
    НоваяКоманда.Идентификатор 		  = "wb_ВыгрузитьОстаткиТоваровРучнойРежим";
    НоваяКоманда.Использование 		  = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
    НоваяКоманда.ПоказыватьОповещение = Ложь;

    НоваяКоманда = Результат.Команды.Добавить();
    НоваяКоманда.Представление 		  = "Wildberries: выгрузить остатки товаров (по расписанию)";
    НоваяКоманда.Идентификатор 		  = "wb_ВыгрузитьОстаткиТоваровПоРасписанию";
    НоваяКоманда.Использование 		  = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
    НоваяКоманда.ПоказыватьОповещение = Ложь;

	Возврат Результат;

КонецФункции

//

Процедура ЗаполнитьРеквизиты(ПараметрыWB = Неопределено) Экспорт

	Если ПараметрыWB = Неопределено Тогда
	    WarehouseID = ХранилищеОбщихНастроек.Загрузить("wb_ВыгрузитьОстаткиТоваров", "WarehouseID");
	    Token   	= ХранилищеОбщихНастроек.Загрузить("wb_ВыгрузитьОстаткиТоваров", "Token");
	    Склад    	= ХранилищеОбщихНастроек.Загрузить("wb_ВыгрузитьОстаткиТоваров", "Склад");
	Иначе
		WarehouseID = ПараметрыWB.WarehouseID;
		Token = ПараметрыWB.Token;
		Склад = ПараметрыWB.Склад;
	КонецЕсли;

КонецПроцедуры

Процедура ВыполнитьКоманду(ИдентификаторКоманды) Экспорт

	Если ИдентификаторКоманды = "wb_ВыгрузитьОстаткиТоваровПоРасписанию" Тогда
		МассивПараметров = Новый Массив();

		// Москва
		ПараметрыWB = Новый Структура();
		//ПараметрыWB.Вставить("WarehouseID", "175969");
		//ПараметрыWB.Вставить("WarehouseID", "569061");
		ПараметрыWB.Вставить("WarehouseID", "573306");
		ПараметрыWB.Вставить("Token", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NJRCI6ImNkNzA2N2FiLTU3YTEtNDJkZi04NWYzLTRhZjlkZmM4MmQ0MyJ9.qznnYpnvZrSzUnUeWjMl7U0pt7LFAq8aIlSYyGuxinQ");
		ПараметрыWB.Вставить("Склад", Справочники.СтруктурныеЕдиницы.НайтиПоКоду("НФ-000027"));
		ПараметрыWB.Вставить("ИмяСвойстваШК", "Штрихкод_WB_Москва");
		МассивПараметров.Добавить(ПараметрыWB);

		// Новосибирск Автогенная
		ПараметрыWB = Новый Структура();
		//ПараметрыWB.Вставить("WarehouseID", "243153");
		//ПараметрыWB.Вставить("WarehouseID", "565423");
		ПараметрыWB.Вставить("WarehouseID", "569480");
		ПараметрыWB.Вставить("Token", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NJRCI6IjM2NTI5MTQ5LTk1YzEtNGIzOC05OWM4LWNkYWU2NWM4MDVmMSJ9.CcmOvSxg-MlUWiWkbb2Xq_-arxXNMMJV7wUnv3M3t1o");
		ПараметрыWB.Вставить("Склад", Справочники.СтруктурныеЕдиницы.НайтиПоКоду("НФ-000024"));
		ПараметрыWB.Вставить("ИмяСвойстваШК", "Штрихкод_WB_Новосибирск");
		МассивПараметров.Добавить(ПараметрыWB);

		// Кемерово Сотка
		ПараметрыWB = Новый Структура();
		ПараметрыWB.Вставить("WarehouseID", "205369");
		ПараметрыWB.Вставить("Token", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NJRCI6IjU5ZWE5YjUzLTdjOTMtNDRmZC1iMDdiLTVhODllYTI1NWRhYyJ9.pyrLOIxIynCWACToa5IKM7e0DJzK04gtyywQ0kOaadU");
		ПараметрыWB.Вставить("Склад", Справочники.СтруктурныеЕдиницы.НайтиПоКоду("НФ-000018"));
		ПараметрыWB.Вставить("ИмяСвойстваШК", "Штрихкод_WB_Сотка");
		//МассивПараметров.Добавить(ПараметрыWB);

		// Томск
		ПараметрыWB = Новый Структура();
		ПараметрыWB.Вставить("WarehouseID", "611509");
		ПараметрыWB.Вставить("Token", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NJRCI6IjU0ZjAyYjA4LTk2NmItNDkwNi1hMTViLWFhYTVhODAyNWI5ZiJ9.FpL4yfUx-wXnpVjF_LPfTa9I2XXfYhDJmfHTDwSaeIg");
		ПараметрыWB.Вставить("Склад", Справочники.СтруктурныеЕдиницы.НайтиПоКоду("НФ-000022"));
		ПараметрыWB.Вставить("ИмяСвойстваШК", "Штрихкод_WB_Томск");
		МассивПараметров.Добавить(ПараметрыWB);


		Для Каждого ПараметрыWB Из МассивПараметров Цикл

			ЗаполнитьРеквизиты(ПараметрыWB);

			ПолучитьОстаткиПоТоварам(ПараметрыWB.ИмяСвойстваШК);
			УстановитьОстаткиТоваров();

		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

Процедура ПолучитьОстаткиПоТоварам(ИмяСвойстваШК = "Штрихкод_WB_Новосибирск") Экспорт

	Товары.Очистить();

	// Получаем список товаров, опубликованных в ЛК
	Страница = 0;

	Пока Истина Цикл

		Страница = Страница + 1;

		РезультатЗапроса = ПолучитьМассивТоваров(Страница);

		Если РезультатЗапроса = Неопределено Тогда
			Прервать;
		КонецЕсли;

		Попытка
			МассивТоваров = РезультатЗапроса["stocks"];
			Если МассивТоваров = "null" Тогда
				Прервать;
			КонецЕсли;
			Для каждого СтрокаТовара Из МассивТоваров Цикл
				//Если Формат(СтрокаТовара.warehouseId, "ЧГ=0") = WarehouseID Тогда
				Если СтрокаТовара.warehouseId = WarehouseID Тогда
					НоваяСтрока = Товары.Добавить();
					НоваяСтрока.ID 		  = СтрокаТовара["barcode"];
					НоваяСтрока.ОстатокЛК = СтрокаТовара["stock"];
				КонецЕсли;
			КонецЦикла;
			Если МассивТоваров.Количество() < 1000 Тогда
				Прервать;
			КонецЕсли;
		Исключение
			СообщитьОбОшибке("Ошибка при чтении ответа от сервера: " + ОписаниеОшибки());
			Возврат;
		КонецПопытки;

	КонецЦикла;

	// Заполняем остатки
	Для каждого СтрокаТовара Из Товары Цикл

		ЗаполнитьНоменклатуру(СтрокаТовара, ИмяСвойстваШК);
		ЗаполнитьОстатки(СтрокаТовара);
		//Если ИмяСвойстваШК = "Штрихкод_WB_Новосибирск" Тогда
		//	СтрокаТовара.Остаток = 0;
		//КонецЕсли;
		Если НЕ СтрокаТовара.ЕстьОшибка И СтрокаТовара.ОстатокЛК <> СтрокаТовара.Остаток Тогда
			СтрокаТовара.ОбновитьОстаток = Истина;
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

Процедура УстановитьОстаткиТоваров() Экспорт

	МассивТоваров = Новый Массив;

	Для каждого ТекСтр Из Товары Цикл

		Если НЕ ТекСтр.ОбновитьОстаток Тогда
			Продолжить;
		КонецЕсли;

		МассивТоваров.Добавить(ТекСтр);
		Если МассивТоваров.Количество() = 100 Тогда
			УстановитьОстатки(МассивТоваров);
			МассивТоваров.Очистить();
		КонецЕсли;

	КонецЦикла;

	Если МассивТоваров.Количество() > 0 Тогда
		УстановитьОстатки(МассивТоваров);
	КонецЕсли;

КонецПроцедуры

// Работа с API

Функция ПолучитьПараметрыЗапроса(СтрПараметры)

	Результат = "";

	Для каждого ТекСтр Из СтрПараметры Цикл
		Если Результат <> "" Тогда
			Результат = Результат + "&";
		КонецЕсли;
		Значение = ТекСтр.Значение;
		Если ТипЗнч(Значение) = Тип("Число") Тогда
			Значение = Формат(Значение, "ЧН=0; ЧГ=");
		КонецЕсли;
		Результат = Результат + ТекСтр.Ключ + "=" + КодироватьСтроку(Значение, СпособКодированияСтроки.КодировкаURL, КодировкаТекста.UTF8);
	КонецЦикла;

	Если Результат <> "" Тогда
		Результат = "?" + Результат;
	КонецЕсли;

	Возврат Результат;

КонецФункции

Функция ПолучитьМассивБаркодов(ИмяСвойства = "Штрихкод_WB_Москва")

	МассивБаркодов = Новый Массив;

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ДополнительныеСведения.Объект КАК Объект,
		|	ДополнительныеСведения.Свойство КАК Свойство,
		|	ДополнительныеСведения.Значение КАК Значение,
		|	ЗапасыОстатки.КоличествоОстаток КАК КоличествоОстаток
		|ИЗ
		|	РегистрНакопления.Запасы.Остатки(
		|			,
		|			ЗаказПокупателя = ЗНАЧЕНИЕ(Документ.ЗаказПокупателя.ПустаяСсылка)
		|				И Номенклатура.КатегорияНоменклатуры = &Категория
		|				И СтруктурнаяЕдиница В (&СтруктурнаяЕдиница)) КАК ЗапасыОстатки
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ДополнительныеСведения КАК ДополнительныеСведения
		|		ПО ЗапасыОстатки.Номенклатура = ДополнительныеСведения.Объект
		|ГДЕ
		|	ДополнительныеСведения.Свойство.Имя = &ИмяСвойства";

	Категория = Справочники.КатегорииНоменклатуры.НайтиПоКоду("НФ-000001");// Шины
	Запрос.УстановитьПараметр("Категория", Категория);
	МассивСкладов = Новый Массив;
	МассивСкладов.Добавить(Справочники.СтруктурныеЕдиницы.НайтиПоКоду("НФ-000027"));// Федоров - Москва
	Запрос.УстановитьПараметр("СтруктурнаяЕдиница", МассивСкладов);
	Запрос.УстановитьПараметр("ИмяСвойства", ИмяСвойства);

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаСтруктурнаяЕдиница = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);

	Пока ВыборкаСтруктурнаяЕдиница.Следующий() Цикл

		Если ВыборкаСтруктурнаяЕдиница.КоличествоОстаток >= 8 Тогда
		НоваяЗапись = Новый Структура("sku, amount");
			НоваяЗапись.sku = Число(ВыборкаСтруктурнаяЕдиница.Значение);
			НоваяЗапись.amount = Число(ВыборкаСтруктурнаяЕдиница.КоличествоОстаток);
			МассивБаркодов.Добавить(НоваяЗапись);
		КонецЕсли;
	КонецЦикла;

	Возврат МассивБаркодов;


КонецФункции


Функция ПолучитьМассивТоваров(Страница)


	МассивБаркодов = ПолучитьМассивБаркодов();

	// Сюда передавать массивы баркодов по 1000 штук за раз, результат поделить на куски до 1000 и отправлять в структуру
	Ресурс = "/api/v2/stocks" + WarehouseID;

	СтрПараметры = Новый Структура;
	//СтрПараметры.Вставить("skip",  1000*(Страница-1));
	//СтрПараметры.Вставить("take",  1000);
	//СтрПараметры.Вставить("sort",  "barcode");
	//СтрПараметры.Вставить("order", "asc");
	СтрПараметры.Вставить("skus", МассивБаркодов); // WarehouseID ); // <== подставить массив баркодов

	Ресурс = Ресурс + ПолучитьПараметрыЗапроса(СтрПараметры);

	Попытка
		РезультатЗапроса = ОтправитьЗапрос(Ресурс, "GET");
	Исключение
		ТекстОшибки = ОписаниеОшибки();
		СообщитьОбОшибке("При получении списка товаров возникла ошибка: " + ТекстОшибки);
		Возврат Неопределено;
	КонецПопытки;

	Возврат РезультатЗапроса;

КонецФункции

Процедура УстановитьОстатки(МассивТоваров) Экспорт

	МассивБаркодов = ПолучитьМассивБаркодов(); //+

	Ресурс = "/api/v2/stocks";

	stocks = Новый Массив;

	Для каждого ТекСтр Из МассивБаркодов Цикл
		СтруктураТовара = Новый Структура;
		СтруктураТовара.Вставить("sku", 	ТекСтр.ID); //баркод
		СтруктураТовара.Вставить("amount",		ТекСтр.Остаток);  // остаток
		//СтруктураТовара.Вставить("warehouseId", WarehouseID);
		stocks.Добавить(СтруктураТовара);
	КонецЦикла;

	ТекстЗапроса = СтруктураВJSON(stocks);

	Попытка
		РезультатЗапроса = ОтправитьЗапрос(Ресурс, "POST", ТекстЗапроса);
	Исключение
		СообщитьОбОшибке("При установке остатков товаров возникла ошибка: " + ОписаниеОшибки());
	КонецПопытки;

КонецПроцедуры

Функция ОтправитьЗапрос(Ресурс, Метод, ТекстЗапроса = Неопределено, Заголовки = Неопределено)

	Попытка
		Если Заголовки = Неопределено Тогда
			Заголовки = Новый Соответствие;
			Заголовки.Вставить("authorization", Token);
			Заголовки.Вставить("accept", 		"application/json");
			Заголовки.Вставить("content-type", 	"application/json");
		КонецЕсли;

		Запрос = Новый HTTPЗапрос(Ресурс, Заголовки);

		Если ТипЗнч(ТекстЗапроса) = Тип("Строка") Тогда
			Запрос.УстановитьТелоИзСтроки(ТекстЗапроса);
		ИначеЕсли ТипЗнч(ТекстЗапроса) = Тип("ДвоичныеДанные") Тогда
			Запрос.УстановитьТелоИзДвоичныхДанных(ТекстЗапроса);
		КонецЕсли;

		Сервер = "suppliers-api.wildberries.ru";

		Соединение = Новый HTTPСоединение(Сервер, 443, , , , , Новый ЗащищенноеСоединениеOpenSSL());
		Если Метод = "POST" Тогда
			Ответ = Соединение.ОтправитьДляОбработки(Запрос);
		Иначе
			Ответ = Соединение.Получить(Запрос);
		КонецЕсли;
	Исключение
		ТекстОшибки = ОписаниеОшибки();
		Сообщить("Ошибка при вызове метода API: " + ТекстОшибки);
		Возврат Неопределено;
	КонецПопытки;

	Попытка
		ТекстОтвета = Ответ.ПолучитьТелоКакСтроку();
	Исключение
		ТекстОшибки = ОписаниеОшибки();
		Сообщить("Ошибка при получении ответа: " + ТекстОшибки);
		Возврат Неопределено;
	КонецПопытки;

	Попытка
		Рез = JSONВСтруктуру(ТекстОтвета);
	Исключение
		ТекстОшибки = ОписаниеОшибки();
		Сообщить("Ошибка при чтении JSON: " + ТекстОшибки + Символы.ПС + "Текст ответа: " + ТекстОтвета);
		Возврат Неопределено;
	КонецПопытки;

	Попытка
		Если Рез.Свойство("error") Тогда
			Если Рез["error"] = Истина Тогда
				ТекстОшибки = ТекстОтвета;
				Сообщить("Ошибка при обработке метода API: " + ТекстОшибки);
				Возврат Неопределено;
			КонецЕсли;
		КонецЕсли;
	Исключение
		ТекстОшибки = ОписаниеОшибки();
		Сообщить("Ошибка при обработке метода API: " + ТекстОшибки);
		Возврат Неопределено;
	КонецПопытки;

	Возврат Рез;

КонецФункции

Процедура ОбработатьРезультатЗапроса(Рез)

	Если ЗначениеЗаполнено(Рез["ТекстОшибки"]) Тогда
		Сообщить(Рез["ТекстОшибки"]);
	КонецЕсли;

	Если ЗначениеЗаполнено(Рез["Результат"]) Тогда
		JSON = СтруктураВJSON(Рез["Результат"]);
	Иначе
		JSON = Рез["ТекстОтвета"];
	КонецЕсли;

КонецПроцедуры

// УНФ - ERP

Процедура ЗаполнитьОстатки(СтрокаТЧ)

	// УНФ - ERP
	ЗаполнитьОстаткиУНФ(СтрокаТЧ);

КонецПроцедуры

Процедура ЗаполнитьНоменклатуру(СтрокаТЧ, ИмяСвойстваШК = "Штрихкод_WB_Новосибирск")

	// УНФ - ERP
	Выборка = НайтиНоменклатуруУНФ(СтрокаТЧ, ИмяСвойстваШК);

	Если Выборка.Количество() = 0 Тогда

		СтрокаТЧ.ЕстьОшибка 	= Истина;
		СтрокаТЧ.ОписаниеОшибки = "Товар не найден!";
		Возврат;

	ИначеЕсли Выборка.Количество() > 1 Тогда

		СтрокаТЧ.ЕстьОшибка 	= Истина;
		СтрокаТЧ.ОписаниеОшибки = "Найдено несколько товаров с одинаковым идентификатором!";
		Возврат;

	КонецЕсли;

	Выборка.Следующий();

	СтрокаТЧ.Номенклатура = Выборка.Ссылка

КонецПроцедуры

// УНФ

Функция НайтиНоменклатуруУНФ(СтрокаТЧ, ИмяСвойства = "Штрихкод_WB_Новосибирск")

	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ДополнительныеСведения.Объект КАК Ссылка
	|ИЗ
	|	РегистрСведений.ДополнительныеСведения КАК ДополнительныеСведения
	|ГДЕ
	|	ДополнительныеСведения.Значение = &Штрихкод
	|	И ДополнительныеСведения.Свойство.Имя = &ИмяСвойства";

	Запрос = Новый Запрос(ТекстЗапроса);

	Запрос.УстановитьПараметр("Штрихкод", СтрокаТЧ.ID);
	Запрос.УстановитьПараметр("ИмяСвойства", ИмяСвойства);

	Выборка = Запрос.Выполнить().Выбрать();

	Возврат Выборка;

КонецФункции

Процедура ЗаполнитьОстаткиУНФ(СтрокаТЧ)

	Если СтрокаТЧ.ЕстьОшибка Тогда
		Возврат;
	КонецЕсли;

	ТекстЗапроса =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ЗапасыОстатки.Номенклатура КАК Номенклатура,
	|	СУММА(ВЫБОР
	|			КОГДА ЗапасыОстатки.ЗаказПокупателя = ЗНАЧЕНИЕ(Документ.ЗаказПокупателя.ПустаяСсылка)
	|				ТОГДА 0
	|			ИНАЧЕ ЕСТЬNULL(ЗапасыОстатки.КоличествоОстаток, 0)
	|		КОНЕЦ) КАК Резерв,
	//|	СУММА(ЕСТЬNULL(ВЫБОР
	//|			КОГДА ЗапасыОстатки.Номенклатура.Родитель.Родитель.Код = ""НФ-00159576""
	//|				ТОГДА 0
	//|			ИНАЧЕ ЗапасыОстатки.КоличествоОстаток
	//|		КОНЕЦ, 0)) КАК Количество
	|	СУММА(ЗапасыОстатки.КоличествоОстаток) КАК Количество
	|ИЗ
	|	РегистрНакопления.Запасы.Остатки(
	|			,
	|			Номенклатура = &Номенклатура
	|				И СтруктурнаяЕдиница = &Склад
	|				И ЗаказПокупателя = ЗНАЧЕНИЕ(Документ.ЗаказПокупателя.ПустаяСсылка)) КАК ЗапасыОстатки
	|
	|СГРУППИРОВАТЬ ПО
	|	ЗапасыОстатки.Номенклатура";

	Если НЕ ЗначениеЗаполнено(Склад) Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "И СтруктурнаяЕдиница = &Склад", "");
	КонецЕсли;

	Запрос = Новый Запрос(ТекстЗапроса);

	Запрос.УстановитьПараметр("Номенклатура", 	 СтрокаТЧ.Номенклатура);
	Запрос.УстановитьПараметр("ТипНоменклатуры", Перечисления.ТипыНоменклатуры.Запас);
	Запрос.УстановитьПараметр("Склад",			 Склад);

	Выборка = Запрос.Выполнить().Выбрать();

	Если Выборка.Следующий() Тогда

		СтрокаТЧ.Остаток = ?(Выборка.Количество < 8, 0, Выборка.Количество);
		//СтрокаТЧ.Остаток = Выборка.Количество;
		//СтрокаТЧ.Остаток = 0;

	КонецЕсли;

КонецПроцедуры
