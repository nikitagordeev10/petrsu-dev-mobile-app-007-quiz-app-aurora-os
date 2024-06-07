BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Easy" (
	"exhibitId"	INTEGER,
	"exhibitName"	TEXT,
	"exhibitImage"	TEXT,
	PRIMARY KEY("exhibitId" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Medium" (
	"exhibitId"	INTEGER,
	"exhibitName"	TEXT,
	"exhibitImage"	TEXT,
	PRIMARY KEY("exhibitId" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Hard" (
	"exhibitId"	INTEGER,
	"exhibitName"	TEXT,
	"exhibitImage"	TEXT,
	PRIMARY KEY("exhibitId" AUTOINCREMENT)
);
INSERT INTO "Easy" ("exhibitId","exhibitName","exhibitImage") VALUES
 (1,'Морошка','cloudberry.png'),
 (2,'Герб Карелии','emblem_karelia.png'),
 (3,'Изба','cottage.png'),
 (4,'Клюква','cranberry.png'),
 (5,'Морошка','cloudberry.png'),
 (6,'Окунь','perch.png'),
 (7,'Медведь','bear.png'),
 (8,'Лось','fox.png'),
 (9,'Карельская вышивка','karelian_embroidery.png'),
 (10,'Земляника','strawberries.png'),
 (11,'Белый гриб','white_mushroom.png'),
 (12,'Калитка','wicket.png'),
 (13,'Онежское озеро','lake_onega.png');
INSERT INTO "Medium" ("exhibitId","exhibitName","exhibitImage") VALUES (1,'Балалайка','balalaika.png'),
 (2,'Калевала','kalevala.png'),
 (3,'Национальный костюм','national_costume.png'),
 (4,'Флаг Карелии','flag_karelia.png'),
 (5,'Щука','pike.png'),
 (6,'Шунгит','shungite.png'),
 (7,'Кантеле','kantele.png'),
 (8,'Водопад Кивач','kivach_waterfall.png'),
 (9,'Кижи','kizhi.png'),
 (10,'Ладожские шхеры','ladoga_skerries.png'),
 (11,'Соловецкий монастырь','solovetsky_monastery.png');
INSERT INTO "Hard" ("exhibitId","exhibitName","exhibitImage") VALUES (1,'Иван-чай','blooming_sally.png'),
 (2,'Форель','trout.png'),
 (3,'Валаамский монастырь','valaam_monastery.png'),
 (4,'Национальный парк Водлозерский','vodlozersky_national_park.png'),
 (5,'Гирвас','girvas.png'),
 (6,'Каларуокка карельская уха','kalaruoka_karelian_fish_soup.png'),
 (7,'Петрозаводск','petrozavodsk.png'),
 (8,'Рускеала','ruskeala.png');
COMMIT;
