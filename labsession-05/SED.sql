CREATE DATABASE wad_lab_5_sem1;
USE wad_lab_5_sem1;

CREATE TABLE distributor (
    tin VARCHAR(10),
    distname VARCHAR(20) NOT NULL,
    address VARCHAR(20),
    contactdetails VARCHAR(50),

    CONSTRAINT pk_distributor PRIMARY KEY (TIN)
);

CREATE TABLE solarpanel (
    pv_module VARCHAR(30),
    pv_type VARCHAR(30),
    price DECIMAL(10,2),
    capacity INT,
    warranty INT,

    CONSTRAINT pk_solarpanel PRIMARY KEY (pv_module)
);

CREATE TABLE users (
    buildingno VARCHAR(30),
    buildingname VARCHAR(100),
    areaname VARCHAR(100),

    CONSTRAINT pk_users PRIMARY KEY (buildingno)
);

CREATE TABLE sells (
    pv_module VARCHAR(30),
    tin VARCHAR(10),

    CONSTRAINT pk_sells PRIMARY KEY (pv_module, tin),

    CONSTRAINT fk_sells_pv
        FOREIGN KEY (pv_module)
        REFERENCES solarpanel (pv_module),

    CONSTRAINT fk_sells_distributor
        FOREIGN KEY (tin)
        REFERENCES distributor (tin)
);

CREATE TABLE purchases (
    pv_module VARCHAR(30),
    buildingno VARCHAR(30),

    CONSTRAINT pk_purchases PRIMARY KEY (pv_module, buildingno),

    CONSTRAINT fk_purchases_pv
        FOREIGN KEY (pv_module)
        REFERENCES solarpanel (pv_module),

    CONSTRAINT fk_purchases_user
        FOREIGN KEY (buildingno)
        REFERENCES Users (buildingno)
);

CREATE TABLE installsolar (
    pv_module VARCHAR(30),
    tin VARCHAR(10),
    buildingno VARCHAR(30),
    installdate DATE NOT NULL,
    areatype VARCHAR(30),
    instcharge DECIMAL(10,2) CHECK (instcharge >= 0),

    CONSTRAINT pk_installsolar PRIMARY KEY (pv_module, tin, buildingno),

    CONSTRAINT fk_installsolar_pv
        FOREIGN KEY (pv_module)
        REFERENCES solarpanel (pv_module),

    CONSTRAINT fk_installsolar_distributor
        FOREIGN KEY (tin)
        REFERENCES Distributor (tin),

    CONSTRAINT fk_installsolar_user
        FOREIGN KEY (buildingno)
        REFERENCES users (buildingno)
);


INSERT INTO distributor VALUES
('TIN001', 'SolarOne', 'Chennai', '9000011111'),
('TIN002', 'GreenVolt', 'Bangalore', '9000022222'),
('TIN003', 'SunPower', 'Hyderabad', '9000033333');

INSERT INTO solarpanel VALUES
('PV001', 'Monocrystalline', 150000.00, 5, 15),
('PV002', 'Polycrystalline', 120000.00, 10, 25),
('PV003', 'Monocrystalline', 180000.00, 8, 15),
('PV004', 'Polycrystalline', 200000.00, 12, 25);

INSERT INTO users VALUES
('H101', 'Ramesh', 'Hyderabad'),
('H102', 'Suresh', 'Hyderabad'),
('O201', 'RV Office', 'Bangalore'),
('H103', 'Mahesh', 'Chennai'),
('O202', 'Hotel Grand', 'Chennai');

INSERT INTO sells VALUES
('PV001', 'TIN001'),
('PV002', 'TIN001'),
('PV003', 'TIN002'),
('PV004', 'TIN003');

INSERT INTO purchases VALUES
('PV001', 'H101'),
('PV002', 'H102'),
('PV003', 'O201'),
('PV004', 'O202'),
('PV001', 'H103');

INSERT INTO installsolar VALUES
('PV001', 'TIN001', 'H101', '2015-01-10', 'Domestic', 40000),
('PV002', 'TIN001', 'H102', '2016-05-15', 'Domestic', 60000),
('PV001', 'TIN001', 'H103', '2014-03-20', 'Domestic', 40000),
('PV003', 'TIN002', 'O201', '2017-07-01', 'Commercial', 40000),
('PV004', 'TIN003', 'O202', '2013-11-25', 'Commercial', 60000);

