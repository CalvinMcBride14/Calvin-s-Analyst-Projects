/* DATASET FOUND AT: https://www.dropbox.com/s/znmjrtlae6vt4zi/employees.sql?dl=0 */ 

/* The values populated are fictious and contain no real information regarding actual persons */; 

CREATE DATABASE IF NOT EXISTS employees

USE employees;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS 
dept_emp,
dept_manager,
titles,
salaries, 
employees, 
departments;

CREATE TABLE employees (
    emp_no  INT NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(14) NOT NULL,
    last_name VARCHAR(16) NOT NULL,
    gender ENUM ('M','F')  NOT NULL,    
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE  KEY (dept_name)
);

CREATE TABLE dept_manager (
   emp_no INT NOT NULL,
   dept_no CHAR(4) NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
   FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
   PRIMARY KEY (emp_no,dept_no)
); 

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees (emp_no) ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE titles (
    emp_no INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,title, from_date)
) 
; 

CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
) 
; 
/* Only a portion of the values inserted in this script */ 

INSERT INTO `employees` VALUES (10001,'1953-09-02','Georgi','Facello','M','1986-06-26'),
(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21'),
(10003,'1959-12-03','Parto','Bamford','M','1986-08-28'),
(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01'),
(10005,'1955-01-21','Kyoichi','Maliniak','M','1989-09-12'),
(10006,'1953-04-20','Anneke','Preusig','F','1989-06-02'),
(10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10'),
(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15'),
(10009,'1952-04-19','Sumant','Peac','F','1985-02-18'),
(10010,'1963-06-01','Duangkaew','Piveteau','F','1989-08-24'),
(10011,'1953-11-07','Mary','Sluis','F','1990-01-22'),
(10012,'1960-10-04','Patricio','Bridgland','M','1992-12-18'),
(10013,'1963-06-07','Eberhardt','Terkki','M','1985-10-20'),
(10014,'1956-02-12','Berni','Genin','M','1987-03-11'),
(10015,'1959-08-19','Guoxiang','Nooteboom','M','1987-07-02'),
(10016,'1961-05-02','Kazuhito','Cappelletti','M','1995-01-27'),
(10017,'1958-07-06','Cristinel','Bouloucos','F','1993-08-03'),
(10018,'1954-06-19','Kazuhide','Peha','F','1987-04-03'),
(10019,'1953-01-23','Lillian','Haddadi','M','1999-04-30'),
(10020,'1952-12-24','Mayuko','Warwick','M','1991-01-26'),
(10021,'1960-02-20','Ramzi','Erde','M','1988-02-10'),
(10022,'1952-07-08','Shahaf','Famili','M','1995-08-22'),
(10023,'1953-09-29','Bojan','Montemayor','F','1989-12-17'),
(10024,'1958-09-05','Suzette','Pettey','F','1997-05-19'),
(10025,'1958-10-31','Prasadram','Heyers','M','1987-08-17'),
(10026,'1953-04-03','Yongqiao','Berztiss','M','1995-03-20'),
(10027,'1962-07-10','Divier','Reistad','F','1989-07-07'),
(10028,'1963-11-26','Domenick','Tempesti','M','1991-10-22'),
(10029,'1956-12-13','Otmar','Herbst','M','1985-11-20'),
(10030,'1958-07-14','Elvis','Demeyer','M','1994-02-17'),
(10031,'1959-01-27','Karsten','Joslin','M','1991-09-01'),
(10032,'1960-08-09','Jeong','Reistad','F','1990-06-20'),
(10033,'1956-11-14','Arif','Merlo','M','1987-03-18'),
(10034,'1962-12-29','Bader','Swan','M','1988-09-21'),
(10035,'1953-02-08','Alain','Chappelet','M','1988-09-05'),
(10036,'1959-08-10','Adamantios','Portugali','M','1992-01-03'),
(10037,'1963-07-22','Pradeep','Makrucki','M','1990-12-05'),
(10038,'1960-07-20','Huan','Lortz','M','1989-09-20'),
(10039,'1959-10-01','Alejandro','Brender','M','1988-01-19'),
(10040,'1959-09-13','Weiyi','Meriste','F','1993-02-14'),
(10041,'1959-08-27','Uri','Lenart','F','1989-11-12'),
(10042,'1956-02-26','Magy','Stamatiou','F','1993-03-21'),
(10043,'1960-09-19','Yishay','Tzvieli','M','1990-10-20'),
(10044,'1961-09-21','Mingsen','Casley','F','1994-05-21'),
(10045,'1957-08-14','Moss','Shanbhogue','M','1989-09-02'),
(10046,'1960-07-23','Lucien','Rosenbaum','M','1992-06-20'),
(10047,'1952-06-29','Zvonko','Nyanchama','M','1989-03-31'),
(10048,'1963-07-11','Florian','Syrotiuk','M','1985-02-24'),
(10049,'1961-04-24','Basil','Tramer','F','1992-05-04'),
(10050,'1958-05-21','Yinghua','Dredge','M','1990-12-25'),
(10051,'1953-07-28','Hidefumi','Caine','M','1992-10-15'),
(10052,'1961-02-26','Heping','Nitsch','M','1988-05-21'),
(10053,'1954-09-13','Sanjiv','Zschoche','F','1986-02-04'),
(10054,'1957-04-04','Mayumi','Schueller','M','1995-03-13'),
(10055,'1956-06-06','Georgy','Dredge','M','1992-04-27'),
(10056,'1961-09-01','Brendon','Bernini','F','1990-02-01'),
(10057,'1954-05-30','Ebbe','Callaway','F','1992-01-15'),
(10058,'1954-10-01','Berhard','McFarlin','M','1987-04-13'),
(10059,'1953-09-19','Alejandro','McAlpine','F','1991-06-26'),
(10060,'1961-10-15','Breannda','Billingsley','M','1987-11-02'),
(10061,'1962-10-19','Tse','Herber','M','1985-09-17'),
(10062,'1961-11-02','Anoosh','Peyn','M','1991-08-30'),
(10063,'1952-08-06','Gino','Leonhardt','F','1989-04-08'),
(10064,'1959-04-07','Udi','Jansch','M','1985-11-20'),
(10065,'1963-04-14','Satosi','Awdeh','M','1988-05-18'),
(10066,'1952-11-13','Kwee','Schusler','M','1986-02-26'),
(10067,'1953-01-07','Claudi','Stavenow','M','1987-03-04'),
(10068,'1962-11-26','Charlene','Brattka','M','1987-08-07'),
(10069,'1960-09-06','Margareta','Bierman','F','1989-11-05'),
(10070,'1955-08-20','Reuven','Garigliano','M','1985-10-14'),
(10071,'1958-01-21','Hisao','Lipner','M','1987-10-01'),
(10072,'1952-05-15','Hironoby','Sidou','F','1988-07-21'),
(10073,'1954-02-23','Shir','McClurg','M','1991-12-01'),
(10074,'1955-08-28','Mokhtar','Bernatsky','F','1990-08-13'),
(10075,'1960-03-09','Gao','Dolinsky','F','1987-03-19'),
(10076,'1952-06-13','Erez','Ritzmann','F','1985-07-09'),
(10077,'1964-04-18','Mona','Azuma','M','1990-03-02'),
(10078,'1959-12-25','Danel','Mondadori','F','1987-05-26'),
(10079,'1961-10-05','Kshitij','Gils','F','1986-03-27'),
(10080,'1957-12-03','Premal','Baek','M','1985-11-19'),
(10081,'1960-12-17','Zhongwei','Rosen','M','1986-10-30'),
(10082,'1963-09-09','Parviz','Lortz','M','1990-01-03'),
(10083,'1959-07-23','Vishv','Zockler','M','1987-03-31'),
(10084,'1960-05-25','Tuval','Kalloufi','M','1995-12-15'),
(10085,'1962-11-07','Kenroku','Malabarba','M','1994-04-09'),
(10086,'1962-11-19','Somnath','Foote','M','1990-02-16'),
(10087,'1959-07-23','Xinglin','Eugenio','F','1986-09-08'),
(10088,'1954-02-25','Jungsoon','Syrzycki','F','1988-09-02'),
(10089,'1963-03-21','Sudharsan','Flasterstein','F','1986-08-12'),
(10090,'1961-05-30','Kendra','Hofting','M','1986-03-14'),
(10091,'1955-10-04','Amabile','Gomatam','M','1992-11-18'),
(10092,'1964-10-18','Valdiodio','Niizuma','F','1989-09-22'),
(10093,'1964-06-11','Sailaja','Desikan','M','1996-11-05'),
(10094,'1957-05-25','Arumugam','Ossenbruggen','F','1987-04-18'),
(10095,'1965-01-03','Hilari','Morton','M','1986-07-15'),
(10096,'1954-09-16','Jayson','Mandell','M','1990-01-14'),
(10097,'1952-02-27','Remzi','Waschkowski','M','1990-09-15'),
(10098,'1961-09-23','Sreekrishna','Servieres','F','1985-05-13'),
(10099,'1956-05-25','Valter','Sullins','F','1988-10-18'),
(10100,'1953-04-21','Hironobu','Haraldson','F','1987-09-21'),
(10101,'1952-04-15','Perla','Heyers','F','1992-12-28'),
(10102,'1959-11-04','Paraskevi','Luby','F','1994-01-26'),
(10103,'1953-11-26','Akemi','Birch','M','1986-12-02'),
(10104,'1961-11-19','Xinyu','Warwick','M','1987-04-16'),
(10105,'1962-02-05','Hironoby','Piveteau','M','1999-03-23'),
(10106,'1952-08-29','Eben','Aingworth','M','1990-12-19'),
(10107,'1956-06-13','Dung','Baca','F','1994-03-22'),
(10108,'1952-04-07','Lunjin','Giveon','M','1986-10-02'),
(10109,'1958-11-25','Mariusz','Prampolini','F','1993-06-16'),
(10110,'1957-03-07','Xuejia','Ullian','F','1986-08-22'),
(10111,'1963-08-29','Hugo','Rosis','F','1988-06-19'),
(10112,'1963-08-13','Yuichiro','Swick','F','1985-10-08'),
(10113,'1963-11-13','Jaewon','Syrzycki','M','1989-12-24'),
(10114,'1957-02-16','Munir','Demeyer','F','1992-07-17'),
(10115,'1964-12-25','Chikara','Rissland','M','1986-01-23'),
(10116,'1955-08-26','Dayanand','Czap','F','1985-05-28'),
(10117,'1961-10-24','Kiyotoshi','Blokdijk','F','1990-05-28'),
(10118,'1957-03-29','Zhonghui','Zyda','F','1990-09-13'),
(10119,'1960-12-01','Domenick','Peltason','M','1986-03-14'),
(10120,'1960-03-26','Armond','Fairtlough','F','1996-07-06'),
(10121,'1962-07-14','Guoxiang','Ramsay','M','1989-05-03'),
(10122,'1965-01-19','Ohad','Esposito','M','1992-12-23'),
(10123,'1962-05-12','Hinrich','Randi','M','1993-01-15'),
(10124,'1962-05-23','Geraldo','Marwedel','M','1991-09-05'),
(10125,'1957-09-13','Syozo','Hiltgen','F','1990-10-26'),
(10126,'1954-08-07','Kayoko','Valtorta','M','1985-09-08'),
(10127,'1952-02-24','Subir','Baja','F','1989-01-14'),
(10128,'1958-02-15','Babette','Lamba','F','1988-06-06'),
(10129,'1955-12-02','Armond','Peir','M','1985-12-10'),
(10130,'1955-04-27','Nishit','Casperson','M','1988-06-21'),
(10131,'1952-02-19','Magdalena','Eldridge','M','1994-11-17'),
(10132,'1956-12-15','Ayakannu','Skrikant','M','1994-10-30'),
(10133,'1963-12-12','Giri','Isaak','M','1985-12-15'),
(10134,'1953-04-15','Diederik','Siprelle','M','1987-12-12'),
(10135,'1956-12-23','Nathan','Monkewich','M','1988-02-19'),
(10136,'1961-09-14','Zissis','Pintelas','M','1986-02-11'),
(10137,'1959-07-30','Maren','Hutton','M','1985-02-18'),
(10138,'1955-04-24','Perry','Shimshoni','M','1986-09-18'),
(10139,'1963-03-03','Ewing','Foong','F','1998-03-15'),
(10140,'1957-03-11','Yucel','Auria','F','1991-03-14'),
(10141,'1960-01-17','Shahaf','Ishibashi','F','1993-05-06'),
(10142,'1956-08-29','Tzvetan','Hettesheimer','M','1993-10-28'),
(10143,'1961-07-16','Sakthirel','Bakhtari','M','1988-09-30'),
(10144,'1959-06-17','Marla','Brendel','M','1985-10-14'),
(10145,'1956-03-30','Akemi','Esposito','F','1987-08-01'),
(10146,'1959-01-12','Chenyi','Syang','M','1988-06-28'),
(10147,'1964-10-13','Kazuhito','Encarnacion','M','1986-08-21'),
(10148,'1957-10-04','Douadi','Azumi','M','1995-10-10'),
(10149,'1953-05-20','Xiadong','Perry','F','1986-11-05'),
(10150,'1955-01-29','Zhenbing','Perng','F','1986-11-16'),
(10151,'1959-03-06','Itzchak','Lichtner','M','1990-04-10'),
(10152,'1954-12-01','Jaques','Munro','F','1986-01-27'),
(10153,'1955-12-15','Heekeun','Majewski','M','1987-04-08'),
(10154,'1957-01-17','Abdulah','Thibadeau','F','1990-12-12'),
(10155,'1959-12-07','Adas','Nastansky','M','1990-01-05'),
(10156,'1964-09-19','Sumali','Fargier','M','1985-03-10'),
(10157,'1954-04-23','Nigel','Aloisi','M','1985-11-02'),
(10158,'1958-04-01','Khedija','Mitsuhashi','M','1986-01-29'),
(10159,'1955-03-03','Serif','Buescher','M','1991-05-29'),
(10160,'1953-10-18','Debatosh','Khasidashvili','M','1989-01-30'),
(10161,'1953-04-06','Hairong','Mellouli','F','1988-04-03'),
(10162,'1957-10-05','Florina','Eugenio','M','1991-05-01'),
(10163,'1952-09-17','Karsten','Szmurlo','M','1989-07-19'),
(10164,'1956-01-19','Jagoda','Braunmuhl','M','1985-11-12'),
(10165,'1960-06-16','Miyeon','Macedo','M','1988-05-17'),
(10166,'1953-05-10','Samphel','Siegrist','F','1993-01-01'),
(10167,'1958-05-23','Duangkaew','Rassart','M','1992-04-04'),
(10168,'1964-09-11','Dharmaraja','Stassinopoulos','M','1986-12-06'),
(10169,'1961-05-03','Sampalli','Snedden','F','1992-07-24'),
(10170,'1960-10-03','Kasturi','Jenevein','F','1986-01-02'),
(10171,'1957-09-11','Herbert','Trachtenberg','M','1989-07-22'),
(10172,'1957-03-25','Shigeu','Matzen','F','1995-10-13'),
(10173,'1962-10-28','Shrikanth','Mahmud','M','1992-03-21'),
(10174,'1959-05-15','Badri','Furudate','M','1987-06-01'),
(10175,'1960-01-11','Aleksandar','Ananiadou','F','1988-01-11'),
(10176,'1957-01-24','Brendon','Lenart','F','1994-12-22'),
(10177,'1954-11-08','Pragnesh','Iisaka','M','1993-02-06'),
(10178,'1963-03-13','Valery','Litvinov','M','1986-10-07'),
(10179,'1961-11-25','Deniz','Duclos','F','1990-10-04'),
(10180,'1956-01-29','Shaw','Wendorf','M','1986-02-25'),
(10181,'1963-01-22','Sibyl','Nooteboom','M','1988-06-22'),
(10182,'1961-02-04','Moriyoshi','Merey','F','1990-09-02'),
(10183,'1954-10-17','Mechthild','Bonifati','M','1996-08-11'),
(10184,'1957-05-22','Mihalis','Lowrie','M','1987-10-29'),
(10185,'1959-12-05','Duro','Sidhu','F','1986-03-01'),
(10186,'1953-07-16','Shigehito','Kropatsch','M','1986-03-28'),
(10187,'1961-05-26','Tommaso','Narwekar','F','1991-06-01'),
(10188,'1956-07-13','Christ','Muchinsky','F','1987-08-27'),
(10189,'1955-11-12','Khalid','Erva','M','1989-10-05'),
(10190,'1964-12-11','Arve','Fairtlough','F','1986-06-23'),
(10191,'1959-04-08','Zdislav','Nastansky','M','1986-04-10'),
(10192,'1960-09-16','Mohua','Falck','M','1988-06-13'),
(10193,'1960-06-29','Masaru','Cheshire','M','1991-07-28'),
(10194,'1954-01-29','Josyula','Hofmeyr','F','1989-05-15'),
(10195,'1963-11-13','Annemarie','Redmiles','M','1985-02-15'),
(10196,'1954-01-27','Marc','Hellwagner','M','1994-11-16'),
(10197,'1963-08-06','Kasidit','Krzyzanowski','F','1993-11-22'),
(10198,'1953-05-28','Pranav','Furedi','M','1985-08-31'),
(10199,'1959-04-07','Kazuhisa','Ranta','M','1997-04-29'),
(10200,'1961-12-31','Vidya','Awdeh','M','1985-10-16'),
(10201,'1956-12-15','Idoia','Kavraki','F','1986-11-22'),
(10202,'1956-01-05','Greger','Lichtner','M','1991-10-06'),
(10203,'1955-07-27','Steen','Escriba','M','1989-04-06'),
(10204,'1956-12-09','Nevio','Ritcey','F','1986-12-04'),
(10205,'1953-05-20','Mabhin','Leijenhorst','F','1993-08-23'),
(10206,'1960-09-19','Alassane','Iwayama','F','1988-04-19'),
(10207,'1955-05-28','Girolamo','Anandan','F','1992-10-11'),
(10208,'1960-01-02','Xiping','Klerer','M','1991-12-23'),
(10209,'1956-12-12','Yolla','Ellozy','F','1991-11-23'),
(10210,'1958-01-24','Yuping','Alpin','M','1994-05-10'),
(10211,'1964-08-05','Vishu','Strehl','F','1989-11-18'),
(10212,'1959-05-09','Divier','Esteva','M','1990-07-11'),
(10213,'1964-05-24','Jackson','Kakkad','M','1992-11-06'),
(10214,'1962-04-14','Tadahiko','Ciolek','M','1988-02-29'),
(10215,'1954-04-02','Xiaobin','Duclos','M','1987-10-19'),
(10216,'1958-07-16','Amstein','Ghemri','M','1987-10-30'),
(10217,'1954-07-07','Yongmin','Roison','F','1986-05-12'),
(10218,'1958-12-07','Zhenhua','Magalhaes','M','1997-01-15'),
(10219,'1952-05-02','Genta','Kolvik','M','1993-03-31'),
(10220,'1958-05-25','Kish','Fasbender','F','1992-06-25'),
(10221,'1957-01-03','Yucai','Granlund','M','1988-06-08'),
(10222,'1962-09-21','Tze','Nourani','M','1986-06-08'),
(10223,'1963-09-17','Carrsten','Schmiedel','F','1985-11-18'),
(10224,'1954-05-17','Leon','Trogemann','M','1988-01-09'),
(10225,'1957-02-13','Kellie','Chinen','F','1986-06-19'),
(10226,'1964-12-28','Xinglin','Plessier','M','1989-10-27'),
(10227,'1957-07-04','Anneli','Kaiser','M','1994-04-24'),
(10228,'1953-04-21','Karoline','Cesareni','F','1991-08-26'),
(10229,'1952-02-10','Ulises','Takanami','M','1987-11-22'),
(10230,'1955-09-11','Clyde','Vernadat','M','1996-06-16'),
(10231,'1963-07-21','Shaowen','Desikan','F','1996-04-13'),
(10232,'1956-03-11','Marko','Auria','F','1992-06-04'),
(10233,'1954-04-01','Lein','Vendrig','F','1985-07-05'),
(10234,'1961-01-18','Arunachalam','Bakhtari','M','1990-11-19'),
(10235,'1958-03-27','Susanta','Roccetti','F','1995-04-06'),
(10236,'1960-03-26','Susumu','Bade','F','1996-08-30'),
(10237,'1952-09-22','Yannis','Mandell','F','1989-08-11'),
(10238,'1964-11-02','Mototsugu','Gire','F','1986-11-19'),
(10239,'1955-03-31','Nikolaos','Llado','F','1995-05-08'),
(10240,'1952-04-01','Remko','Maccarone','M','1998-10-06'),
(10241,'1958-07-01','Ortrud','Murillo','M','1988-06-12'),
(10242,'1964-02-22','Lunjin','Ozeri','M','1988-01-18'),
(10243,'1960-12-22','Wonhee','Pouyioutas','M','1985-11-24'),
(10244,'1961-10-24','Foong','Flasterstein','M','1985-12-23'),
(10245,'1962-08-23','Ramalingam','Gente','F','1985-04-26'),
(10246,'1962-06-23','Basem','Teitelbaum','M','1987-07-12'),
(10247,'1964-06-30','Heon','Riefers','F','1992-08-14'),
(10248,'1955-09-24','Frederique','Tempesti','F','1991-08-13'),
(10249,'1954-06-10','Marie','Boreale','M','1991-12-08'),
(10250,'1958-08-12','Serap','Etalle','M','1992-08-30'),
(10251,'1957-04-25','Alair','Rosenbaum','M','1992-06-25'),
(10252,'1961-01-30','Shirish','Wegerle','F','1990-11-08'),
(10253,'1964-11-12','Zsolt','Salinas','F','1985-02-21'),
(10254,'1959-12-07','Shen','Brattka','M','1990-06-14'),
(10255,'1964-02-08','Roddy','Garnick','M','1993-05-12'),
(10256,'1960-12-02','Irene','Radhakrishnan','M','1985-10-12'),
(10257,'1957-09-12','Aiman','Riexinger','M','1986-08-05'),
(10258,'1955-12-12','Basil','Ishibashi','F','1985-05-17'),
(10259,'1964-11-24','Susanna','Vesel','M','1986-06-25'),
(10260,'1961-07-14','Alper','Suomi','F','1991-04-13'),
(10261,'1959-12-25','Mang','Erie','M','1993-10-20'),
(10262,'1955-08-04','Mahendra','Maraist','F','1992-07-27'),
(10263,'1961-02-08','Takahiro','Waterhouse','M','1994-02-05'),
(10264,'1958-09-08','Nalini','Kawashimo','F','1997-07-16'),
(10265,'1960-12-01','Ramalingam','Muniz','M','1989-07-13'),
(10266,'1958-02-24','Sukumar','Rassart','M','1990-05-25'),
(10267,'1956-01-16','Shaunak','Cullers','M','1996-12-11'),
(10268,'1958-06-03','Nishit','Siochi','M','1986-12-17'),
(10269,'1959-10-07','Taizo','Oxman','F','1988-07-24'),
(10270,'1963-01-30','Bedir','Hartvigsen','F','1990-04-26'),
(10271,'1962-04-24','Sham','Eastman','M','1986-05-23'),
(10272,'1954-11-30','Yishai','Cannane','M','1988-05-23'),
(10273,'1962-08-29','Baocai','Lieblein','M','1985-11-06'),
(10274,'1957-08-23','Dmitri','Pearson','F','1991-04-21'),
(10275,'1961-10-22','Marek','Luck','F','1987-09-08'),
(10276,'1964-07-27','Xuejun','Hempstead','M','1985-07-21'),
(10277,'1964-08-15','Isaac','Schwartzbauer','M','1985-06-16'),
(10278,'1955-03-09','Lubomir','Nitsch','M','1991-05-17'),
(10279,'1964-08-20','Barton','Jumpertz','F','1994-12-20'),
(10280,'1964-10-29','Stabislas','Delgrange','M','1988-03-18'),
(10281,'1953-05-13','Moty','Kusakari','M','1994-12-03'),
(10282,'1953-11-27','Hercules','Benzmuller','M','1986-06-04'),
(10283,'1953-07-08','Kauko','Birjandi','M','1988-05-25'),
(10284,'1954-04-08','Masali','Murrill','F','1997-07-02'),
(10285,'1956-09-21','Zhonghui','Preusig','F','1995-02-27'),
(10286,'1952-05-14','Saddek','Gopalakrishnan','F','1988-03-21'),
(10287,'1963-11-28','Marie','Pietracaprina','M','1992-12-28'),
(10288,'1959-06-02','Selwyn','Perri','M','1994-08-29'),
(10289,'1956-11-30','Shay','Poulakidas','M','1990-06-06'),
(10290,'1957-05-29','Yongmao','Pleszkun','M','1991-09-18'),
(10291,'1965-01-23','Dipayan','Seghrouchni','M','1986-09-29'),
(10292,'1963-01-27','Yucel','Ghelli','F','1989-06-05'),
(10293,'1956-11-24','Mihalis','Avouris','F','1992-12-12'),
(10294,'1955-01-05','Rutger','Miara','M','1996-04-08'),
(10295,'1953-01-13','Kristine','Velardi','M','1990-08-27'),
(10296,'1964-05-13','Petter','Lorho','M','1989-09-16'),
(10297,'1956-06-17','Narain','Oaver','F','1986-05-28'),
(10298,'1954-07-06','Dietrich','DuCasse','F','1999-03-30'),
(10299,'1960-06-21','Ipke','Stentiford','F','1990-01-10'),
(10300,'1960-07-12','Tadahiko','Ulupinar','F','1991-05-17'),
(10301,'1962-08-26','Lucien','Staudhammer','M','1988-05-23'),
(10302,'1954-10-11','Faiza','Baer','F','1986-07-22'),
(10303,'1961-09-11','Marlo','Zschoche','M','1990-02-05'),
(10304,'1956-03-07','Bernt','Erie','M','1992-11-16'),
(10305,'1952-06-30','Hirochika','Piancastelli','M','1988-10-31'),
(10306,'1953-06-02','Heng','Kilgour','M','1993-09-06'),
(10307,'1955-07-20','Nikolaos','Leaver','M','1991-04-10'),
(10308,'1961-03-14','Dzung','Holburn','F','1992-12-29'),
(10309,'1964-11-06','Prodip','Schusler','F','1985-06-20'),
(10310,'1964-08-29','Aksel','Alencar','M','1990-10-24'),
(10311,'1958-11-24','Hsiangchu','Molenkamp','F','1991-04-01'),
(10312,'1957-06-18','Rasiah','Deyuan','F','1986-08-28'),
(10313,'1962-05-30','Subbu','Riexinger','M','1994-10-10'),
(10314,'1961-05-04','Christfried','Apsitis','M','1986-01-16'),
(10315,'1956-08-03','Maris','Angelopoulos','M','1987-08-28'),
(10316,'1958-06-20','Christoper','Schwaller','M','1987-09-04'),
(10317,'1957-12-25','Arie','Birge','M','1986-12-10'),
(10318,'1958-08-27','Mototsugu','Beilner','F','1985-06-29'),
(10319,'1963-03-09','Mechthild','Miyakawa','M','1985-08-15'),
(10320,'1956-06-22','Uinam','Stasinski','F','1988-11-03'),
(10321,'1955-12-12','Guenter','Ravishankar','M','1991-09-24'),
(10322,'1954-05-28','Isamu','Dahlbom','F','1990-01-29'),
(10323,'1958-06-20','Kankanahalli','Hinsberger','M','1991-06-06'),
(10324,'1957-12-29','Bernardo','Rouquie','F','1988-03-19'),
(10325,'1953-01-12','Arunachalam','Badr','M','1990-09-20'),
(10326,'1953-02-13','Masali','Czap','F','1985-05-13'),
(10327,'1954-04-01','Roded','Facello','M','1987-09-18'),
(10328,'1955-06-28','Serenella','Kawashima','M','1994-01-16'),
(10329,'1958-04-28','Remko','Shigei','F','1986-01-20'),
(10330,'1957-02-02','Kasturi','Bellmore','M','1985-06-12'),
(10331,'1961-08-12','Arto','Binkley','M','1985-04-06'),
(10332,'1961-11-05','Masanao','Bain','F','1988-06-08'),
(10333,'1953-04-27','Snehasis','Dymetman','M','1993-01-16'),
(10334,'1958-04-02','Falguni','Erie','M','1996-12-28'),
(10335,'1963-03-13','Toshimori','Bahi','F','1992-04-06'),
(10336,'1961-07-16','Goa','Rothe','F','1992-01-07'),
(10337,'1957-12-10','Jeong','Sadowsky','M','1995-08-06'),
