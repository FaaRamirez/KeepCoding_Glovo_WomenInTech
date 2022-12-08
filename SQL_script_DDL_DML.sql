-- Create schema
create schema fatima_ramirez_simon authorization vhcgvvrk;



-------- DDL --------


-- CURRENCY
create table fatima_ramirez_simon.currency(
	id_currency varchar(3) not null, --PK
	name varchar(25) not null
);

alter table fatima_ramirez_simon.currency
add constraint id_currency_PK primary key (id_currency);



-- PAYMENT_METHOD
create table fatima_ramirez_simon.payment_method(
	id_pymethod varchar(2) not null, --PK
	name varchar(25) not null,
	description varchar(200) null
);

alter table fatima_ramirez_simon.payment_method
add constraint id_pymethod_PK primary key (id_pymethod);



-- ORDERS
create table fatima_ramirez_simon.orders(
	id_order varchar(15) not null, --PK
	date_order date not null,
	id_pymethod varchar(2) not null, --FK
	observations varchar(200) null
);

alter table fatima_ramirez_simon.orders
add constraint id_order_PK primary key (id_order);

alter table fatima_ramirez_simon.orders
add constraint orders_id_pymethod_FK foreign key (id_pymethod)
references fatima_ramirez_simon.payment_method;




-- AUTOMOTIVE GROUP
create table fatima_ramirez_simon.automotive_group(
	id_group varchar(5) not null, --PK
	name varchar(50) not null,
	year_foundation int not null,
	headquarter varchar(20) not null
);

alter table fatima_ramirez_simon.automotive_group
add constraint id_group_PK primary key (id_group);



-- BRAND
create table fatima_ramirez_simon.brand(
	id_brand varchar(5) not null, --PK
	name varchar(20) not null,
	id_group varchar(5) not null --FK
);

alter table fatima_ramirez_simon.brand
add constraint id_brand_PK primary key (id_brand);

alter table fatima_ramirez_simon.brand
add constraint marcas_id_group_FK foreign key (id_group)
references fatima_ramirez_simon.automotive_group;



-- COLOURS
create table fatima_ramirez_simon.colours(
	id_colour varchar(5) not null, --PK
	name varchar(25) not null
);

alter table fatima_ramirez_simon.colours
add constraint id_colour_PK primary key (id_colour);



-- CARS
create table fatima_ramirez_simon.cars(
	number_plate varchar(10) not null, -- PK
	id_brand varchar(5) not null, --FK
	model varchar(50) not null,
	id_colour varchar(5) not null, --FK
	hp_engine int not null,
	seats int not null,
	year_manufacturing int not null,
	id_order varchar(15) not null, --FK
	price numeric(12,5) not null,
	id_currency varchar(2) not null --FK
);

alter table fatima_ramirez_simon.cars
add constraint number_plate_PK primary key (number_plate);

alter table fatima_ramirez_simon.cars
add constraint cars_id_brand_FK foreign key (id_brand)
references fatima_ramirez_simon.brand;

alter table fatima_ramirez_simon.cars
add constraint cars_id_colour_FK foreign key (id_colour)
references fatima_ramirez_simon.colours;

alter table fatima_ramirez_simon.cars
add constraint cars_id_order_FK foreign key (id_order)
references fatima_ramirez_simon.orders;

alter table fatima_ramirez_simon.cars
add constraint cars_id_currency_FK foreign key (id_currency)
references fatima_ramirez_simon.currency;



-- RESULT_INSPECTION
create table fatima_ramirez_simon.result_inspection(
	id_result varchar(2) not null,
	name varchar (25) not null
);

alter table fatima_ramirez_simon.result_inspection
add constraint id_result_PK primary key (id_result);



-- INSPECTIONS
create table fatima_ramirez_simon.inspections(
	id_inspection varchar(5) not null, --PK
	number_plate varchar(10) not null, --FK
	date_inspection date not null default '4000-01-01',
	km_total int not null,
	id_result varchar(2) not null, --FK
	price numeric(12,5) not null,
	id_currency varchar(3) not null, --FK
	observations varchar(500) null
);

alter table fatima_ramirez_simon.inspections
add constraint id_inspection_PK primary key (id_inspection);

