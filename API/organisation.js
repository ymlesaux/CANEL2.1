const {pool} = require('./db')

async function getOrganisations(pPool, pReq) {
	var lBaseRqt = 'select * from ORG_organisationUnit'
	var lReturn = []

	/* Adapt the SQL query with filters */
	var lRqt
	lRqt = lBaseRqt
	if ('params' in pReq) {
		if ('id' in pReq.params) {
			if (lRqt === lBaseRqt) {
				lRqt = lRqt + " where "
			} else {
				lRqt = lRqt + " and "
			}
			lRqt = lRqt + "organisationunitid='" + pReq.params.id + "'"
		}
	}
	if ('query' in pReq) {
		if ('nom' in pReq.query) {
			if (lRqt === lBaseRqt) {
				lRqt = lRqt + " where "
			} else {
				lRqt = lRqt + " and "
			}
			lRqt = lRqt + "label='" + pReq.query.nom + "'"
		}
		if ('code' in pReq.query) {
			if (lRqt === lBaseRqt) {
				lRqt = lRqt + " where "
			} else {
				lRqt = lRqt + " and "
			}
			lRqt = lRqt + "organisationCode='" + pReq.query.code + "'"
		}
		if ('noparent' in pReq.query) {
			if (lRqt === lBaseRqt) {
				lRqt = lRqt + " where "
			} else {
				lRqt = lRqt + " and "
			}
			lRqt = lRqt + "parentId is null"
		}
	}

	/* Run the query */
	console.log ("*** getOrganisations(): "+lRqt)

	try {
		const lClient = await pPool.connect()

		try {
			const lResults = await lClient.query(lRqt)
			lResults.rows.forEach (lRow => {
					/* Padding Row results in JSON API object */
					lReturn.push(new Object())
					lReturn[lReturn.length-1].organisationUnitId = lRow.organisationunitid
					lReturn[lReturn.length-1].label = lRow.label
					lReturn[lReturn.length-1].codeOrganisation = lRow.organisationcode
					lReturn[lReturn.length-1].description = lRow.description
					lReturn[lReturn.length-1].parentId = lRow.parentid
					// console.log ("Found OrgUnit: " + JSON.stringify(lReturn[lReturn.length-1]))
		
					/* console.log(lRow) */
				})

		}
		finally {
			lClient.release()
		}
		} catch (err) {
		console.error("Error executing query ("+lRqt+"): ", err)
	} finally {
		pPool.end();
	}

	console.log ("getOrganisations() returns "+lReturn.length+" organisations")
	return (lReturn)	


}

async function testGetOrganisation() {
	var lReq = { query: {}}

	console.log ("*** Organisation avec code = 'MI' ***")
	lReq.query.code = "DGGN"

	var lResults = await getOrganisations(pool, lReq)
	console.log ("testGetOrganisation() received "+lResults.length+" organisations")
	lResults.forEach ((pOrg, pIndex) => {
		console.log("Org ["+pIndex+"]: "+JSON.stringify(pOrg))
	})
	
	delete lReq.query.code
/*
	console.log ("*** Liste organisations racine ***")
	lReq.query.noparent = true

	var lResults2 = getOrganisations(pool, lReq)
	for (let i=lResults2.length - 1; i>0 ; i--) {
		console.log(JSON.stringify(lResults2[i]))
	}
	delete lReq.query.noparent
*/
}

testGetOrganisation()
