const express = require('express')
const { pool } = require('./db')

const app = express()

async function getOrganisations(req, res) {
  try {
    /*
      Analyse des arguments de l'URL pour récupérer les filtres
    */
    const res = await pool.query("SELECT * FROM ORG_organisationUnit");

    /*
      lecture ligne à ligne pour mapper les valeurs sur les attributs de l'API
    */
    
    console.log(res.rows);
  } catch (error) {
    console.error(error);
  }
}

app.get('/applications', (req,res) => {
  res.send("Liste des applications")
})

app.get('/applications/:id', (req,res) => {
  const id = parseInt(req.params.id)    
  res.send("Application " + id)
})

app.get('/organisations', (req,res) => {
  getOrganisations(req, res) 
  res.send("Liste des organsiations")
})

app.listen(8080, () => {    console.log("Serveur à l'écoute")})

const { Client } = require('pg')