alter table fatima_ramirez_simon.inspections
add constraint inspections_number_plate_FK foreign key (number_plate)
references fatima_ramirez_simon.cars;

alter table fatima_ramirez_simon.inspections
add constraint inspections_id_result_FK foreign key (id_result)
references fatima_ramirez_simon.result_inspection;

alter table fatima_ramirez_simon.inspections
add constraint inspections_id_currency_FK foreign key (id_currency)
references fatima_ramirez_simon.currency;



-- INSURANCE
create table fatima_ramirez_simon.insurance(
	id_insurance varchar(5) not null, --PK
	name varchar(20) not null,
	address varchar(250) not null,
	city varchar(50) not null,
	telephone varchar(20) not null,
	email varchar(255) not null
);

alter table fatima_ramirez_simon.insurance
add constraint id_insurance_PK primary key (id_insurance);



-- TYPE_INSURANCE
create table fatima_ramirez_simon.type_insurance(
	id_type_insurance varchar(3) not null, --FK
	name varchar(250) not null
);

alter table fatima_ramirez_simon.type_insurance
add constraint id_type_insurance_PK primary key (id_type_insurance);



-- POLICY_CAR
create table fatima_ramirez_simon.policy_car(
	id_policy varchar(15) not null, --PK
	id_insurance varchar(5) not null, --FK
	number_plate varchar(10) not null, --FK
	start_date date not null default '4000-01-01',
	renovation_date date not null default '4000-01-01',
	end_date date not null default '4000-01-01',
	id_type_insurance varchar(3) not null, --FK
	observations varchar(250) null,
	anual_price numeric(12,5) not null,
	id_currency varchar(3) -- FK
);

alter table fatima_ramirez_simon.policy_car
add constraint id_policy_PK primary key (id_policy);

alter table fatima_ramirez_simon.policy_car
add constraint policy_id_insurance_FK foreign key (id_insurance)
references fatima_ramirez_simon.insurance;

alter table fatima_ramirez_simon.policy_car
add constraint policy_number_plate_FK foreign key (number_plate)
references fatima_ramirez_simon.cars;

alter table fatima_ramirez_simon.policy_car
add constraint policy_id_type_insurance_FK foreign key (id_type_insurance)
references fatima_ramirez_simon.type_insurance;

alter table fatima_ramirez_simon.policy_car
add constraint policy_id_currency_FK foreign key (id_currency)
references fatima_ramirez_simon.currency;





-------- DML --------

-- CURRENCY
insert into fatima_ramirez_simon.currency (id_currency, name) values('01','EUR');
insert into fatima_ramirez_simon.currency (id_currency, name) values('02','DOLLAR');
insert into fatima_ramirez_simon.currency (id_currency, name) values('03','POUND');


-- PAYMENT_METHOD
insert into fatima_ramirez_simon.payment_method (id_pymethod, name, description) values('01','cash','');
insert into fatima_ramirez_simon.payment_method (id_pymethod, name, description) values('02','credit card','');
insert into fatima_ramirez_simon.payment_method (id_pymethod, name, description) values('03','cheque','');
insert into fatima_ramirez_simon.payment_method (id_pymethod, name, description) values('04','bank transfer','');



-- ORDERS
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('00356','2019-11-05','03','');
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('00875','2022-07-02','04','');
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('00355','2021-10-16','04','');
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('00487','2018-04-04','04','Pending to complete payment');
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('00264','2015-12-14','03','');
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('01657','2022-01-26','03','');
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('01655','2022-08-25','03','');
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('14401','2022-02-28','04','');
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('04356','2022-07-29','04','');
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('01777','2022-10-31','03','Pending to complete payment');
insert into fatima_ramirez_simon.orders (id_order, date_order, id_pymethod, observations) values('01901','2020-01-12','03','');



-- AUTOMOTIVE GROUP
insert into fatima_ramirez_simon.automotive_group (id_group, name, year_foundation, headquarter) values('01','VAG','1937','Germany');
insert into fatima_ramirez_simon.automotive_group (id_group, name, year_foundation, headquarter) values('02','Renault Nissan','1933','Japan');
insert into fatima_ramirez_simon.automotive_group (id_group, name, year_foundation, headquarter) values('03','BMW Group','1916','Germany');


