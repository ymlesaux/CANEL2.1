const {pool} = require('./db')
const organisations = require('./organisation') 

async function testGetOrganisation() {
	let lReq = { query: {}}

	console.log ("*************************************")
	console.log ("*** Organisation avec code = 'MI' ***")
	console.log ("*************************************")
	lReq.query.code = "DGGN"

	let lResults = await organisations.getOrganisations(pool, lReq)
	console.log ("testGetOrganisation() received "+lResults.length+" organisations")
	lResults.forEach ((pOrg, pIndex) => {
		console.log("Org ["+pIndex+"]: "+JSON.stringify(pOrg))
	})
	
	delete lReq.query.code

	console.log ("**********************************")
	console.log ("*** Liste organisations racine ***")
	console.log ("**********************************")
	lReq.query.noparent = true

	let lResults2 = await organisations.getOrganisations(pool, lReq)
	console.log ("getOrganisations() returned "+lResults2.length+" organisations")
	lResults2.forEach ((pOrg, pIndex) => {
		console.log("Org ["+pIndex+"]: "+JSON.stringify(pOrg))
	})
	delete lReq.query.noparent


	console.log ("****************************************")
	console.log ("*** Liste organisations paginée à 10 ***")
	console.log ("****************************************")
	lReq.query.currentPage = 1
	lReq.query.maxPerPage = 10

	let lResults3 = await organisations.getOrganisations(pool, lReq)
	console.log ("getOrganisations() returned "+lResults3.length+" organisations")
	lResults3.forEach ((pOrg, pIndex) => {
		console.log("Org ["+pIndex+"]: "+JSON.stringify(pOrg))
	})
	delete lReq.query.currentPage
	delete lReq.query.maxPerPage


	console.log ("**********************************")
	console.log ("*** Liste organisations page 2 ***")
	console.log ("**********************************")
	lReq.query.currentPage = 2
	lReq.query.maxPerPage = 10

	let lResults4 = await organisations.getOrganisations(pool, lReq)
	console.log ("getOrganisations() returned "+lResults4.length+" organisations")
	lResults4.forEach ((pOrg, pIndex) => {
		console.log("Org ["+pIndex+"]: "+JSON.stringify(pOrg))
	})
	delete lReq.query.currentPage
	delete lReq.query.maxPerPage

	pool.end()

}

testGetOrganisation()
