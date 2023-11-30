const express = require('express');
const path = require('path');

const app = express();



app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/signin.html'));
})

app.get('/index', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/index.html'));
})

app.get('/settings', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/settings.html'));
})

app.get('/equipment', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/equipment.html'));
})

app.get('/book', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/book.html'));
})

app.get('/programs', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/programs.html'));
})

app.get('/adminsignin', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/adminsignin.html'));
})


const port = process.env.PORT || 3000;

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});