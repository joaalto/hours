const express = require('express');
const superagent = require('superagent');

const app = express()

app.use('/', express.static(__dirname + '/static'));

app.get('/project', (request, response) => {
    superagent
        .get('localhost:3000/project?select=' + request.query.select)
        .end((err, res) => response.send(res.body));
});

const port = 4000;
app.listen(port);
console.log('server listening on port ' + port);
