const cors = require('cors');const express = require('express')const app = express()app.use(cors());const port = 3000const mysql = require('mysql');const connection = mysql.createConnection({    host :'localhost',    user :'root',    password :'123456',    port :'3306',    database :'TakeoutDatabase'})connection.connect();app.get('/history',(req,res)=>{    let userid = req.query.userid;    let data = [];    connection.query(`SELECT * FROM Orders WHERE UserID=${userid}`, function(err,rows,fields){        if (err) throw err;        for(let i=0; i<rows.length;i++){            console.log('the datas: '+ rows[i].ID + ' ' + rows[i].CreateTime);            connection.query(`SELECT * FROM OrderDetails WHERE OrderID=${rows[i].ID}`, function (err,rows,fields){                if (err) throw err;                    for(let n=0; n<rows.length; n++){                        console.log('the datas2: ' + JSON.stringify(rows[n]));                        connection.query(`SELECT * FROM Food WHERE ID=${rows[n].FoodID}`, function (err,rows,fields){                            if(err) throw err;                            for(let m=0; m<rows.length;m++){                                console.log('the datas3: '+JSON.stringify(rows[m]));                            }                        })                    }            })        }    })})app.get('/test',(req,res)=>{    let userid = req.query.userid;    connection.query(`SELECT u.ID, CreateTime,f.FoodName, od.Price, od.Quantity FROM Orders o JOIN Users u ON o.UserID = u.ID JOIN OrderDetails od ON o.ID = od.OrderID  JOIN Food f ON od.FoodID = f.ID WHERE UserID=${userid} ORDER BY CreateTime`, function(err,rows,fields){        if (err) throw err;        for(let i=0; i<rows.length;i++){            console.log('the datas: '+ rows[i].ID + ' ' + rows[i].CreateTime);        }        res.send(JSON.stringify(rows));    })})app.get('/', (req, res) => {    connection.query('SELECT * FROM Food',function(err,rows,fields){        if (err) throw err        console.log('The solution is: ', JSON.stringify(rows[0]))    })    res.send('Hello World!')})app.get('/pay',(req,res)=>{    let param = req.query.paymoney;    param = JSON.parse(param);    let foods = param.foods;    connection.query('SELECT MAX(ID) as orderid FROM Orders',function (err,rows,fields){        if(err) throw err        let orderid = rows[0].orderid;        console.log('the orderid is ',orderid);        console.log('foods:',JSON.stringify(foods));        for (let i=0;i<foods.length;i++){            let foodid=foods[i].foodID;            let price=foods[i].price;            let quantity=foods[i].quantity;            connection.query(`INSERT INTO OrderDetails(FoodID,OrderID,Price,Quantity) VALUES(${foodid},${orderid},${price},${quantity})`, function(err,row,fields){                if(err) throw err;                console.log("input good");            } );        }    });    res.send("hello");})app.listen(port, () => {    console.log(`Example app listening at http://localhost:${port}`)})process.on( 'SIGINT', function() {    console.log( "\nGracefully shutting down from SIGINT (Ctrl-C)" );    // some other closing procedures go here    connection.end();    process.exit( );})