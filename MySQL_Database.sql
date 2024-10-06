CREATE TABLE passenger(
 SSN char(64),
 p_name char(50),
 gender char(6),
 tel_number char(20),
 age int,
 primary key (SSN)
);

CREATE TABLE flight(
 flight_id char(64) NOT NULL,
 boarding_time char(10),
 gate_num char(10),
 flight_date date,
 primary key (flight_id)
);


CREATE TABLE airline(
 airline_name char(50),
 primary key (airline_name)
);

CREATE TABLE airplane(
 airplane_id char(64) NOT NULL,
 plane_type char(32),
 capacity INT,
 primary key (airplane_id)
);

CREATE TABLE HAS(
    airplane_id CHAR(64) NOT NULL,
    seat_id CHAR(10),
    seat_number char(12),
    primary key(seat_id),
    foreign key (airplane_id) References airplane(airplane_id) ON DELETE CASCADE
);

CREATE TABLE ticket(
 ticket_id char(64),
 price FLOAT,
 class CHAR(64),
 primary key (ticket_id)
);


CREATE TABLE pilot(
 pilot_id char(64),
 flight_id char(64) NOT NULL,
 p_name char(124),
 sex char(24),
 PRIMARY KEY(pilot_id),
 FOREIGN KEY (flight_id) REFERENCES flight(flight_id) ON DELETE CASCADE
);


CREATE TABLE books(
  SSN char(64),
  flight_id char(64),
  Foreign Key (SSN) References passenger(SSN) ON DELETE CASCADE,
  Foreign Key (flight_id) References flight(flight_id) ON DELETE CASCADE
);

CREATE TABLE manages(
  airline_name char(50),
  flight_id char(64),
  Foreign Key (airline_name) References airline(airline_name) ON DELETE CASCADE,
  Foreign Key (flight_id) References flight(flight_id) ON DELETE CASCADE
);

CREATE TABLE assigned(
   flight_id char(64),
   airplane_id char(32) NOT NULL,
   FOREIGN KEY (flight_id) REFERENCES flight(flight_id) ON DELETE CASCADE,
   FOREIGN KEY (airplane_id) REFERENCES airplane(airplane_id) ON DELETE CASCADE
);

CREATE TABLE BUYS(
  SSN char(64),
  ticket_id char(64),
  Foreign Key (SSN) References passenger(SSN) ON DELETE CASCADE,
  Foreign Key (ticket_id) References ticket(ticket_id) ON DELETE CASCADE
);

/*
CREATE TABLE Entitled_baggage (
	ticket_id CHAR(64) NOT NULL,
    baggage_id CHAR(64),
    weight INT,
    insurance CHAR(5),
    primary key (baggage_id),
    foreign key (ticket_id) references ticket(ticket_id) ON DELETE CASCADE
);
*/

CREATE TABLE BaggageInfo (
    baggage_id CHAR(64),
    weight INT,
    insurance CHAR(5),
    primary key (baggage_id)
);

CREATE TABLE BaggageRef (
    baggage_id CHAR(64),
	ticket_id CHAR(64) NOT NULL,
    foreign key (baggage_id) references BaggageInfo(baggage_id) ON DELETE CASCADE,
    foreign key (ticket_id) references ticket(ticket_id) ON DELETE CASCADE
);


CREATE TABLE Abroad(
	flight_id CHAR(64),
	abroad_from CHAR(64),
    abroad_to CHAR(64),
    visa_restriction CHAR(16),
    FOREIGN KEY(flight_id) references flight(flight_id) ON DELETE CASCADE
);

CREATE TABLE Domestic(
	flight_id CHAR(64),
	domestic_from CHAR(64),
    domestic_to CHAR(64),
    FOREIGN KEY(flight_id) references flight(flight_id) ON DELETE CASCADE
);