-- Query 1
-- List the distributor with most installations in domestic places
SELECT distname
FROM Distributor
WHERE tin IN (
    SELECT tin
    FROM installsolar
    WHERE areatype = 'Domestic'
    GROUP BY tin
    HAVING COUNT(*) >= ALL (
        SELECT COUNT(*)
        FROM installsolar
        WHERE areatype = 'Domestic'
        GROUP BY tin
    )
);

SELECT d.distname
FROM Distributor d
JOIN (
    SELECT tin, COUNT(*) AS cnt
    FROM installsolar
    WHERE areatype = 'Domestic'
    GROUP BY tin
) t ON d.tin = t.tin
WHERE t.cnt >= ALL (
    SELECT COUNT(*)
    FROM installsolar
    WHERE areatype = 'Domestic'
    GROUP BY tin
);


-- Query 2
-- List the place name with highest capacity panel installed
SELECT areaname FROM users WHERE buildingno IN (
    SELECT buildingno FROM installsolar WHERE pv_module IN (
        SELECT pv_module FROM solarpanel WHERE capacity >= ALL (
            SELECT capacity FROM solarpanel
        )
    )
);

SELECT u.areaname
FROM users u
JOIN installsolar i ON u.buildingno = i.buildingno
JOIN solarpanel s ON i.pv_module = s.pv_module
WHERE s.capacity >= ALL (
    SELECT sp.capacity
    FROM solarpanel sp
    JOIN installsolar ins ON sp.pv_module = ins.pv_module
);

-- Query 3
-- Display the area where monocrystalline panels are installed
SELECT areaname FROM users WHERE buildingno IN (
    SELECT buildingno FROM installsolar WHERE pv_module IN (
        SELECT pv_module FROM solarpanel WHERE pv_type = 'Monocrystalline'
    )
);

SELECT areaname FROM users WHERE buildingno IN (
	SELECT buildingno FROM purchases WHERE pv_module IN (
		SELECT pv_module FROM solarpanel WHERE pv_type = 'Monocrystalline'
	)
);

SELECT DISTINCT u.areaname
FROM users u
JOIN installsolar i ON u.buildingno = i.buildingno
JOIN solarpanel s ON i.pv_module = s.pv_module
WHERE s.pv_type = 'Monocrystalline';

-- Query 4
-- For the specific area display the total installation charges for both type of PV modules
SELECT
    (SELECT areaname FROM users WHERE buildingno = i.buildingno) AS areaname,
    (SELECT pv_type FROM solarpanel WHERE pv_module = i.pv_module) AS pv_type,
    SUM(i.instcharge) AS total_instcharge
FROM installsolar i
GROUP BY i.buildingno, i.pv_module;

SELECT u.areaname, s.pv_type, SUM(i.instcharge) AS total_instcharge
FROM installsolar i
JOIN users u ON i.buildingno = u.buildingno
JOIN solarpanel s ON i.pv_module = s.pv_module
GROUP BY u.areaname, s.pv_type;

-- Query 5
-- List the details of distributors and panel that is the oldest installation
SELECT * FROM distributor WHERE tin IN (
    SELECT tin FROM installsolar WHERE installdate = (
        SELECT MIN(installdate) FROM installsolar
    )
);

SELECT * FROM solarpanel WHERE pv_module IN (
    SELECT pv_module FROM installsolar WHERE installdate = (
        SELECT MIN(installdate) FROM installsolar
    )
);

SELECT d.*, s.*
FROM installsolar i
JOIN distributor d ON i.tin = d.tin
JOIN solarpanel s ON i.pv_module = s.pv_module
WHERE i.installdate = (
    SELECT MIN(installdate) FROM installsolar
);

-- Query 6
-- Find the average sales of both type of panels in only commercial places
SELECT
    (SELECT pv_type FROM solarpanel WHERE pv_module = i.pv_module) AS pv_type,
    AVG((SELECT price FROM solarpanel WHERE pv_module = i.pv_module)) AS avg_sales
FROM installsolar i
WHERE i.areatype = 'Commercial'
GROUP BY i.pv_module;

SELECT s.pv_type, AVG(s.price) AS avg_sales
FROM installsolar i
JOIN solarpanel s ON i.pv_module = s.pv_module
WHERE i.areatype = 'Commercial'
GROUP BY s.pv_type;

-- DROP DATABASE IF EXISTS wad_lab_5_sem1;