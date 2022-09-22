SET SERVEROUTPUT ON;

-- To drop tables, if existing
DECLARE
  tname varchar2(50);
BEGIN
  select table_name into tname from user_tables where table_name='SELLER_ARCHIVE';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='ITEM_CART';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='ITEM';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='SHIPMENT';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='PAYMENT';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='ORDERR';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='CART';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='SELLER';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='CUSTOMERR';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='SHIPPER';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='CATEGORYY';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='REUSABLE_ITEM';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='ADDRESS';
  execute immediate 'drop table '||tname;
  select table_name into tname from user_tables where table_name='ADDRESS_ZIP';
  execute immediate 'drop table '||tname;
EXCEPTION 
  when no_data_found then
   dbms_output.put_line('The tables do not exist, create one');
END;
/

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

--CREATING AND INSERTING statements
CREATE TABLE ADDRESS_ZIP(
    AREA_CODE INT NOT NULL PRIMARY KEY,
    CITY VARCHAR(25) NOT NULL,
    STATEE VARCHAR(25) NOT NULL,
    COUNTRY VARCHAR(25) NOT NULL
);

CREATE TABLE ADDRESS(
   ADDRESS_ID INT NOT NULL PRIMARY KEY,
   ADDRESS_LINE1 VARCHAR (100) NOT NULL,
   ADDRESS_LINE2 VARCHAR (100),
   AREA_CODE INT NOT NULL,
   FOREIGN KEY(AREA_CODE) REFERENCES ADDRESS_ZIP(AREA_CODE)
);

CREATE TABLE REUSABLE_ITEM(
    R_ID INT NOT NULL PRIMARY KEY,
    NO_OF_TIMES_USED INT NOT NULL,
    I_DESCRIPTION VARCHAR(250)
);

CREATE TABLE CATEGORYY(
    CATEGORY_ID INT NOT NULL PRIMARY KEY,
    CATEGORY_NAME VARCHAR(50) NOT NULL
);

CREATE TABLE SHIPPER(
    SHIPPER_ID INT NOT NULL PRIMARY KEY,
    SH_NAME VARCHAR(50) NOT NULL,
    CONTACT_NUM INT NOT NULL
);

