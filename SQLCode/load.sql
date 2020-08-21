DROP TABLE sold_products;
DROP TABLE prescribed_products;
DROP TABLE stocks;
DROP TABLE supplies;
DROP TABLE prescription;
DROP TABLE sale;
DROP TABLE customer_allergies;
DROP TABLE customer;
DROP TABLE doctor;
DROP TABLE employee_jobs;
DROP TABLE branch_manager;
DROP TABLE employee cascade constraints;
DROP TABLE branch;
DROP TABLE product;
DROP TABLE vendor;

CREATE TABLE vendor
(
vendor_id   INT          PRIMARY KEY,
name        VARCHAR2(30) NOT NULL    UNIQUE,
address     VARCHAR2(50) NOT NULL
);

INSERT INTO vendor VALUES
(
0, 'BigPharma', '123 OneTwoThree Avenue, SomeCountry'
);
INSERT INTO vendor VALUES
(
1, 'ShadyCorporation', '234 TwoThreeFour Avenue, SomeCountry'
);
INSERT INTO vendor VALUES
(
2, 'Bandages-R-Us', '345 ThreeFourFive Avenue, SomeCountry'
);
INSERT INTO vendor VALUES
(
3, 'Pain-n-Gain', '456 FourFiveSix Avenue, SomeCountry'
);
INSERT INTO vendor VALUES
(
4, 'CheapDrugs', '567 FiveSixSeven Avenue, SomeCountry'
);

COMMIT;



CREATE TABLE product
(
product_id  INT         PRIMARY KEY,
name        VARCHAR2(15) NOT NULL   UNIQUE,
type        VARCHAR2(15),
price       NUMBER(6,2)  NOT NULL,
discount    Number(2,2)
);

INSERT INTO product VALUES
(
0, 'Needles', 'Medical', 29.99, NULL
);
INSERT INTO product VALUES
(
1, 'Bandages', NULL, 62.99, 0.89
);
INSERT INTO product VALUES
(
2, 'Panadol', 'Pain relief', 2.99, NULL
);
INSERT INTO product VALUES
(
3, 'Neurofen', 'Pain relief', 2.99, NULL
);
INSERT INTO product VALUES
(
4, 'Xanax', 'Drugs', 93.99, 0.8
);
INSERT INTO product VALUES
(
5, 'Band-aid', NULL, 14.99, NULL
);
INSERT INTO product VALUES
(
6, 'Hydrolyte', 'Hydration', 1.99, NULL
);
INSERT INTO product VALUES
(
7, 'Eyeliner', 'Makeup', 8.99, NULL
);

COMMIT;



CREATE TABLE branch
(
pharmacy_id INT         PRIMARY KEY,
address     VARCHAR2(30) NOT NULL
);

INSERT INTO branch VALUES
(
0, '123 ave'
);
INSERT INTO branch VALUES
(
1, '660 Castle Street'
);
INSERT INTO branch VALUES
(
2, '12 Grimmauld Place'
);
INSERT INTO branch VALUES
(
3, '177A Bleecker Street'
);



CREATE TABLE employee
(
first_name  VARCHAR2(15) NOT NULL,
middle_name VARCHAR2(15),
last_name   VARCHAR2(15) NOT NULL,
employee_id INT         PRIMARY KEY,
birth_date   DATE,
phone_num   VARCHAR2(10),
works_at    INT          NOT NULL
            CONSTRAINT works_at_fk REFERENCES branch(pharmacy_id),
manager_id  INT
    CONSTRAINT manager_id_fk REFERENCES employee(employee_id),
job_title   VARCHAR(30)  NOT NULL
    CONSTRAINT emplyee_valid_job CHECK (job_title IN ('Head Pharmacist', '2IC Pharmacist', 'Junior Pharmacist'))
);

