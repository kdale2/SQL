/* Practice with Basic SQL Operators */

/*1. List car rental companies which have a mileage of at least 27 miles/gallon. */

SELECT tid, rentalcompany
FROM bycar
WHERE mileage >= 27;

/*2. List trip IDs taken on train costing strictly more than $150. */

SELECT TID
FROM trips
WHERE travelmode = 'Train' and fare > 150;

/*3. Find trip IDs and their fare that are not taken in the US i.e., `Non-US` trips. */

SELECT tid, fare
FROM trips
WHERE tripstate = 'Non-US';

/*4. Find the business class plane trip IDs that are greater than $1000. */

SELECT t.tid
FROM byplane p, trips t
where p.tid = t.tid and p.class = 'Business' and t.fare > 1000;

/*5. Find any car trip more expensive than a trip taken on a train. */

SELECT tid
FROM trips
WHERE travelmode = 'Car' and fare > ANY (SELECT fare FROM trips WHERE travelmode = 'Train');

/* 6. List pairs of distinct (gotta be car)trips that have exactly the same
value of mileage. ?
Note a pair of distinct trips is of the format: (TID1, TID2).
This distinct pair is not the same as the pair (TID2, TID1) */

SELECT distinct c1.tid, c2.tid
FROM bycar c1, bycar c2
WHERE c1.mileage = c2.mileage AND c1.tid != c2.tid;

/*7. List pairs of distinct train trips that do not have the same speed. */

SELECT distinct t1.tid, t2.tid
FROM bytrain t1, bytrain t2
WHERE t1.trainspeed != t2.trainspeed;

/* 8. Find those pair of trips in the same state with the same mode of travel. 
List such pairs only once. In other words, given a pair (TID1,TID2) do NOT list (TID2,TID1).*/

SELECT t1.tid, t2.tid, t1.tripstate, t2.tripstate
FROM trips t1, trips t2
WHERE t1.tripstate = t2.tripstate and t1.travelmode = t2.travelmode
and t1.tid > t2.tid;

/* 9. Find a state in which trips have been taken by all three modes of 
transportation: train, plane, and car.
*OUTPUT IS INCORRECT*/

SELECT DISTINCT tripstate FROM trips where travelmode= 'Train'
INTERSECT
SELECT DISTINCT tripstate FROM trips where travelmode= 'Plane'
INTERSECT
SELECT DISTINCT tripstate FROM trips where travelmode= 'Car';