CREATE TABLE CUSTOMERR(
   C_ID INT NOT NULL PRIMARY KEY,
   C_NAME VARCHAR (50) NOT NULL,
   C_USERNAME VARCHAR (20) NOT NULL,
   C_PASSWORD VARCHAR (20) NOT NULL,
   DATE_OF_BIRTH DATE,
   C_PHONE INT NOT NULL,
   C_EMAIL VARCHAR(25) NOT NULL,
   ADDRESS_ID INT,
   FOREIGN KEY(ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

CREATE TABLE SELLER(
   S_ID INT NOT NULL PRIMARY KEY,
   S_NAME VARCHAR (50) NOT NULL,
   S_USERNAME VARCHAR (20) NOT NULL,
   S_PASSWORD VARCHAR (20) NOT NULL,
   S_PHONE INT NOT NULL,
   S_EMAIL VARCHAR(25) NOT NULL,
   ADDRESS_ID INT,
   FOREIGN KEY(ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

CREATE TABLE CART(
    CART_ID INT NOT NULL PRIMARY KEY,
    NO_OF_ITEMS INT NOT NULL,
    TOTAL_COST INT NOT NULL
);

CREATE TABLE ORDERR(
    ORDER_ID INT NOT NULL PRIMARY KEY,
    ORDER_DATE DATE NOT NULL, 
    C_ID INT NOT NULL,
    FOREIGN KEY(C_ID) REFERENCES CUSTOMERR(C_ID),
    CART_ID INT NOT NULL,
    FOREIGN KEY(CART_ID) REFERENCES CART(CART_ID)
);

CREATE TABLE PAYMENT(
    PAYMENT_ID INT NOT NULL PRIMARY KEY,
    AMOUNT INT NOT NULL,
    PAYMENT_MODE VARCHAR(20) NOT NULL,
    PAYMENT_DATE DATE NOT NULL,
    ORDER_ID INT NOT NULL,
    FOREIGN KEY(ORDER_ID) REFERENCES ORDERR(ORDER_ID)
);

CREATE TABLE SHIPMENT(
    SHIPMENT_ID INT NOT NULL PRIMARY KEY,
    SHIPMENT_DATE DATE NOT NULL,
    DELIVERY_STATUS VARCHAR(20) NOT NULL,
    ADDRESS_ID INT,
    FOREIGN KEY(ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID),
    SHIPPER_ID INT,
    FOREIGN KEY(SHIPPER_ID) REFERENCES SHIPPER(SHIPPER_ID),
    PAYMENT_ID INT,
    FOREIGN KEY(PAYMENT_ID) REFERENCES PAYMENT(PAYMENT_ID)
);

CREATE TABLE ITEM(
    ITEM_ID INT NOT NULL PRIMARY KEY,
    ITEM_NAME VARCHAR(25) NOT NULL,
    PRICE INT NOT NULL,
    S_ID INT NOT NULL, 
    FOREIGN KEY(S_ID) REFERENCES SELLER(S_ID),
    R_ID INT,
    FOREIGN KEY(R_ID) REFERENCES REUSABLE_ITEM(R_ID),
    CATEGORY_ID INT NOT NULL, 
    FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORYY(CATEGORY_ID),
    C_ID INT,
    FOREIGN KEY(C_ID) REFERENCES CUSTOMERR(C_ID)
);

CREATE TABLE ITEM_CART(
    ITEM_ID INT NOT NULL,
    CART_ID INT NOT NULL,
    PRIMARY KEY(ITEM_ID, CART_ID),
    FOREIGN KEY(ITEM_ID) REFERENCES ITEM(ITEM_ID),
    FOREIGN KEY(CART_ID) REFERENCES CART(CART_ID)
);

CREATE TABLE SELLER_ARCHIVE(
   S_ID INT NOT NULL,
   S_NAME VARCHAR (50) NOT NULL,
   S_USERNAME VARCHAR (20) NOT NULL,
   S_PASSWORD VARCHAR (20) NOT NULL,
   S_PHONE INT NOT NULL,
   S_EMAIL VARCHAR(25) NOT NULL,
   ADDRESS_ID INT,
   FOREIGN KEY(ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

--Inserting data

INSERT INTO ADDRESS_ZIP VALUES(580023, 'BANGALORE', 'KARNATAKA', 'INDIA');
INSERT INTO ADDRESS_ZIP VALUES(02120, 'BOSTON', 'MASSACHUSETTS', 'USA');
INSERT INTO ADDRESS_ZIP VALUES(02125, 'BOSTON', 'MASSACHUSETTS', 'USA');
INSERT INTO ADDRESS_ZIP VALUES(10002, 'MUMBAI', 'MAHARASHTRA', 'INDIA');
INSERT INTO ADDRESS_ZIP VALUES(90201, 'LOS ANGELES', 'CALIFORNIA', 'USA');
INSERT INTO ADDRESS_ZIP VALUES(06700, 'CHENNAI', 'TAMIL NADU', 'INDIA');
INSERT INTO ADDRESS_ZIP VALUES(98109, 'SEATTLE', 'WASHINGTON', 'USA');
INSERT INTO ADDRESS_ZIP VALUES(411002, 'PUNE', 'MAHARASHTRA', 'INDIA');
INSERT INTO ADDRESS_ZIP VALUES(79808, 'KOLKATA', 'WEST BENGAL', 'INDIA');
INSERT INTO ADDRESS_ZIP VALUES(50014, 'GILBERT', 'ARIZONA', 'USA');
INSERT INTO ADDRESS_ZIP VALUES(70027, 'KOLKATA', 'WEST BENGAL', 'INDIA');
INSERT INTO ADDRESS_ZIP VALUES(60607, 'CHICAGO', 'IILIONIS', 'USA');
INSERT INTO ADDRESS_ZIP VALUES(73301, 'AUSTIN', 'TEXAS', 'USA');

INSERT INTO ADDRESS VALUES(1001, '45B SMITH STREET', 'ROXBURY ST', 02120);
INSERT INTO ADDRESS VALUES(1002, 'HNO 12 NEWBURY STREET', 'LONGWOOD ST', 73301);
INSERT INTO ADDRESS VALUES(1003, '24th OAK STREET', 'MASS AVENUE', 02125);
INSERT INTO ADDRESS VALUES(1004, '42nd CROSS', 'VIJAY NAGAR', 580023);
INSERT INTO ADDRESS VALUES(1005, '22D, BEACH STREET', 'BEVERLY HILLS', 90201);
INSERT INTO ADDRESS VALUES(1006, '18A, FENWAY PLAZA, 7th STREET', 'ROXBURY ST', 50014);
INSERT INTO ADDRESS VALUES(1007, 'HNO 67, VIDYA NAGAR', 'KESHWAPUR', 580023);
INSERT INTO ADDRESS VALUES(1008, '42E, PARK DRIVE', 'RODEO DRIVE', 90201);
INSERT INTO ADDRESS VALUES(1009, '2nd CUT, MASON STREET', 'ASHTON ST', 73301);
INSERT INTO ADDRESS VALUES(1010, '14F, GARDEN STREET', 'CHARCO ROAD', 50014);
INSERT INTO ADDRESS VALUES(1011, 'PLOT NO 2, 9th CROSS', 'CAMAC STREET', 70027);
INSERT INTO ADDRESS VALUES(1012, 'APT 1301, BRIGADE', 'BRIGADE GATEWAY', 580023);
INSERT INTO ADDRESS VALUES(1013, 'HNO 34', 'MINT STREET', 06700);
INSERT INTO ADDRESS VALUES(1014, '21A, NEAR BOXBON', 'PINE STREET', 98109);
INSERT INTO ADDRESS VALUES(1015, '12D, LONGWOOD', 'LECHEMERE', 02125);
INSERT INTO ADDRESS VALUES(1016, 'APT NO 17, SHANTI APARTMENT', 'MG ROAD', 411002);
INSERT INTO ADDRESS VALUES(1017, '180D, SOLICITE ROAD', 'DENNY WAY', 98109);
INSERT INTO ADDRESS VALUES(1018, '46L LONGWOOD', 'SYMPONY', 02125);
INSERT INTO ADDRESS VALUES(1019, '56B, DEART APARTMENT', 'ALIZO DR', 50014);
INSERT INTO ADDRESS VALUES(1020, 'HNO 72, 5th CROSS', 'TRIPOTO STREET', 06700);

INSERT INTO REUSABLE_ITEM VALUES (2001, 2, 'Has been used only twice');
INSERT INTO REUSABLE_ITEM VALUES (2002, 1, 'A heel you can walk in all day');
INSERT INTO REUSABLE_ITEM VALUES (2003, 2, 'Built with burliest fabric package');
INSERT INTO REUSABLE_ITEM VALUES (2004, 4, 'Sustainable forest woods are used for the frames.');
INSERT INTO REUSABLE_ITEM VALUES (2005, 3, 'No assembly required');
INSERT INTO REUSABLE_ITEM VALUES (2006, 5, 'Crafted from metal, its geometric frame features an openwork design topped off by hardware.');
INSERT INTO REUSABLE_ITEM VALUES (2007, 2, 'Complete storm protection');
INSERT INTO REUSABLE_ITEM VALUES (2008, 2, 'Greet guests with a warm and welcoming glow while you grab their glances with this pendent hanging overhead.');
INSERT INTO REUSABLE_ITEM VALUES (2009, 1, 'With the proper ingredients, success comes naturally. Here is everything you need to make a distinctive tasting sausage stick that will be sure to tingle your taste buds.');
INSERT INTO REUSABLE_ITEM VALUES (2010, 1, 'Open your door to the world of grilling with the sleek Spirit II E-210 gas grill. This two burner grill is built to fit small spaces, and packed with features such as the powerful GS4 grilling system');
INSERT INTO REUSABLE_ITEM VALUES (2011, 3, 'Beautifully handmade laptop case/sleeve made in the Nepal Himalaya');
INSERT INTO REUSABLE_ITEM VALUES (2012, 5, 'Designed and measured to fit a 12 to 14 laptops and with a convenient front pocket for your charger cable and notebook.');
INSERT INTO REUSABLE_ITEM VALUES (2013, 2, 'Includes roll-top, 2 front zipper pockets, and 2 zippered side pockets  Endor Commando Alliance Special Forces patch is prominently featured on the front');
INSERT INTO REUSABLE_ITEM VALUES (2014, 4, 'Genuine hand-seven construction for durable comfort.');
INSERT INTO REUSABLE_ITEM VALUES (2015, 4, 'Lightweight and Easy to Move');
INSERT INTO REUSABLE_ITEM VALUES (2016, 3, 'Made of 100 percent cotton for a comfortable. ');
INSERT INTO REUSABLE_ITEM VALUES (2017, 1, 'Remove dirt and impurities from your sensitive skin with our all-natural cleansing bar.');
INSERT INTO REUSABLE_ITEM VALUES (2018, 4, 'Officially-licensed Star Wars merchandise.');
INSERT INTO REUSABLE_ITEM VALUES (2019, 3, 'New version');
INSERT INTO REUSABLE_ITEM VALUES (2020, 3, 'Room air purifier removes 99%+ of Airborne Particles. Best for Bedroom, Office, Living Room, Basement');

INSERT INTO CATEGORYY VALUES(3001, 'FURNITURE');
INSERT INTO CATEGORYY VALUES(3002, 'CLOTH');
INSERT INTO CATEGORYY VALUES(3003, 'FOOTWEAR');
INSERT INTO CATEGORYY VALUES(3004, 'ELECTRONICS');
INSERT INTO CATEGORYY VALUES(3005, 'STATIONARY');
INSERT INTO CATEGORYY VALUES(3006, 'COSMETICS');
INSERT INTO CATEGORYY VALUES(3007, 'OTHERS');

INSERT INTO SHIPPER VALUES(4001, 'JOHN', 6728638657);
INSERT INTO SHIPPER VALUES(4002, 'DAVID', 8768689990);
INSERT INTO SHIPPER VALUES(4003, 'RAM', 7723409876);
INSERT INTO SHIPPER VALUES(4004, 'JULIE', 7700098000);
INSERT INTO SHIPPER VALUES(4005, 'DANIEL', 9899956665);
INSERT INTO SHIPPER VALUES(4006, 'STEPHEN', 7722123443);
INSERT INTO SHIPPER VALUES(4007, 'EMILY', 8556012685);
INSERT INTO SHIPPER VALUES(4008, 'MILEY', 6777540011);
INSERT INTO SHIPPER VALUES(4009, 'MIKE', 8112345656);
INSERT INTO SHIPPER VALUES(4010, 'LISA', 9113789765);
INSERT INTO SHIPPER VALUES(4011, 'JAMES', 9904456543);

INSERT INTO CUSTOMERR VALUES(5001, 'Siya', 'Siya27', 'Siya@2705', '27-MAY-2000', 86766786788, 'siya27@gmail.com', 1015);
INSERT INTO CUSTOMERR VALUES(5002, 'Mathew', 'Mathew_Fred', 'Mathew#Fred', '21-APR-1997', 7688099087, 'freddy@gmail.com', 1011);
INSERT INTO CUSTOMERR VALUES(5003, 'Rahul', 'Rahul112', '11@Rahul', '11-JAN-1998', 6122219009, 'rahul11@gmail.com', 1004);
INSERT INTO CUSTOMERR VALUES(5004, 'Jenny', 'JennyIKnow', 'Jenny@1234', '27-OCT-1995', 8883222098, 'jenny1234@gmail.com', 1016);
INSERT INTO CUSTOMERR VALUES(5005, 'Steve', 'Stevyy', '1@Stevey', '01-JUL-1999', 9990128410, 'steve1@yahoo.com', 1019);
INSERT INTO CUSTOMERR VALUES(5006, 'Priya', 'Ipriya', 'Priya#92002', '09-NOV-2002', 9384645372, 'priya92@gmail.com', 1005);
INSERT INTO CUSTOMERR VALUES(5007, 'Katy', 'ItsKaty', 'Katy@999', '17-SEP-1999', 87101012002, 'katy999@gmail.com', 1001);
INSERT INTO CUSTOMERR VALUES(5008, 'Ashish', '798Ashish', 'Ash#6789', '07-FEB-1998', 6002304010, 'ash789@yahoo.com', 1003);
INSERT INTO CUSTOMERR VALUES(5009, 'Karan', 'MeKaran', 'Karan1234#', '12-MAR-2004', 8116172821, 'karan1234@gmail.com', 1009);
INSERT INTO CUSTOMERR VALUES(5010, 'Mia', 'MiaRight', 'Mia@11111', '14-FEB-1996', 6434011282, 'mia11111@gyahoomail.com', 1007);
INSERT INTO CUSTOMERR VALUES(5011, 'John', 'Jonny', 'Jonny#56', '05-JUN-1995', 86766786788, 'jonny56@gmail.com', 1015);
INSERT INTO CUSTOMERR VALUES(5012, 'Rohit', 'RohitMeh', 'MehreRo@12', '12-JAN-1998', 8223400116, 'meh_roh@gmail.com', 1007);
INSERT INTO CUSTOMERR VALUES(5013, 'Alia', 'AliaCool', 'Alia@0398', '03-SEP-1998', 9997600216, 'alia0398@gmail.com', 1013);
INSERT INTO CUSTOMERR VALUES(5014, 'Tina', 'Tintin', 'Tintin@44', '04-APR-1996', 6800333345, 'tinaa44@yahoo.com', 1020);
INSERT INTO CUSTOMERR VALUES(5015, 'Mike', 'Mikeyboy', 'Boy$1234', '12-MAR-1994', 7556091009, 'mike1234@gmail.com', 1012);
INSERT INTO CUSTOMERR VALUES(5016, 'David', 'DavidY', 'David#123', '09-NOV-1999', 7565111342, 'david12@yahoo.com', 1008);
INSERT INTO CUSTOMERR VALUES(5017, 'Riya', 'RiyaD', 'D@Riya12', '21-AUG-2000', 8110592387, 'riyaD12@yahoo.com', 1017);
INSERT INTO CUSTOMERR VALUES(5018, 'George', 'Georegyy', 'George@1234', '24-AUG-1995', 9150384926, '1234george@gmail.com', 1002);
INSERT INTO CUSTOMERR VALUES(5019, 'Emma', 'EmmaW', 'Emma177#', '17-MAR-1996', 7003160314, 'wemma@gmail.com', 1018);
INSERT INTO CUSTOMERR VALUES(5020, 'Aman', 'Aman10', '0997@Aman', '09-OCT-1997', 8422450776, 'aman0997@gmail.com', 1010);


INSERT INTO SELLER VALUES(6001, 'Camila', 'CamilaM', 'Camila#55', 4656009000, 'camila55@gmail.com', 1001);
INSERT INTO SELLER VALUES(6002, 'Noah', 'Noah_C', 'Noah#4567', 8811312266, 'noah45@gmail.com', 1004);
INSERT INTO SELLER VALUES(6003, 'Priyanka', 'Priyanka', 'Priyanka99_#', 9944654473, 'priyanka9@yahoo.com', 1016);
INSERT INTO SELLER VALUES(6004, 'Luna', 'LunaLog', '1@Luna#0', 8112204412, 'luna10@gmail.com', 1019);
INSERT INTO SELLER VALUES(6005, 'Oliver', 'OliverPh', 'P@Oliver4', 9778117603, 'oliver4@gmail.com', 1020);
INSERT INTO SELLER VALUES(6006, 'Sejal', 'Sejal_Use', 'Sejal#88', 6660952761, 'sejal33@gmail.com', 1003);
INSERT INTO SELLER VALUES(6007, 'Thomas', 'ThomasE', 'Thomas@E15', 8160362898, 'thomas15@yahoo.com', 1012);
INSERT INTO SELLER VALUES(6008, 'Mila', 'MilaMake', 'Mila58##', 7600194879, 'mila58@gmail.com', 1005);
INSERT INTO SELLER VALUES(6009, 'Diya', 'DiyaDay', '12@Diya12', 7660009123, 'diya@yahoo.com', 1007);
INSERT INTO SELLER VALUES(6010, 'Issac', 'Issac_N', 'Issac@78', 8333045176, 'issac78@gmail.com', 1010);
INSERT INTO SELLER VALUES(6011, 'Tejas', 'Tejas_U', '1234#Tejas', 9812421890, 'tejas1234@gmail.com', 1013);

INSERT INTO CART VALUES(7001, 4, 130);
INSERT INTO CART VALUES(7002, 2, 105);
INSERT INTO CART VALUES(7003, 5, 310);
INSERT INTO CART VALUES(7004, 3, 105);
INSERT INTO CART VALUES(7005, 1, 12);
INSERT INTO CART VALUES(7006, 2, 135);
INSERT INTO CART VALUES(7007, 4, 216);
INSERT INTO CART VALUES(7008, 3, 525);
INSERT INTO CART VALUES(7009, 4, 340);
INSERT INTO CART VALUES(7010, 2, 150);
INSERT INTO CART VALUES(7011, 1, 70);
INSERT INTO CART VALUES(7012, 4, 270);
INSERT INTO CART VALUES(7013, 2, 140);
INSERT INTO CART VALUES(7014, 3, 270);
INSERT INTO CART VALUES(7015, 4, 360);
INSERT INTO CART VALUES(7016, 6, 540);
INSERT INTO CART VALUES(7017, 3, 260);
INSERT INTO CART VALUES(7018, 5, 450);
INSERT INTO CART VALUES(7019, 2, 110);
INSERT INTO CART VALUES(7020, 6, 510);

INSERT INTO ORDERR VALUES(8001, '01-JAN-2020',5001,7001);
INSERT INTO ORDERR VALUES(8002, '15-JAN-2020',5002,7002);
INSERT INTO ORDERR VALUES(8003, '14-FEB-2021',5003,7003);
INSERT INTO ORDERR VALUES(8004, '28-MAR-2020',5004,7004);
INSERT INTO ORDERR VALUES(8005, '17-APR-2020',5005,7005);
INSERT INTO ORDERR VALUES(8006, '19-MAY-2020',5006,7006);
INSERT INTO ORDERR VALUES(8007, '30-JUN-2020',5007,7007);
INSERT INTO ORDERR VALUES(8008, '26-JUL-2020',5008,7008);
INSERT INTO ORDERR VALUES(8009, '18-AUG-2020',5009,7009);
INSERT INTO ORDERR VALUES(8010, '24-SEP-2020',5010,7010);
INSERT INTO ORDERR VALUES(8011, '30-OCT-2020',5011,7011);
INSERT INTO ORDERR VALUES(8012, '02-NOV-2020',5012,7012);
INSERT INTO ORDERR VALUES(8013, '24-JAN-2021',5013,7013);
INSERT INTO ORDERR VALUES(8014, '17-FEB-2021',5014,7014);
INSERT INTO ORDERR VALUES(8015, '28-MAR-2021',5015,7015);
INSERT INTO ORDERR VALUES(8016, '16-APR-2021',5016,7016);
INSERT INTO ORDERR VALUES(8017, '12-APR-2021',5017,7017);
INSERT INTO ORDERR VALUES(8018, '13-APR-2021',5018,7018);
INSERT INTO ORDERR VALUES(8019, '15-MAR-2021',5019,7019);
INSERT INTO ORDERR VALUES(8020, '03-JAN-2021',5020,7020);

INSERT INTO PAYMENT VALUES(9001, 130, 'CREDIT', '11-DEC-2019', 8001);
INSERT INTO PAYMENT VALUES(9002, 105, 'DEBIT', '15-JAN-2020', 8002);
INSERT INTO PAYMENT VALUES(9003, 310, 'PAYPAL', '14-FEB-2021', 8003);
INSERT INTO PAYMENT VALUES(9004, 105, 'CREDIT', '28-MAR-2020', 8004);
INSERT INTO PAYMENT VALUES(9005, 12, 'PAYPAL', '17-MAR-2020', 8005);
INSERT INTO PAYMENT VALUES(9006, 135, 'CREDIT', '19-MAY-2020', 8006);
INSERT INTO PAYMENT VALUES(9007, 216, 'CREDIT', '30-JUN-2020', 8007);
INSERT INTO PAYMENT VALUES(9008, 525, 'CREDIT', '26-JUL-2020', 8008);
INSERT INTO PAYMENT VALUES(9009, 340, 'DEBIT', '18-AUG-2020', 8009);
INSERT INTO PAYMENT VALUES(9010, 150, 'CREDIT', '24-SEP-2020', 8010);
INSERT INTO PAYMENT VALUES(9011, 70, 'DEBIT', '30-OCT-2020', 8011);
INSERT INTO PAYMENT VALUES(9012, 270, 'CREDIT', '02-NOV-2020', 8012);
INSERT INTO PAYMENT VALUES(9013, 140, 'PAYPAL', '24-JAN-2021', 8013);
INSERT INTO PAYMENT VALUES(9014, 270, 'CREDIT', '17-FEB-2021', 8014);
INSERT INTO PAYMENT VALUES(9015, 360, 'CREDIT', '28-MAR-2021', 8015);
INSERT INTO PAYMENT VALUES(9016, 540, 'DEBIT', '16-APR-2021', 8016);
INSERT INTO PAYMENT VALUES(9017, 260, 'CREDIT', '12-APR-2021', 8017);
INSERT INTO PAYMENT VALUES(9018, 450, 'CREDIT', '13-APR-2021', 8018);
INSERT INTO PAYMENT VALUES(9019, 110, 'DEBIT', '15-MAR-2021', 8019);
INSERT INTO PAYMENT VALUES(9020, 510, 'PAYPAL', '03-JAN-2021', 8020);

INSERT INTO SHIPMENT VALUES(10001, '01-JAN-2020', 'DELIVERED', 1015, 4001, 9001);
INSERT INTO SHIPMENT VALUES(10002, '30-JAN-2020', 'DELIVERED', 1011, 4011, 9002);
INSERT INTO SHIPMENT VALUES(10003, '17-APR-2021', 'SHIPPING', 1004, 4002, 9003);
INSERT INTO SHIPMENT VALUES(10004, '01-MAY-2020', 'CANCELED', 1016, 4001, 9004);
INSERT INTO SHIPMENT VALUES(10005, '04-APR-2020', 'DELIVERED', 1019, 4003, 9005);
INSERT INTO SHIPMENT VALUES(10006, '30-MAY-2020', 'DELIVERED', 1005, 4004, 9006);
INSERT INTO SHIPMENT VALUES(10007, '04-JUL-2020', 'DELIVERED', 1001, 4006, 9007);
INSERT INTO SHIPMENT VALUES(10008, '30-JUL-2020', 'DELIVERED', 1003, 4005, 9008);
INSERT INTO SHIPMENT VALUES(10009, '18-SEP-2020', 'DELIVERED', 1009, 4007, 9009);
INSERT INTO SHIPMENT VALUES(10010, '30-OCT-2020', 'DELIVERED', 1007, 4002, 9010);
INSERT INTO SHIPMENT VALUES(10011, '03-NOV-2020', 'CANCELED', 1015, 4001, 9011);
INSERT INTO SHIPMENT VALUES(10012, '17-NOV-2020', 'DELIVERED', 1007, 4009, 9012);
INSERT INTO SHIPMENT VALUES(10013, '22-FEB-2021', 'DELIVERED', 1013, 4010, 9013);
INSERT INTO SHIPMENT VALUES(10014, '25-FEB-2021', 'DELIVERED', 1020, 4011, 9014);
INSERT INTO SHIPMENT VALUES(10015, '04-APR-2021', 'DELIVERED', 1012, 4003, 9015);
INSERT INTO SHIPMENT VALUES(10016, '25-APR-2021', 'SHIPPING', 1008, 4001, 9016);
INSERT INTO SHIPMENT VALUES(10017, '24-APR-2021', 'SHIPPING', 1017, 4004, 9017);
INSERT INTO SHIPMENT VALUES(10018, '25-APR-2021', 'SHIPPING', 1002, 4006, 9018);
INSERT INTO SHIPMENT VALUES(10019, '20-APR-2021', 'SHIPPING', 1018, 4005, 9019);
INSERT INTO SHIPMENT VALUES(10020, '30-JAN-2021', 'CANCELED', 1010, 4008, 9020);

INSERT INTO ITEM VALUES (11001, 'Chair', 40, 6001, 2001, 3001, 5001);
INSERT INTO ITEM VALUES (11002, 'T-shirt', 10, 6002, 2001, 3002, 5002);
INSERT INTO ITEM VALUES (11003, 'Shoes', 30, 6003, null, 3003, 5003);
INSERT INTO ITEM VALUES (11004, 'Study table', 50, 6004, 2005, 3001, 5004);
INSERT INTO ITEM VALUES (11005, 'Scissor', 5, 6005, null, 3005, 5005);
INSERT INTO ITEM VALUES (11006, 'Smart phone', 100, 6010, 2019, 3004, 5006);
INSERT INTO ITEM VALUES (11007, 'Sofa', 90, 6009, 2006, 3001, 5007);
INSERT INTO ITEM VALUES (11008, 'Lamp', 40, 6008, 2008, 3001, 5008);
INSERT INTO ITEM VALUES (11009, 'Frock', 20, 6007, 2016, 3002, 5009);
INSERT INTO ITEM VALUES (11010, 'Laptop cover', 150, 6006, 2012, 3005, 5010);
INSERT INTO ITEM VALUES (11011, 'Pen stand', 10, 6010, 2015, 3005, 5011);
INSERT INTO ITEM VALUES (11012, 'Table', 45, 6002, 2004, 3001, 5012);
INSERT INTO ITEM VALUES (11013, 'Bagpack', 25, 6003, 2018, 3005, 5013);
INSERT INTO ITEM VALUES (11014, 'High heels', 35, 6004, 2002, 3003, 5014);
INSERT INTO ITEM VALUES (11015, 'Phone case', 12, 6005, 2007, 3005, 5015);
INSERT INTO ITEM VALUES (11016, 'Gas grill', 90, 6002, 2010, 3007, 5016);
INSERT INTO ITEM VALUES (11017, 'Jacket', 45, 6009, 2013, 3002, 5017);
INSERT INTO ITEM VALUES (11018, 'Chair', 52, 6008, 2001, 3001, 5018);
INSERT INTO ITEM VALUES (11019, 'Sweatshirt', 48, 6007, 2014, 3002, 5019);
INSERT INTO ITEM VALUES (11020, 'Soap', 16, 6006, 2017, 3006, 5020);
INSERT INTO ITEM VALUES (11021, 'Air purifier', 100, 6005, 2020, 3007, 5015);

INSERT INTO ITEM_CART VALUES (11001, 7001);
INSERT INTO ITEM_CART VALUES (11002, 7001);
INSERT INTO ITEM_CART VALUES (11003, 7001);
INSERT INTO ITEM_CART VALUES (11004, 7001);
INSERT INTO ITEM_CART VALUES (11005, 7002);
INSERT INTO ITEM_CART VALUES (11006, 7002);
INSERT INTO ITEM_CART VALUES (11007, 7003);
INSERT INTO ITEM_CART VALUES (11008, 7003);
INSERT INTO ITEM_CART VALUES (11009, 7003);
INSERT INTO ITEM_CART VALUES (11010, 7003);
INSERT INTO ITEM_CART VALUES (11011, 7003);
INSERT INTO ITEM_CART VALUES (11012, 7004);
INSERT INTO ITEM_CART VALUES (11013, 7004);
INSERT INTO ITEM_CART VALUES (11014, 7004);
INSERT INTO ITEM_CART VALUES (11015, 7005);
INSERT INTO ITEM_CART VALUES (11016, 7006);
INSERT INTO ITEM_CART VALUES (11017, 7006);
INSERT INTO ITEM_CART VALUES (11018, 7007);
INSERT INTO ITEM_CART VALUES (11019, 7007);
INSERT INTO ITEM_CART VALUES (11020, 7007);
INSERT INTO ITEM_CART VALUES (11021, 7007);

---------------------------------------------------------------------------------------------------------------------------------------

--SQL to view tables

select * from ADDRESS_ZIP;
select * from ADDRESS;
select * from REUSABLE_ITEM;
select * from CATEGORYY;
select * from SHIPPER;
select * from CUSTOMERR;
select * from SELLER;
select * from CART;
select * from ORDERR;
select * from PAYMENT;
select * from SHIPMENT;
select * from ITEM;
select * from ITEM_CART;
select * from SELLER_ARCHIVE;

commit;

-------------------------------------------------------------------------------------------------------------------------------------

--GRANT PERMISSIONS
CREATE USER c##Customer2 IDENTIFIED BY Customer26210;
CREATE USER c##Seller2 IDENTIFIED BY Seller26210;
CREATE USER c##Shipper2 IDENTIFIED BY Shipper26210;

grant create session to c##Customer2;
grant create session to c##Seller2;
grant create session to c##Shipper2;

------------------------------------------------------------------------------
--CUSTOMER GRANT PERMISSION

GRANT INSERT, UPDATE, DELETE ON CUSTOMERR TO c##Customer2;
GRANT INSERT, UPDATE ON ADDRESS TO c##Customer2;
GRANT INSERT, UPDATE ON ADDRESS_ZIP TO c##Customer2;
GRANT INSERT, UPDATE, DELETE ON CART TO c##Customer2;
GRANT SELECT ON PAYMENT TO c##Customer2;
GRANT SELECT ON ITEM TO c##Customer2;
GRANT SELECT ON CATEGORYY TO c##Customer2;
GRANT SELECT ON SHIPMENT TO c##Customer2;
GRANT SELECT ON REUSABLE_ITEM TO c##Customer2;
GRANT SELECT ON item_division TO c##Customer2;
GRANT SELECT ON customer_order_history TO c##Customer2;
GRANT SELECT ON customer_order_status TO c##Customer2;
GRANT EXECUTE ON customer_details TO c##Customer2;
GRANT EXECUTE ON cart_details TO c##Customer2;
GRANT EXECUTE ON Get_Order_Time TO c##Customer2;
GRANT EXECUTE ON CategoryBased TO c##Customer2;

commit;

----------------------------------------------------------------
--SELLER GRANT PERMISSION

GRANT INSERT, UPDATE, DELETE ON SELLER TO c##Seller2;
GRANT INSERT, UPDATE, DELETE ON ADDRESS TO c##Seller2;
GRANT INSERT, UPDATE, DELETE ON ADDRESS_ZIP TO c##Seller2;
GRANT SELECT, INSERT, UPDATE ON ITEM TO c##Seller2;
GRANT SELECT, INSERT, UPDATE ON REUSABLE_ITEM TO c##Seller2;
GRANT EXECUTE ON CategoryBased TO c##Seller2;
GRANT EXECUTE ON totalProducts TO c##Seller2;

commit;

----------------------------------------------------------------
--SHIPPER GRANT PERMISSION

GRANT INSERT, UPDATE, DELETE ON SHIPPER TO c##Shipper2;
GRANT SELECT, INSERT, UPDATE, DELETE ON SHIPMENT TO c##Shipper2;
GRANT EXECUTE ON Get_Order_Time TO c##Shipper2;

commit;

---------------------------------------------------------------------------------------------------------------------------------------

--Views
--Categorising items based on the price for the customers to view
create or replace view Item_division as
select item_id, item_name, price,
case
    when price < 25 then 'Cheap'
    when price > 75 then 'Exorbitant'
    else 'Affordable'
end as Division
from item;

SELECT* FROM Item_division;

-----------------------------------------------------------------------------

-- List customer order history
Create or replace view customer_order_history as
SELECT c.C_ID, c.C_NAME, o.ORDER_ID,p.Amount, o.Order_Date
FROM Customerr c
INNER JOIN Orderr o ON c.C_ID = o.C_ID
INNER  JOIN PAYMENT p ON p.ORDER_ID = o.ORDER_ID
ORDER BY o.Order_Date;

select * from customer_order_history;

-----------------------------------------------------------------------------------

--List order shipping status summary
Create or replace view customer_order_status as
SELECT o.ORDER_ID, c.C_ID, c.C_Name, s.SHIPMENT_ID, s.DELIVERY_STATUS, s.SHIPMENT_DATE, o.ORDER_DATE, sh.sh_name
from CUSTOMERR c
inner join ORDERR o on c.C_ID = o.C_ID
inner join PAYMENT p on p.ORDER_ID = o.ORDER_ID
inner join SHIPMENT s on s.PAYMENT_ID = P.PAYMENT_ID
inner join shipper sh on s.SHIPPER_ID = sh.SHIPPER_ID;

select * from customer_order_status;


----------------------------------------------------------------------------------------------------------------------

--Package
CREATE OR REPLACE PACKAGE ITEM_PACKAGE AS 
PROCEDURE CategoryBased(cat_name in categoryy.category_name%type);
PROCEDURE price_wise(p in number);
END;
/
------------------------------------------------------------------------------------------------------------------

--Procedures
--Displaying all items belonging to mentioned category
CREATE OR REPLACE PACKAGE BODY ITEM_PACKAGE AS 
PROCEDURE CategoryBased(cat_name in categoryy.category_name%type) IS
p_cat_name categoryy.category_name%type;
p_item_name item.item_name%type;
CURSOR cur2 IS
            SELECT category_name, item_name from categoryy, item
            WHERE categoryy.category_id = item.category_id
            AND category_name = cat_name;
BEGIN
    OPEN cur2;
    LOOP
        FETCH cur2 INTO p_cat_name, p_item_name;
        EXIT WHEN cur2%notfound;
        dbms_output.put_line('Under the category ' || p_cat_name || ', the item is - ' || p_item_name);
    END LOOP;
    CLOSE cur2;
EXCEPTION
        WHEN no_data_found THEN
        dbms_output.put_line('No such item exists');
END CategoryBased;


--To display items based on the range of the price mentioned
PROCEDURE price_wise(p in number) IS
    i_price item.price%type;
    i_name item.item_name%type;
    i_id item.item_id%type;
    CURSOR cur1 IS
    SELECT item_id,price,item_name FROM item WHERE price < p;
    BEGIN
        OPEN cur1;
        LOOP
            FETCH cur1 INTO i_id,i_price,i_name;
            EXIT WHEN cur1%notfound;
            dbms_output.put_line('Item ' || i_id || ' name is "' || i_name || '" and its price is $' || i_price);
        END LOOP;
        CLOSE cur1;
    EXCEPTION
        WHEN no_data_found THEN
        dbms_output.put_line('Sorry no such item exists');
    END price_wise;

END;
/
EXECUTE ITEM_PACKAGE.CategoryBased('FURNITURE');
EXECUTE ITEM_PACKAGE.price_wise(50);

----------------------------------------------------------------------------------------

--Display number of items in cart based on the ID
CREATE OR REPLACE PROCEDURE CART_DETAILS(C_ID IN VARCHAR)
    IS
    quan NUMBER(2);
    BEGIN
    SELECT NO_OF_ITEMS INTO quan FROM CART WHERE CART_ID = C_ID;
        dbms_output.put_line('The number of items present in the cart id ' || c_id ||' is : ' || quan);
    EXCEPTION
    WHEN no_data_found THEN
    dbms_output.put_line('Sorry no such cart exist !!');
    END;
/

EXECUTE CART_DETAILS(7020);

-------------------------------------------------------------------------------

--To check per day revenue
create or replace PROCEDURE TotalRevenuePerDay (P_DATE DATE)
AS
    temp  number;
    BEGIN
        SELECT sum (amount) as TotalSale
        INTO temp
        FROM Payment
        WHERE PAYMENT_DATE = P_DATE
        GROUP BY PAYMENT_DATE;
        DBMS_output.put_line('Total revenue of selected date is : '|| temp);
    END;
    /
   
Execute TotalRevenuePerDay('12-APR-2021') ;

--------------------------------------------------------------------------------------------------------------------------------------

--Functions
--To get a count of all items a seller posted
create or replace function totalProducts(sId in NUMBER)
    return number
    is
    total number(2):=0;
    begin
        select count(*) into total
        from item
        where s_id=sId;
        return total;
    end;
    /
   
declare
c number(4);
begin
c := totalProducts(6002);
DBMS_output.put_line('Total number of items the seller sells is : '|| c);
end;
/

---------------------------------------------------------------------------------

--To get Order Time
CREATE OR REPLACE FUNCTION Get_Order_Time (P_ID NUMBER)
RETURN NUMBER
AS
 v_temp NUMBER(10);
BEGIN
SELECT  s.SHIPMENT_DATE- p.PAYMENT_Date INTO v_temp
FROM SHIPMENT s
INNER JOIN PAYMENT p
on s.PAYMENT_ID = p.PAYMENT_ID
where s.PAYMENT_ID = P_ID;
RETURN v_temp;
END;
/

SELECT s.PAYMENT_ID, s.SHIPMENT_DATE, p.PAYMENT_DATE, Get_Order_Time (s.PAYMENT_ID) as Days
FROM SHIPMENT s
INNER JOIN PAYMENT p
on s.PAYMENT_ID = p.PAYMENT_ID;

-------------------------------------------------------------------------------

--Trigger
--To save details of the seller in seller_archive table once it is updated or deleted
CREATE OR REPLACE TRIGGER after_seller_details_deleted
AFTER DELETE
ON SELLER FOR EACH ROW
BEGIN
    INSERT INTO SELLER_ARCHIVE (S_ID, S_NAME, S_USERNAME, S_PASSWORD, S_PHONE, S_EMAIL, ADDRESS_ID) VALUES (:OLD.S_ID, :OLD.S_NAME, :OLD.S_USERNAME, :OLD.S_PASSWORD, :OLD.S_PHONE, :OLD.S_EMAIL, :OLD.ADDRESS_ID);
END;
/

DELETE FROM SELLER WHERE S_ID = 6011;

select * from SELLER;
select * from SELLER_ARCHIVE;
----------------------------------------------------------------------------------------------------------------

-- Generating 5 reports

--Delivery status
select delivery_status,count(*) from shipment group by delivery_status;

--Find customers with total amount more than 200 dollars
SELECT p.amount, c.c_name AS  "Customer Name" 
FROM Customerr c, Payment p, Orderr o, Item i, Categoryy ca
WHERE c.C_ID = o.C_ID AND o.ORDER_ID = p.ORDER_ID AND i.C_ID = c.C_ID AND ca.CATEGORY_ID = i.CATEGORY_ID AND p.amount > 200
ORDER BY amount DESC;

--Category with highest reusable items
select category_name, sum(no_of_times_used)
from reusable_item r, item i, categoryy c
where r.r_id = i.r_id and c.category_id = i.category_id group by category_name order by sum(no_of_times_used) desc;

--Customer details after the delivery
select c_name as "Customer name", c_phone as "Phone number", address_line1 "Address", city, payment_date, amount
from customerr c, address a, address_zip z, payment p, orderr o
where c.address_id = a.address_id and a.area_code = z.area_code and p.order_id = o.order_id and o.c_id = c.c_id;

--Number of items in each category
select category_name, sum(no_of_items) 
from cart c, categoryy ca, item_cart ic, item i
where ca.category_id = i.category_id and ic.cart_id = c.cart_id and ic.item_id = i.item_id
group by category_name;

--Categorising items based the prices
SELECT item_name, price,
     CASE WHEN price < 40 THEN 'CHEAP'
          WHEN price >75 THEN 'EXPENSIVE'
                  ELSE 'REASONABLE'
     END AS Price_Range
FROM ITEM;

commit;

----------------------------------------------------------------------------------------------------------------------

select i.item_id, i.item_name, i.c_id, p.amount from item i
inner join orderr o on i.c_id = o.c_id inner join payment p on o.order_id = p.order_id
order by p.amount asc
fetch first 5 rows only;

