const express = require('express');
const superagent = require('superagent');
const jsonParser = require('body-parser').json();

const app = express()

app.use('/', express.static(__dirname + '/static'));

app.get('/project', (req, res) => {
    superagent
        .get('localhost:3000/project?select=' + req.query.select)
        .end((err, response) => res.send(response.body));
});

app.post('/hour_entry', jsonParser, (req, res) => {
    superagent
        .post('localhost:3000/hour_entry')
        .send(req.body)
        .end((err, response) => {
            if(!err) {
                // Elm Json.Decode expects a value so we'll return a list of strings.
                res.send(["OK"]);
            }
            else {
                res.status(err.status).send(err.res);
            }
        });
});

app.patch('/hour_entry', jsonParser, (req, res) => {
    superagent
        .patch(`localhost:3000/hour_entry?date=${req.query.date}&project_id=${req.query.project_id}`)
        .send(req.body)
        .end((err, response) => {
            if(!err) {
                // Elm Json.Decode expects a value so we'll return a list of strings.
                res.send(["OK"]);
            }
            else {
                res.status(err.status).send(err.res);
            }
        });
});

const port = 4000;
app.listen(port);
console.log('Go to http://localhost:' + port);