-- Insert data into passenger table
INSERT INTO passenger (SSN, p_name, gender, tel_number, age)
VALUES
('123456789', 'John Doe', 'Male', '123-456-7890', 30),
('234567890', 'Jane Smith', 'Female', '234-567-8901', 25),
('345678901', 'Mike Johnson', 'Male', '345-678-9012', 40),
('456789012', 'Emily Brown', 'Female', '456-789-0123', 35),
('567890123', 'David Lee', 'Male', '567-890-1234', 28),
('678901234', 'Sarah White', 'Female', '678-901-2345', 45),
('789012345', 'Alex Johnson', 'Male', '789-012-3456', 22),
('890123456', 'Jessica Davis', 'Female', '890-123-4567', 29),
('901234567', 'Michael Smith', 'Male', '901-234-5678', 33),
('012345678', 'Sophia Wilson', 'Female', '012-345-6789', 27);

-- Insert data into flight table
INSERT INTO flight (flight_id, boarding_time, gate_num, flight_date)
VALUES
('FL123', '08:00', 'A1', '2024-04-15'),
('FL456', '10:30', 'B2', '2024-04-16'),
('FL789', '12:45', 'C3', '2024-04-17'),
('FL012', '15:00', 'D4', '2024-04-18'),
('FL345', '09:00', 'E5', '2024-04-19'),
('FL678', '11:15', 'F6', '2024-04-20'),
('FL901', '13:30', 'G7', '2024-04-21'),
('FL234', '16:00', 'H8', '2024-04-22'),
('FL567', '14:20', 'I9', '2024-04-23'),
('FL890', '17:45', 'J10', '2024-04-24');

-- Insert data into airline table
INSERT INTO airline (airline_name)
VALUES
('Delta Airlines'),
('United Airlines'),
('American Airlines'),
('Southwest Airlines'),
('JetBlue Airways'),
('Alaska Airlines'),
('Spirit Airlines'),
('Frontier Airlines'),
('Hawaiian Airlines'),
('Allegiant Air');

-- Insert data into airplane table
INSERT INTO airplane (airplane_id, plane_type, capacity)
VALUES
('A123', 'Boeing 737', 150),
('B456', 'Airbus A320', 180),
('C789', 'Embraer E175', 80),
('D012', 'Boeing 747', 300),
('E345', 'Airbus A330', 250),
('F678', 'Bombardier CRJ900', 70),
('G901', 'Boeing 787', 200),
('H234', 'Airbus A380', 500),
('I567', 'Embraer E190', 100),
('J890', 'Bombardier Dash 8', 50);

-- Insert data into HAS table (airplane seating)
INSERT INTO HAS (airplane_id, seat_id, seat_number)
VALUES
('A123', 'A1', '1A'),
('A123', 'A2', '1B'),
('B456', 'B1', '2A'),
('B456', 'B2', '2B'),
('C789', 'C1', '3A'),
('C789', 'C2', '3B'),
('D012', 'D1', '4A'),
('D012', 'D2', '4B'),
('E345', 'E1', '5A'),
('E345', 'E2', '5B');

-- Insert data into ticket table
INSERT INTO ticket (ticket_id, price, class)
VALUES
('T123', 250.00, 'Business'),
('T456', 150.00, 'Economy'),
('T789', 200.00, 'Premium Economy'),
('T012', 300.00, 'Business'),
('T345', 180.00, 'Economy'),
('T678', 220.00, 'Premium Economy'),
('T901', 270.00, 'Business'),
('T234', 160.00, 'Economy'),
('T567', 210.00, 'Premium Economy'),
('T890', 280.00, 'Business');

-- Insert data into pilot table
INSERT INTO pilot (pilot_id, flight_id, p_name, sex)
VALUES
('P001', 'FL123', 'John Smith', 'Male'),
('P002', 'FL456', 'Emma Johnson', 'Female'),
('P003', 'FL789', 'Michael Brown', 'Male'),
('P004', 'FL012', 'Sarah Davis', 'Female'),
('P005', 'FL345', 'David Wilson', 'Male'),
('P006', 'FL678', 'Emily Taylor', 'Female'),
('P007', 'FL901', 'Chris Martinez', 'Male'),
('P008', 'FL234', 'Jessica Garcia', 'Female'),
('P009', 'FL567', 'Daniel Lopez', 'Male'),
('P010', 'FL890', 'Laura Hernandez', 'Female');


