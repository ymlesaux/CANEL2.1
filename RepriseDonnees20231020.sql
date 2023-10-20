-------------------------------------------------------------------------------------------------------------------
-- Ajout Organismes
-------------------------------------------------------------------------------------------------------------------
-- ANTS - organisme racine
-- MIOMs: grands subordonnés du MIOM
-- WORLDLINE - Ex ATOS: plateforme de télépaiement
-------------------------------------------------------------------------------------------------------------------

insert into ORG_OrganisationUnit(organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	"ANTS", "Agence Nationale des Titres Sécurisés",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into ORG_OrganisationUnit(parentId, organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "MI"),
	"DSR", "Direction de la Sécurité Routière",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(parentId, organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "MI"),
	"DGCL", "Direction Générale des Collectivités Locales",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(parentId, organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "MI"),
	"DGEF", "Direction Générale des Etranngers en France",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(parentId, organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "MI"),
	"DGGN", "Direction Générale de la Gendarmerie Nationale",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(parentId, organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "MI"),
	"DGPN", "Direction Générale de la Police Nationale",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(parentId, organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "MI"),
	"DGSCGC", "Direction Générale de la Sécurité Civile et de la Gestion des Crises",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(parentId, organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "MI"),
	"DGSI", "Direction Générale de la Sécurité Intérieure",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(parentId, organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "MI"),
	"SGMI", "Secrétariat Général du Ministère de l'Intérieur et des Outre-Mers",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(parentId, organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "SGMI"),
	"DTNUM", "Direction de la Transformation Numérique",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	"WOLRDLINE", "ex ATOS WorldLine",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	"INSEE", "Institut National de la Statistique et des Etudes Economiques",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
insert into ORG_OrganisationUnit(organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	"LA POSTE", "Groupe La Poste",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);


-------------------------------------------------------------------------------------------------------------------
-- Création application SIV et applications composantes
-------------------------------------------------------------------------------------------------------------------

insert into APP_Application (longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) 	values (
	"SIV", 
	"SIV, Système d’Immatriculation des Véhicules, Il assure le suivi de toutes les informations concernant les pièces administratives exigées pour la circulation des véhicules ou affectant la disponibilité de ceux-ci. Gérer les pièces administratives du droit de circuler des véhicules sur les voies ouvertes à la circulation publique.<br>- Données d'identification des professionnels habilités dans le cadre du système d'immatriculation des véhicules.Le Système d’immatriculation des véhicules (SIV) contient les données concernant les titres liés aux véhicules (historique de chaque véhicule, caractéristiques techniques, situation administrative, informations sur Titulaire/ Co-Titulaire/ Locataire/ Loueur/ Créancier/Acquéreur/Broyeur). Le système contient 11 schémas : SIV, IVT, APD, SIT, SVV, SVJ, IVJ, IVH, IE IVI_CONF, IE IVI_SUIVI. MOE : ANTS.<br>- Données d'identification du titulaire du certificat d'immatriculation du véhicule.<br>- Adresse du titulaire du certificat d'immatriculation du véhicule .<br>- Données relatives au véhicule et à l'autorisation de circuler du véhicule. (gérer le système d'immatriculation caractérisé par l'attribution à vie d'un numéro à un véhicule, quel qu'en soit le titulaire)<br><br>Le Système d’immatriculation des véhicules (SIV) contient les données concernant les titres liés aux véhicules (historique de chaque véhicule, caractéristiques techniques, situation administrative, informations sur Titulaire/ Co-Titulaire/ Locataire/ Loueur/ Créancier/Acquéreur/Broyeur).<br><br>Le système contient 11 schémas : SIV, IVT, APD, SIT, SVV, SVJ, IVJ, IVH, IE IVI_CONF, IE IVI_SUIVI.<br><br>MOE : ANTS.",
	"PRD", "S3", "SVBUS", 
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
	
insert into APP_ApplicationId (applicationId, applicationIdTypeCode, shortCode, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"CANEL1", "9EDShgtkXHRK",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_ApplicationId (applicationId, applicationIdTypeCode, shortCode, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"PAI", "SIV",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"SIV Coeur",
	"Coeur du Système d'Imatriculation de Véhicule<br>Module cœur de l'application SIV. Il prend en charge les interactions avec les CERT et avec les derniers guichets en préfectures (conservés pour les demandes très particulières). Il fonctionne en parallèle avec le module "SIV PPNG" mis en service en 2017 lors de la mise en œuvre du Programme Préfecture Nouvelle Génération.",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"SIV PPNG",
	"SIV - Extension PPNG 2017<br>SIV PPNG est le module applicatif mettant en œuvre les téléservices usager du programme préfectures nouvelle génération (PPNG) de 2017.",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"Dépot NAS",
	"SIV - Dépôt pour pièces justificatives",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"SIV Journalisation",
	"Journalisation fonctionnelle pour SIV coeur et PPNG",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"MASCADIA",
	"Mise des adresses à la norme AFNOR<br>Ce composant correspond à une application à part entière fournie par La Poste. L’ensemble des services de vérification et de validation de cette application sont packagés sous forme d’un webservice optimisé pour supporter une forte volumétrie.<br>Les interfaces sont les suivantes :<br>- contrôle de l’adresse fournie par rapport à la norme AFNOR<br>- transformation d’une adresse au format selon la norme AFNOR",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"SATVV",
	"Base Satellite des Véhicules Volés<br><br>Extrait de l'arrêté du 10 décembre 2008 (consolidé le 2 juillet 2018).<br>Base satellite VV a pour finalités d'accéder aux informations relatives à l’état de vol et de mise sous surveillance d’un véhicule afin :<br>- d’informer les agents des autorités administratives mentionnées au troisième alinéa de l’article 3, pour les besoins exclusifs de leurs missions, de l’état de vol d’un véhicule ;<br>- d’informer les services de police et de gendarmerie nationales compétents de la nature des opérations d’immatriculation effectuées sur un véhicule surveillé.<br><br>Dans le cadre des finalités prévues à l'article 1er, le présent traitement peut faire l'objet d'interconnexion, mise en relation ou rapprochement avec :<br>- le système d'immatriculation des véhicules (SIV) ;<br>- le fichier des véhicules volés (FVV) ;<br>- le système de contrôle automatisé (CSA) ;<br>- le système d'information Schengen (SIS).<br><br>Les catégories de données enregistrées dans le traitement sont les suivantes :<br>- caractéristiques permettant l'identification du véhicule (numéro d'immatriculation, numéro diplomatique, numéro VIN, marque) ;<br>- état et date de vol du véhicule, code du service à l'origine de cet état, le cas échéant, la date de découverte du véhicule ainsi que le code du service à l'origine de la découverte ;<br>- état et date de mise sous surveillance d'un véhicule, code du service à l'origine de cet état, la nature, la date, l'heure de l'opération effectuée sur le véhicule surveillé ainsi que le code partenaire ou le code préfecture de l'opération",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"SIV Client TESA",
	"Prise en charge des terminaux embarqués de la police et de la gendarmerie.",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"DCVI",
	"Dispositif de Contrôle de Validité des Immatriculations (DCVI) : service sur mesure pour les forces de l’ordre leur permettant de consulter les données du Système d'Immatriculation des Véhicules (SIV) quand celui-ci n’est pas opérationnel (maintenance programmée ou panne).",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"SMD",
	"Système de Mise à Disposition des données<br>Extraction de base SIV à des fin de vente des informations d'immatriculation sous licence. Par exemple AAA.<br><br>Ce module de SIV est hébergé au SIR à Rosny. Les bases sont répliquées de baie à baie (miroir) à partir des bases du SIV qui sont répliquées à Rosny.",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"IVG Infocentre SIV",
	"",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"SIV Gestion des Accès utilisateurs",
	"SIV - Annuaire avec authentification et autorisation des utilisateurs<br>Annuaire LDAP et logiciel de contrôle d'accès développé par BULL. Gérant des authentifications et des habilitations des utilisateurs du SIV et du SIT (hors personnel PN et GN) et des certificats des partenaires.",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"SIV APD",
	"SIV - Application des Pré-Demandes d'habilitation et d'agrément<br>Application de Pré-Demande d'habilitation et d'agrément des partenaires de l'immatriculation",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"SIT",
	"SIT (Système d'Information Télépaiement) est la plate-forme de télépaiement du SIV.",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (parentId, longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	"SIT Journalisation",
	"Journalisation fonctionnelle du télépaiement SIT<br>Le module 'SIT Journalisation' met en oeuvre une journalisation fonctionnelle pour le module SIT. Il utilise le même code que le module 'SIV Journalisation' utilisé par SIV Coeur et SIV PPNG.",
	"PRD", "S3", "SVBUS",
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
	
-------------------------------------------------------------------------------------------------------------------
-- Ajout Rôles
-------------------------------------------------------------------------------------------------------------------
-- MOE de SIV: on met le rôle sur le SI tête de chaine, propriété qui est "héritée" par les composants
-------------------------------------------------------------------------------------------------------------------

insert into PRJ_ApplicationRole (applicationId, organisationUnitId, roleId, validationDate, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "ANTS"),
	"MOE",
	CURRENT_DATE + 400,
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into PRJ_ApplicationRole (applicationId, organisationUnitId, roleId, validationDate, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select applicationId from APP_Application where longName="SIV"),
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode = "DSR"),
	"MOA",
	CURRENT_DATE + 400,
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

-------------------------------------------------------------------------------------------------------------------
-- Ajout Applications satellites
-------------------------------------------------------------------------------------------------------------------

insert into APP_Application (longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) 	values (
	"HISTOVEC", 
	"HISTOVEC (historique des véhicules) est un nouveau composant du système d’information lié à l’immatriculation des véhicules (SIV). Il vise à sécuriser les ventes de véhicules d’occasion en permettant au vendeur de consulter les données d’historique de son véhicule et de les partager avec des acheteurs potentiels. HISTOVEC fournit des informations à valeur de certificat en amont de la transaction concernant un véhicule.",
	"PRD", "S3", "SVBUS", 
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="DSR"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) 	values (
	"Portail titre", 
	"Le portail titre de l'ANTS permet aux usagers de réaliser des démarches en ligne concernant les titres dont l'ANTS est en charge : permis de conduire, certificat d'immatriculation du véhicule, CNI et passeport.",
	"PRD", "S3", "SVBUS", 
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="ANTS"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) 	values (
	"GED SID DEMATERIALISATION EN PREFECTURE", 
	"Système d'Information Documentaire,expérimentation gestion dématérialisée du cycle de vie des dossiers administratifs en Préfecture",
	"PRD", "S3", "SVBUS", 
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="MIOM"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) 	values (
	"RNIPP", 
	"Répertoire national d'identification des personnes<br>Le RNIPP est un instrument de vérification de l’état civil des personnes nées en France. Sa consultation permet de préciser si une personne est en vie ou décédée et de connaître son numéro d’inscription au répertoire (NIR).",
	"PRD", "S3", "SVBUS", 
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="INSEE"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) 	values (
	"SIRENE", 
	"API SIRENE exposée par l'INSEE. API Sirene donne accès aux informations concernant les entreprises et les établissements immatriculés au répertoire interadministratif Sirene.",
	"PRD", "S3", "SVBUS", 
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="INSEE"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) 	values (
	"SID", 
	"Système d'Information Décisionnel traitant du fonctionnement du SIV.",
	"PRD", "S3", "SVBUS", 
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="ANTS"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Application (longName, description, status, sensitivity, appType, organisationUnitId, createdBy, createdAt, updatedBy,  updatedAt, comments) 	values (
	"EUCARIS", 
	"EUropean CAr and driving license Information System<br>Plateforme d'échange de données relatives aux immatriculations des véhicules avec les états membres de l'UE dans le cadre de l'accord de PRÜM. Autres appellations : PRÜM-SIV, PRÜM-IMMAT",
	"PRD", "S3", "SVBUS", 
	(select organisationUnitId from ORG_OrganisationUnit where organisationCode="MI"),
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);
	
-------------------------------------------------------------------------------------------------------------------
-- Ajout Flux
-------------------------------------------------------------------------------------------------------------------

insert into APP_Flow (applicationSourceId, applicationTargetId, flowProtocolId, flowPeriodId, flowDataOrientation, comments, createdBy, createdAt, updatedBy,  updatedAt) values (
	(select applicationId from APP_Application where longName="SIV Coeur"),
	(select applicationId from APP_Application where longName="Dépot NAS"),
	"TCP",
	"PRD",
	"push",
	"Dépôts pièces justificatives (CERT)",
	"YMLESAUX", now(), "YMLESAUX", now()
	);

insert into APP_Flow (applicationSourceId, applicationTargetId, flowProtocolId, flowPeriodId, flowDataOrientation, comments, createdBy, createdAt, updatedBy,  updatedAt) values (
	(select applicationId from APP_Application where longName="SIV Coeur"),
	(select applicationId from APP_Application where longName="EUCARIS"),
	"TCP",
	"PRD",
	"push",
	"Interrogation véhicule SIV",
	"YMLESAUX", now(), "YMLESAUX", now()
	);

insert into APP_FlowData (flowId, dataId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select flowId from APP_Flow 
	 where applicationSourceId = (select applicationId from APP_Application where longName="SIV Coeur")
	 and applicationTargetId = (select applicationId from APP_Application where longName="EUCARIS")
	),
	"Caractéristiques véhicule terrestre",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_FlowData (flowId, dataId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select flowId from APP_Flow 
	 where applicationSourceId = (select applicationId from APP_Application where longName="SIV Coeur")
	 and applicationTargetId = (select applicationId from APP_Application where longName="EUCARIS")
	),
	"Numéro chassis",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_FlowData (flowId, dataId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select flowId from APP_Flow 
	 where applicationSourceId = (select applicationId from APP_Application where longName="SIV Coeur")
	 and applicationTargetId = (select applicationId from APP_Application where longName="EUCARIS")
	),
	"Numéro immatriculation",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_FlowData (flowId, dataId, createdBy, createdAt, updatedBy,  updatedAt, comments) values (
	(select flowId from APP_Flow 
	 where applicationSourceId = (select applicationId from APP_Application where longName="SIV Coeur")
	 and applicationTargetId = (select applicationId from APP_Application where longName="EUCARIS")
	),
	"Titulaire droit à circuler",
	"YMLESAUX", now(), "YMLESAUX", now(), "Initialisation données 20231020"
	);

insert into APP_Flow (applicationSourceId, applicationTargetId, flowProtocolId, flowPeriodId, flowDataOrientation, comments, createdBy, createdAt, updatedBy,  updatedAt) values (
	(select applicationId from APP_Application where longName="SIV Coeur"),
	(select applicationId from APP_Application where longName="GED SID DEMATERIALISATION EN PREFECTURE"),
	"TCP",
	"PRD",
	"push",
	"Capture information CIV pour feuille index",
	"YMLESAUX", now(), "YMLESAUX", now()
	);
	
	