-- BRAND
insert into fatima_ramirez_simon.brand (id_brand, name, id_group) values('01','Audi','01');
insert into fatima_ramirez_simon.brand (id_brand, name, id_group) values('02','SEAT','01');
insert into fatima_ramirez_simon.brand (id_brand, name, id_group) values('03','Volkswagen','01');
insert into fatima_ramirez_simon.brand (id_brand, name, id_group) values('04','Renault','02');
insert into fatima_ramirez_simon.brand (id_brand, name, id_group) values('05','Nissan','02');
insert into fatima_ramirez_simon.brand (id_brand, name, id_group) values('06','Dacia','02');
insert into fatima_ramirez_simon.brand (id_brand, name, id_group) values('07','Mini','03');
insert into fatima_ramirez_simon.brand (id_brand, name, id_group) values('08','BMW','03');


-- COLOURS
insert into fatima_ramirez_simon.colours (id_colour, name) values('01','black');
insert into fatima_ramirez_simon.colours (id_colour, name) values('02','blue');
insert into fatima_ramirez_simon.colours (id_colour, name) values('03','brown');
insert into fatima_ramirez_simon.colours (id_colour, name) values('04','grey');
insert into fatima_ramirez_simon.colours (id_colour, name) values('05','green');
insert into fatima_ramirez_simon.colours (id_colour, name) values('06','orange');
insert into fatima_ramirez_simon.colours (id_colour, name) values('07','pink');
insert into fatima_ramirez_simon.colours (id_colour, name) values('08','purple');
insert into fatima_ramirez_simon.colours (id_colour, name) values('09','red');
insert into fatima_ramirez_simon.colours (id_colour, name) values('10','white');
insert into fatima_ramirez_simon.colours (id_colour, name) values('11','yellow');


-- CARS
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('4861 BCC','01','Q3','02','245','5','2021','01655','55240','01');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('7863 IGL','01','A1','11','150','5','2022','04356','38560','01');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('9003 PCS','04','Clio','09','140','5','2022','00875','22060','02');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('7683 LWE','06','Sandero','06','90','5','2021','00355','14570','02');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('1565 EST','06','Duster','04','150','7','2022','01777','22850','01');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('1350 GJB','08','X7','04','530','7','2022','01777','104982','01');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('3863 DDA','02','Leon','11','110','5','2022','01657','26450','01');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('8504 AXP','02','Ateca','09','190','7','2022','01655','31180','01');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('3567 LNM','05','370Z','01','328','2','2018','00487','45430','01');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('0032 MSA','03','T-Cross','10','150','5','2020','01901','24950','02');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('6548 RRO','07','Roadster','10','184','2','2015','00264','32360','02');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('4689 FRS','07','Cooper','11','231','5','2022','00875','31500','01');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('3134 VLT','03','Polo','02','207','5','2022','14401','20550','01');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('0078 ALM','04','Megane','06','300','5','2022','01777','33282','01');
insert into fatima_ramirez_simon.cars (number_plate, id_brand, model, id_colour, hp_engine, seats, year_manufacturing, id_order, price, id_currency) values('8004 LLS','02','Ibiza','09','150','5','2019','00356','18040','01');


-- RESULT_INSPECTION
insert into fatima_ramirez_simon.result_inspection (id_result, name) values('01','positive');
insert into fatima_ramirez_simon.result_inspection (id_result, name) values('02','negative');


