Create Database if not exists `travel-directory` ;
use `travel-directory`;



create table if not exists `passenger`(
`PASSENGER_NAME` varchar(50) primary key,
`CATEGORY` varchar(50) ,
`GENDER`  CHAR ,
`BOARDING_CITY` varchar(50) ,
`DESTINATION_CITY` varchar(50) ,
`DISTANCE` INT ,
`BUS_TYPE` VARCHAR(50)
);




CREATE TABLE IF NOT EXISTS `price` (
  `BUS_TYPE` VARCHAR(50) ,
  `DISTANCE` INT ,
  `PRICE` INT 
 --  FOREIGN KEY (`BUS_TYPE`) REFERENCES PASSENGER (`BUS_TYPE`),
--   FOREIGN KEY (`DISTANCE`) REFERENCES PASSENGER (`DISTANCE`)
  );
 






  
INSERT INTO `PASSENGER` VALUES("SEJAL",'AC','f',"Bengaluru","Chennai",'350',"Sleeper");
INSERT INTO `PASSENGER` VALUES("Anmol",'Non-AC','M',"Mumbai","Hyderabad",'700',"Sitting");
INSERT INTO `PASSENGER` VALUES("Pallavi",'AC','F',"Panaji","Bengaluru",'600',"Sleeper");
INSERT INTO `PASSENGER` VALUES("Khusboo",'AC','F',"Chennai","Mumbai",'1500',"Sleeper");
INSERT INTO `PASSENGER` VALUES("Udit",'Non-AC','M',"Trivandrum","Panaji",'1000',"Sleeper");
INSERT INTO `PASSENGER` VALUES("Ankur",'AC','M',"Nagur","Hyderabad",'500',"Sitting");
INSERT INTO `PASSENGER` VALUES("Hemant",'Non-AC','M',"Panaji","Mumbai",'700',"Sleeper");
INSERT INTO `PASSENGER` VALUES("Manish",'Non-AC','M',"Hyderabad","Bengaluru",'500',"Sitting");
INSERT INTO `PASSENGER` VALUES("Piyush",'AC','M',"Pune","Nagpur",'700',"Sitting");



  

  
INSERT INTO `PRICE` VALUES("Sleeper" ,'350' ,'770');
INSERT INTO `PRICE` VALUES("Sleeper" ,'500' ,'1100');
INSERT INTO `PRICE` VALUES("Sleeper" ,'600' ,'1320');
INSERT INTO `PRICE` VALUES("Sleeper" ,'700' ,'1540');
INSERT INTO `PRICE` VALUES("Sleeper" ,'1000' ,'2200');
INSERT INTO `PRICE` VALUES("Sleeper" ,'1200' ,'2640');
INSERT INTO `PRICE` VALUES("Sleeper" ,'350' ,'434');
INSERT INTO `PRICE` VALUES("Sitting" ,'500' ,'620');
INSERT INTO `PRICE` VALUES("Sitting" ,'500' ,'620');
INSERT INTO `PRICE` VALUES("Sitting" ,'600' ,'744');
INSERT INTO `PRICE` VALUES("Sitting" ,'700' ,'868');
INSERT INTO `PRICE` VALUES("Sitting" ,'1000' ,'1240');
INSERT INTO `PRICE` VALUES("Sitting" ,'1200' ,'1488');
INSERT INTO `PRICE` VALUES("Sitting" ,'1500' ,'1860');


#3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?

select p.GENDER, count(p.GENDER)
FROM Passenger p
where distance >= 600
group by gender;

#4) Find the minimum ticket price for Sleeper Bus.

select min(price) from Price
where bus_type = 'sleeper';

#5) Select passenger names whose names start with character 'S'

select passenger_name from Passenger
where passenger_name like 's%';

#6) Calculate price charged for each passenger displaying #Passenger name, Boarding City, Destination City, Bus_Type, Price 
#in the output

select Passenger_name, Boarding_City, Destination_City, Pgr.Bus_Type, Price from Passenger Pgr
inner join Price Prc
on Pgr.bus_type = Prc.bus_type and Pgr.distance = Prc.distance;

#7) What is the passenger name and his/her ticket price who #travelled in Sitting bus for a distance of 1000 KM s

select passenger_name, price from Passenger Pgr
inner join Price Prc
on Pgr.bus_type = Prc.bus_type and Pgr.distance = Prc.distance
where Pgr.distance = 1000 and Pgr.bus_type = 'Sitting';

#8) What will be the Sitting and Sleeper bus charge for Pallavi #to travel from Bangalore to Panaji?


select BUS_TYPE, Price from price
where price.distance = (select distance from passenger where passenger_name = 'Pallavi');


#9) List the distances from the "Passenger" table which are #unique (non-repeated distances) in descending order.

select distance from  Passenger
group by distance
order by distance desc;

#10) Display the passenger name and percentage of distance #travelled by that passenger from the total distance travelled by
 #all passengers without using user variables  

select passenger_name, (distance / (select sum(distance) from passenger) * 100) percentage from passenger;

#11) Display the distance, price in three categories in table #Price
#a) Expensive if the cost is more than 1000
#b) Average Cost if the cost is less than 1000 and greater than 
#500
#c) Cheap otherwise

delimiter &&
create procedure proc()
begin
select Distance, Price,
case
when price>1000 then 'Expensive'
when price<1000 and price>500 then 'Average Cost'
else 'Cheap'
end as Cost
from Price  ;
end &&

call proc();