INSERT INTO employee VALUES
(
'Haibo', NULL, 'Zhang', 0, TO_DATE('01-01-1982', 'DD-MM-YYYY'), '0276587928', 0, NULL, 'Head Pharmacist'
);
INSERT INTO employee VALUES
(
'Brendan', NULL, 'McCane', 1, TO_DATE('03-11-1985', 'DD-MM-YYYY'), '0276376898', 1, NULL, 'Head Pharmacist'
);
INSERT INTO employee VALUES
(
'Yawen', NULL, 'Chen', 2, TO_DATE('23-05-1985', 'DD-MM-YYYY'), '0279089987', 2, NULL, 'Head Pharmacist'
);
INSERT INTO employee VALUES
(
'Benjamin', 'Jacob', 'McCarthy', 3, TO_DATE('01-01-1993', 'DD-MM-YYYY'), '0277851846', 0, 0, '2IC Pharmacist'
);
INSERT INTO employee VALUES
(
'Usman', NULL, 'Shah', 4, TO_DATE('01-01-1997', 'DD-MM-YYYY'), '0213545536', 0, 3, 'Junior Pharmacist'
);
INSERT INTO employee VALUES
(
'Leon', NULL, 'Hook', 5, TO_DATE('05-12-2001', 'DD-MM-YYYY'), '0275336555', 1, 1, '2IC Pharmacist'
);
INSERT INTO employee VALUES
(
'Michael', NULL, 'Albert', 6, TO_DATE('07-03-1985', 'DD-MM-YYYY'), '0278983354', 2, 2, '2IC Pharmacist'
);
INSERT INTO employee VALUES
(
'Dominic', NULL, 'Stufkins', 7, TO_DATE('02-02-1998', 'DD-MM-YYYY'), NULL, 2, 6, 'Junior Pharmacist'
);


COMMIT;



CREATE TABLE branch_manager
(
pharmacy_id INT
    CONSTRAINT branch_manager_branch_fk REFERENCES branch(pharmacy_id),
employee_id INT
    CONSTRAINT branch_manager_employee_fk REFERENCES employee(employee_id),
PRIMARY KEY (pharmacy_id, employee_id)
);

INSERT INTO branch_manager VALUES
(
0, 0
);
INSERT INTO branch_manager VALUES
(
1, 1
);
INSERT INTO branch_manager VALUES
(
2, 2
);

COMMIT;




CREATE TABLE employee_jobs
(
job_title   VARCHAR(30) PRIMARY KEY
            CONSTRAINT emplyee_jobs_valid_job CHECK (job_title IN ('Head Pharmacist', '2IC Pharmacist', 'Junior Pharmacist')),
salary      NUMBER(6)    NOT NULL
);

INSERT INTO employee_jobs VALUES
(
'Head Pharmacist', 150000
);
INSERT INTO employee_jobs VALUES
(
'2IC Pharmacist', 120000
);
INSERT INTO employee_jobs VALUES
(
'Junior Pharmacist', 100000
);

COMMIT;




CREATE TABLE doctor
(
first_name      VARCHAR2(15) NOT NULL,
middle_name     VARCHAR2(15),
last_name       VARCHAR2(15) NOT NULL,
registration_id INT     PRIMARY KEY,
birth_date       DATE,
specialization  VARCHAR2(30)
                CONSTRAINT special CHECK (specialization IN ('Surgeon', 'General Practitioner')),
office_location VARCHAR2(30)
);

INSERT INTO doctor VALUES
(
'John', 'Alan', 'Smith', 0, TO_DATE('02-02-1978', 'DD-MM-YYYY'), 'Surgeon', 'Shortland Street'
);
INSERT INTO doctor VALUES
(
'Mary', 'Beth', 'Drinkwater', 1, TO_DATE('12-12-1976', 'DD-MM-YYYY'), 'General Practitioner', 'Sacred Heart'
);
INSERT INTO doctor VALUES
(
'Argy', NULL, 'Song', 2, TO_DATE('01-09-1982', 'DD-MM-YYYY'), 'General Practitioner', 'Gardens Medical'
);
INSERT INTO doctor VALUES
(
'Stephen', NULL, 'Strange', 3, TO_DATE('26-04-1979', 'DD-MM-YYYY'), 'Surgeon', 'Avengers Base'
);

COMMIT;




CREATE TABLE customer
(
first_name  VARCHAR2(15) NOT NULL,
middle_name VARCHAR2(15),
last_name   VARCHAR2(15) NOT NULL,
customer_id INT          PRIMARY KEY,
birth_date   DATE,
address     VARCHAR2(30)
);

INSERT INTO customer VALUES
(
'George', 'Rush', 'St Pierre', 0, TO_DATE('22-02-1992', 'DD-MM-YYYY'), '145 Dundas Street'
);
INSERT INTO customer VALUES
(
'Jon', 'Bones', 'Jones', 1, TO_DATE('30-08-1983', 'DD-MM-YYYY'), '9 Hyde Street'
);
INSERT INTO customer VALUES
(
'Henry', 'Triple C', 'Cejudo', 2, TO_DATE('05-02-1987', 'DD-MM-YYYY'), '15 Castle Street'
);
INSERT INTO customer VALUES
(
'Zhang', NULL, 'WeiLi', 3, TO_DATE('01-01-1990', 'DD-MM-YYYY'), '16 Cumberland Street'
);

COMMIT;



