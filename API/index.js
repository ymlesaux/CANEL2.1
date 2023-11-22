const express = require('express')
const { pool } = require('./db')
const organisations = require('./organisation') 


const app = express()

app.get('/applications', (req,res) => {
  res.send("Liste des applications")
})

app.get('/applications/:id', (req,res) => {
  var id = parseInt(req.params.id)    
  res.send("Application " + id)
})

app.get('/organisations', async (req,res) => {
  var id = parseInt(req.params.id)
  var lOrganisations = await organisations.getOrganisations(pool, req)
  //res.send("Liste des organisations: "+req.query+"***")
  res.json(lOrganisations)
})

app.get('/organisations/:id', (req,res) => {
  var id = parseInt(req.params.id)    
  res.send("Organisation: "+req.query+"***")
})

app.listen(8080, () => {    console.log("Serveur à l'écoute")})