-- Insert data into books table (passenger bookings)
INSERT INTO books (SSN, flight_id)
VALUES
('123456789', 'FL123'),
('234567890', 'FL456'),
('345678901', 'FL789'),
('456789012', 'FL012'),
('567890123', 'FL345'),
('678901234', 'FL678'),
('789012345', 'FL901'),
('890123456', 'FL234'),
('901234567', 'FL567'),
('012345678', 'FL890');

-- Insert data into manages table (airline-flight management)
INSERT INTO manages (airline_name, flight_id)
VALUES
('Delta Airlines', 'FL123'),
('United Airlines', 'FL456'),
('American Airlines', 'FL789'),
('Southwest Airlines', 'FL012'),
('JetBlue Airways', 'FL345'),
('Alaska Airlines', 'FL678'),
('Spirit Airlines', 'FL901'),
('Frontier Airlines', 'FL234'),
('Hawaiian Airlines', 'FL567'),
('Allegiant Air', 'FL890');

INSERT INTO BUYS (SSN, ticket_id)
VALUES
('123456789', 'T123'),
('234567890', 'T456'),
('345678901', 'T789'),
('456789012', 'T012'),
('567890123', 'T345'),
('678901234', 'T678'),
('789012345', 'T901'),
('890123456', 'T234'),
('901234567', 'T567'),
('012345678', 'T890');

-- Insert data into assigned table (airplane assignments to flights)
INSERT INTO assigned (flight_id, airplane_id)
VALUES
('FL123', 'A123'),
('FL456', 'B456'),
('FL789', 'C789'),
('FL012', 'D012'),
('FL345', 'E345'),
('FL678', 'F678'),
('FL901', 'G901'),
('FL234', 'H234'),
('FL567', 'I567'),
('FL890', 'J890');


-- Insert data into Entitled_baggage table
INSERT INTO BaggageInfo (baggage_id, weight, insurance)
VALUES
('BAG001', 20, 'Yes'),
('BAG002', 15, 'No'),
('BAG003', 18, 'Yes'),
('BAG004', 22, 'Yes'),
('BAG005', 25, 'No'),
('BAG006', 17, 'Yes'),
('BAG007', 21, 'No'),
('BAG008', 19, 'Yes'),
('BAG009', 23, 'Yes'),
('BAG010', 16, 'No');

INSERT INTO BaggageRef (ticket_id, baggage_id)
VALUES
('T123', 'BAG001'),
('T456', 'BAG002'),
('T789', 'BAG003'),
('T012', 'BAG004'),
('T345', 'BAG005'),
('T678', 'BAG006'),
('T901', 'BAG007'),
('T234', 'BAG008'),
('T567', 'BAG009'),
('T890', 'BAG010');

-- Insert data into Abroad table
INSERT INTO Abroad (flight_id, abroad_from, abroad_to, visa_restriction)
VALUES
('FL123', 'New York', 'London', 'Required'),
('FL456', 'Los Angeles', 'Tokyo', 'Not Required'),
('FL789', 'Chicago', 'Paris', 'Required'),
('FL012', 'Miami', 'Rome', 'Not Required'),
('FL345', 'San Francisco', 'Sydney', 'Required'),
('FL678', 'Seattle', 'Dubai', 'Required'),
('FL901', 'Denver', 'Mexico City', 'Not Required'),
('FL234', 'Boston', 'Berlin', 'Required'),
('FL567', 'Atlanta', 'Toronto', 'Not Required'),
('FL890', 'Las Vegas', 'Honolulu', 'Not Required');

-- Insert data into Domestic table
INSERT INTO Domestic (flight_id, domestic_from, domestic_to)
VALUES
('FL123', 'New York', 'Los Angeles'),
('FL456', 'Los Angeles', 'Chicago'),
('FL789', 'Chicago', 'Miami'),
('FL012', 'Miami', 'San Francisco'),
('FL345', 'San Francisco', 'Seattle'),
('FL678', 'Seattle', 'Denver'),
('FL901', 'Denver', 'Boston'),
('FL234', 'Boston', 'Atlanta'),
('FL567', 'Atlanta', 'Las Vegas'),
('FL890', 'Las Vegas', 'New York');

-- Commit the transaction to save the changes permanently
COMMIT;

