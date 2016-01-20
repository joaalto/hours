const express = require('express');
const superagent = require('superagent');
const jsonParser = require('body-parser').json();

const app = express()

app.use('/', express.static(__dirname + '/static'));

app.get('/project', (request, response) => {
    superagent
        .get('localhost:3000/project?select=' + request.query.select)
        .end((err, res) => response.send(res.body));
});

app.post('/hour_entry', jsonParser, (request, response) => {
    superagent
        .post('localhost:3000/hour_entry')
        .set('Prefer', request.get('Prefer'))
        .send(request.body)
        .end((err, res) => {
            if(!err) {
                response.send(res.body);
            }
            else {
                response.status(err.status).send(err.response);
            }
        });
});

app.patch('/hour_entry', jsonParser, (request, response) => {
    superagent
        .patch(`localhost:3000/hour_entry?date=${request.query.date}&project_id=${request.query.project_id}`)
        .set('Prefer', request.get('Prefer'))
        .send(request.body)
        .end((err, res) => {
            if(!err) {
                response.send(res.body);
            }
            else {
                response.status(err.status).send(err.response);
            }
        });
});

const port = 4000;
app.listen(port);
console.log('Express server listening on port ' + port);
