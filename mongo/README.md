# MongoDB

---

## Database and Collections creation

* ### Devueltos 2020 (encoded)

  * `mongoimport -d devueltosDB -c devueltos_2020_encoded --type csv --file devueltos_2020.csv --headerline`

* ### Devueltos 2020 (decoded)

  * `mongoimport -d devueltosDB -c devueltos_2020_decoded --type csv --file devueltos_2020.csv --headerline`

---

## Encoded collection query export to CSV

* `mongoexport -d devueltosDB -c devueltos_2020_encoded -q=queryOutput  --out=exportdir/myRecords.json`