-- INSPECTIONS
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0000','6548 RRO','2016-08-11','3126','01','39.58','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0001','6548 RRO','2017-04-17','6544','01','40.62','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0002','3567 LNM','2018-12-03','4578','01','40.62','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0003','6548 RRO','2018-01-22','9456','01','40.62','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0004','6548 RRO','2019-02-06','12465','01','43.36','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0005','3567 LNM','2019-10-11','14578','01','43.36','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0006','8004 LLS','2019-12-12','8565','01','43.36','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0007','6548 RRO','2020-03-16','18546','01','45.59','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0008','3567 LNM','2020-03-28','21587','01','45.59','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0009','0032 MSA','2020-12-12','5486','01','45.59','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0010','8004 LLS','2020-11-17','17534','01','45.59','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0011','7683 LWE','2021-12-28','6555','01','46.15','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0012','6548 RRO','2021-12-21','21546','01','46.15','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0013','0032 MSA','2021-11-30','10578','01','45.15','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0014','3567 LNM','2021-11-21','26878','01','45.15','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0015','8004 LLS','2021-11-22','22369','01','45.15','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0016','3863 DDA','2022-11-26','6955','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0017','3134 VLT','2022-12-01','7004','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0018','4689 FRS','2022-12-10','8447','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0019','9003 PCS','2022-12-11','4569','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0020','7863 IGL','2022-12-11','6002','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0021','4861 BCC','2022-12-15','5966','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0022','8504 AXP','2022-12-15','4112','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0023','1565 EST','2022-12-18','5213','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0024','1350 GJB','2022-12-19','3821','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0025','0078 ALM','2022-12-19','1432','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0026','6548 RRO','2022-12-19','25548','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0027','3567 LNM','2022-12-21','32548','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0028','8004 LLS','2022-12-22','26589','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0029','0032 MSA','2022-12-23','13699','01','54.98','01','');
insert into fatima_ramirez_simon.inspections (id_inspection, number_plate, date_inspection, km_total, id_result, price, id_currency, observations) values('0030','7683 LWE','2022-12-23','14568','01','54.98','01','');


-- INSURANCE
insert into fatima_ramirez_simon.insurance (id_insurance, name, address, city, telephone, email) values('01','Mapfre','Juan Duque 12','Madrid','912 02 02 22','customerservice@mapfre01.com');
insert into fatima_ramirez_simon.insurance (id_insurance, name, address, city, telephone, email) values('02','AXA','Concepcion Jeronima 215','Madrid','912 78 66 66','customerservice@axa01.com');
insert into fatima_ramirez_simon.insurance (id_insurance, name, address, city, telephone, email) values('03','Allianz','Ronda Segovia 68','Madrid','912 00 00 01','customerservice@allianz01.com');
insert into fatima_ramirez_simon.insurance (id_insurance, name, address, city, telephone, email) values('04','Linea Directa','Paseo de los Melancolicos 188','Madrid','912 23 23 41','customerservice@lineadirecta.com');


-- TYPE_INSURANCE
insert into fatima_ramirez_simon.type_insurance (id_type_insurance, name) values('01','Third party');
insert into fatima_ramirez_simon.type_insurance (id_type_insurance, name) values('02','Third party, fire and theft');
insert into fatima_ramirez_simon.type_insurance (id_type_insurance, name) values('03','Fully comprehensive');


-- POLICY
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00455','01','4861 BCC','2022-08-27','4000-01-01','4000-01-01','03','','460','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00785','01','7863 IGL','2022-07-31','4000-01-01','4000-01-01','03','','336','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00356','04','9003 PCS','2022-07-08','4000-01-01','4000-01-01','01','','210','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00154','02','7683 LWE','2021-10-22','4000-01-01','4000-01-01','02','','266','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00156','03','1565 EST','2022-11-03','4000-01-01','4000-01-01','01','','199','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00789','01','1350 GJB','2022-11-03','4000-01-01','4000-01-01','03','','520','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00343','03','3863 DDA','2022-01-29','4000-01-01','4000-01-01','01','','200','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00012','04','8504 AXP','2022-08-30','4000-01-01','4000-01-01','01','','199','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00231','01','3567 LNM','2018-04-09','4000-01-01','4000-01-01','03','','430','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00744','04','0032 MSA','2020-01-19','4000-01-01','4000-01-01','03','','416','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00122','02','6548 RRO','2015-12-16','4000-01-01','4000-01-01','01','','350','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00363','01','4689 FRS','2022-07-07','4000-01-01','4000-01-01','02','','325','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00221','01','3134 VLT','2022-03-02','4000-01-01','4000-01-01','02','','340','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00113','01','0078 ALM','2022-11-03','4000-01-01','4000-01-01','02','','279','01');
insert into fatima_ramirez_simon.policy_car (id_policy, id_insurance, number_plate, start_date, renovation_date, end_date, id_type_insurance, observations, anual_price, id_currency) values('00422','02','8004 LLS','2019-11-06','4000-01-01','4000-01-01','01','','210','01');