CREATE TABLE customer_allergies
(
customer_id INT
    CONSTRAINT customer_id_fk REFERENCES customer(customer_id),
allergy     VARCHAR2(15),
PRIMARY KEY (customer_id, allergy)
);

INSERT INTO customer_allergies VALUES
(
0, 'Strawberries'
);
INSERT INTO customer_allergies VALUES
(
0, 'Walnuts'
);
INSERT INTO customer_allergies VALUES
(
0, 'Grass'
);
INSERT INTO customer_allergies VALUES
(
2, 'Peanuts'
);

COMMIT;




CREATE TABLE sale
(
employee_id INT
    CONSTRAINT sale_employee_fk REFERENCES employee(employee_id),
sale_date DATE,
customer_id INT
    CONSTRAINT sale_customer_fk REFERENCES customer(customer_id),
PRIMARY KEY (employee_id, sale_date)
);
INSERT INTO sale VALUES
(
0, TO_DATE('2020/01/01 08:01:12', 'yyyy/mm/dd hh:mi:ss'), 3
);
INSERT INTO sale VALUES
(
0, TO_DATE('2020/02/02 08:47:50', 'yyyy/mm/dd hh:mi:ss'), 3
);
INSERT INTO sale VALUES
(
1, TO_DATE('2020/03/03 02:20:34', 'yyyy/mm/dd hh:mi:ss'), 2
);
INSERT INTO sale VALUES
(
5, TO_DATE('2020/02/02 12:33:01', 'yyyy/mm/dd hh:mi:ss'), 1
);

COMMIT;





CREATE TABLE prescription
(
registration_id INT
    CONSTRAINT prescription_doctor_fk REFERENCES doctor(registration_id),
prescription_date DATE,
customer_id INT
    CONSTRAINT prescription_customer_fk REFERENCES customer(customer_id),
PRIMARY KEY (registration_id, prescription_date)
);

INSERT INTO prescription VALUES
(
0, TO_DATE('2020/01/01 12:00:30', 'yyyy/mm/dd hh:mi:ss'), 0
);
INSERT INTO prescription VALUES
(
0, TO_DATE('2020/01/03 03:30:26', 'yyyy/mm/dd hh:mi:ss'), 0
);
INSERT INTO prescription VALUES
(
1, TO_DATE('2020/01/01 08:10:46', 'yyyy/mm/dd hh:mi:ss'), 1
);
INSERT INTO prescription VALUES
(
1, TO_DATE('2020/01/03 08:30:21', 'yyyy/mm/dd hh:mi:ss'), 1
);
INSERT INTO prescription VALUES
(
2, TO_DATE('2020/03/11 11:49:10', 'yyyy/mm/dd hh:mi:ss'), 2
);

COMMIT;





CREATE TABLE supplies
(
vendor_id INT
    CONSTRAINT supplies_vendor_fk REFERENCES vendor(vendor_id),
product_id INT
    CONSTRAINT supplies_product_fk REFERENCES product(product_id),
PRIMARY KEY (vendor_id, product_id)
);
INSERT INTO supplies VALUES
(
0,1
);
INSERT INTO supplies VALUES
(
0,2
);

INSERT INTO supplies VALUES
(
0,3
);

INSERT INTO supplies VALUES
(
0,4
);

INSERT INTO supplies VALUES
(
1,0
);

INSERT INTO supplies VALUES
(
1,1
);
INSERT INTO supplies VALUES
(
1,2
);
INSERT INTO supplies VALUES
(
1,3
);
INSERT INTO supplies VALUES
(
1,4
);
INSERT INTO supplies VALUES
(
1,5
);
INSERT INTO supplies VALUES
(
2,4
);
INSERT INTO supplies VALUES
(
2,5
);
INSERT INTO supplies VALUES
(
2,6
);

COMMIT;







CREATE TABLE stocks
(
pharmacy_id INT
    CONSTRAINT stocks_branch_fk REFERENCES branch(pharmacy_id),
product_id INT
    CONSTRAINT stocks_product_fk REFERENCES product(product_id),
PRIMARY KEY (pharmacy_id, product_id)
);
INSERT INTO stocks VALUES
(
0, 0
);
INSERT INTO stocks VALUES
(
0, 1
);
INSERT INTO stocks VALUES
(
0, 2
);
INSERT INTO stocks VALUES
(
1, 2
);
INSERT INTO stocks VALUES
(
2, 3
);
INSERT INTO stocks VALUES
(
2, 4
);
INSERT INTO stocks VALUES
(
2, 5
);
INSERT INTO stocks VALUES
(
3, 5
);
INSERT INTO stocks VALUES
(
3, 6
);
INSERT INTO stocks VALUES
(
3, 7
);

