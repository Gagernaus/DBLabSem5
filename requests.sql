
SELECT * FROM item WHERE mass>100 ORDER BY mass;

SELECT orderid, registrationdate FROM "Order"
    WHERE registrationdate>date '2021\06\15'
        ORDER BY registrationdate DESC;

SELECT transferid, date, type FROM transfer WHERE type=2 ORDER BY transferid;

SELECT truckid, COUNT(truckid) FROM transfer GROUP BY truckid;


WITH connected as(
    SELECT * FROM schedule
        JOIN assignedmoover mooverscheduel on schedule.scheduleid = mooverscheduel.scheduleid
            WHERE weekday=2
), psprts as (
    SELECT * FROM moovers
        JOIN passport pas on pas.passportid = moovers.passportid
) SELECT psprts.mooverid, psprts.givenname, psprts.surname, psprts.patronymic FROM psprts
    JOIN connected on connected.mooverid = psprts.mooverid
        ORDER BY mooverid DESC;

WITH volume AS(
    SELECT warehouse.warehouseid, warehouse.address, warehouse.numberofrows*warehouse.rowsize*warehouse.shelfsize as total FROM warehouse
), maximum AS (
    SELECT MAX(total) as maximum FROM volume
) SELECT warehouseid, total, address FROM volume JOIN maximum on 1=1
    WHERE total=maximum;

WITH itemcost AS(
    SELECT orderid, price FROM item
        JOIN tariffs t on t.tariffid = item.tarifid AND item.storagestatus!=4
) SELECT "Order".orderid, sum(it.price) FROM "Order" JOIN itemcost it on it.orderid="Order".orderid
    GROUP BY "Order".orderid ORDER BY "Order".orderid;