const {pool} = require('./db')

function getPagingParameters (pReq) {
	let lRqt = ""
	/* Complete the query with limit and offset to manage the pagination */
	if ('maxPerPage' in pReq.query) {
		let lLimit = parseInt(pReq.query.maxPerPage)
		lRqt += " limit "+pReq.query.maxPerPage
		if ('currentPage' in pReq.query) {
			let lOffset = parseInt(pReq.query.currentPage)
			if (lOffset > 1) {
				lOffset = (lOffset-1) * lLimit
				lRqt += " offset "+lOffset
			} else {
				lRqt += " offset 0"
			}
		}
	}

	return (lRqt)
}

function getOrganisationBuidQuery (pReq) {
	let lBaseRqt = 'select * from ORG_organisationUnit'
	let lCriteriaList = []

	let lRqt
	lRqt = lBaseRqt
	if ('params' in pReq) {
		lCriteriaList.push("organisationunitid='" + pReq.params.id + "'")
	}
	if ('query' in pReq) {
		if ('nom' in pReq.query) {
			lCriteriaList.push("label='" + pReq.query.nom + "'")
		}
		if ('code' in pReq.query) {
			lCriteriaList.push("organisationCode='" + pReq.query.code + "'")
		}
		if ('noparent' in pReq.query) {
			lCriteriaList.push("parentId is null")
		}
		lCriteriaList.forEach ((pCriteria, pIndex) => {
			if (lRqt === lBaseRqt) {
				lRqt += " where "
			} else {
				lRqt += " and "
			}
			lRqt += pCriteria
		})
	}

	return (lRqt)
}

async function getOrganisations(pPool, pReq) {
	let lReturn = []
	let lRqt = ""

	lRqt = getOrganisationBuidQuery(pReq) + getPagingParameters(pReq)

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

		} catch (err) {
			console.error("Error executing query ("+lRqt+"): ", err)
		} finally {
			lClient.release()
		}
	} catch (errCnx) {
		console.error ("getOrganisations() failed to connect to db: "+errCnx)
	} finally {
		console.log ("getOrganisations() returns "+lReturn.length+" organisations")
	}
	return (lReturn)	


}

async function postOrganisation (pPool, pReq) {
	let lRqtFields = 'insert into ORG_organisationUnit ('
	let lRqtValues = ') values ('
	let lRqtClose = ')'

	/*
	**	JSON Processing to get data to insert 
	*/
	let lPostedData = pReq.body

	/* Mandatory fields from the YAML */
	if ('nomApplication' in lPostedData) {
		lRqtFields += "longName"
		lRqtValues += '"'+lPostedData.nomApplication+'"'
	} else {
		throw new Error('Missing field "nomApplication" for application object')
	}
	if ('description' in lPostedData) {
		lRqtFields += ", description"
		lRqtValues += ', "'+lPostedData.description+'"'
	} else {
		throw new Error('Missing field "description" for application object')
	}
	if ('status' in lPostedData) {
		lRqtFields += ", status"
		lRqtValues += ', "'+lPostedData.status+'"'
	} else {
		throw new Error('Missing field "status" for application object')
	}

	/* Optional fields from the YAML */

	/* Technical Fields */



	/*
	** Insert processing
	*/
	let lRqt = lRqtFields + lRqtValues + lRqtClose

}

module.exports = { getOrganisations }