COMMIT;






CREATE TABLE prescribed_products
(
product_id INT
    CONSTRAINT prescribed_products_product_fk REFERENCES product(product_id),
prescription_date DATE,
registration_id INT,
FOREIGN KEY (registration_id, prescription_date) REFERENCES prescription(registration_id, prescription_date),
PRIMARY KEY (product_id, prescription_date, registration_id)
);

INSERT INTO prescribed_products VALUES
(
0, TO_DATE('2020/01/01 12:00:30', 'yyyy/mm/dd hh:mi:ss'), 0
);
INSERT INTO prescribed_products VALUES
(
1, TO_DATE('2020/01/01 12:00:30', 'yyyy/mm/dd hh:mi:ss'), 0
);

INSERT INTO prescribed_products VALUES
(
0, TO_DATE('2020/01/03 03:30:26', 'yyyy/mm/dd hh:mi:ss'), 0
);

INSERT INTO prescribed_products VALUES
(
1, TO_DATE('2020/01/01 08:10:46', 'yyyy/mm/dd hh:mi:ss'), 1
);
INSERT INTO prescribed_products VALUES
(
2, TO_DATE('2020/01/01 08:10:46', 'yyyy/mm/dd hh:mi:ss'), 1
);
INSERT INTO prescribed_products VALUES
(
6, TO_DATE('2020/01/01 08:10:46', 'yyyy/mm/dd hh:mi:ss'), 1
);

INSERT INTO prescribed_products VALUES
(
4, TO_DATE('2020/01/03 08:30:21', 'yyyy/mm/dd hh:mi:ss'), 1
);
INSERT INTO prescribed_products VALUES
(
5, TO_DATE('2020/01/03 08:30:21', 'yyyy/mm/dd hh:mi:ss'), 1
);

INSERT INTO prescribed_products VALUES
(
1, TO_DATE('2020/03/11 11:49:10', 'yyyy/mm/dd hh:mi:ss'), 2
);
INSERT INTO prescribed_products VALUES
(
3, TO_DATE('2020/03/11 11:49:10', 'yyyy/mm/dd hh:mi:ss'), 2
);
INSERT INTO prescribed_products VALUES
(
5, TO_DATE('2020/03/11 11:49:10', 'yyyy/mm/dd hh:mi:ss'), 2
);

COMMIT;


CREATE TABLE sold_products
(
employee_id INT,
sale_date DATE,
product_id INT
    CONSTRAINT sold_products_product_fk REFERENCES product(product_id),
FOREIGN KEY (employee_id, sale_date) REFERENCES sale(employee_id, sale_date),
PRIMARY KEY (employee_id, sale_date, product_id)
);

INSERT INTO sold_products VALUES
(
0, TO_DATE('2020/01/01 08:01:12', 'yyyy/mm/dd hh:mi:ss'), 1
);
INSERT INTO sold_products VALUES
(
0, TO_DATE('2020/01/01 08:01:12', 'yyyy/mm/dd hh:mi:ss'), 2
);
INSERT INTO sold_products VALUES
(
0, TO_DATE('2020/01/01 08:01:12', 'yyyy/mm/dd hh:mi:ss'), 3
);


INSERT INTO sold_products VALUES
(
0, TO_DATE('2020/02/02 08:47:50', 'yyyy/mm/dd hh:mi:ss'), 3
);
INSERT INTO sold_products VALUES
(
0, TO_DATE('2020/02/02 08:47:50', 'yyyy/mm/dd hh:mi:ss'), 4
);
INSERT INTO sold_products VALUES
(
0, TO_DATE('2020/02/02 08:47:50', 'yyyy/mm/dd hh:mi:ss'), 5
);



INSERT INTO sold_products VALUES
(
1, TO_DATE('2020/03/03 02:20:34', 'yyyy/mm/dd hh:mi:ss'), 2
);



INSERT INTO sold_products VALUES
(
5, TO_DATE('2020/02/02 12:33:01', 'yyyy/mm/dd hh:mi:ss'), 1
);
INSERT INTO sold_products VALUES
(
5, TO_DATE('2020/02/02 12:33:01', 'yyyy/mm/dd hh:mi:ss'), 5
);
INSERT INTO sold_products VALUES
(
5, TO_DATE('2020/02/02 12:33:01', 'yyyy/mm/dd hh:mi:ss'), 4
);
INSERT INTO sold_products VALUES
(
5, TO_DATE('2020/02/02 12:33:01', 'yyyy/mm/dd hh:mi:ss'), 7
);

COMMIT;

