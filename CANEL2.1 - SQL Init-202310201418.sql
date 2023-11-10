--================================================================================================
-- Script de création de la base CANEL2.1
--================================================================================================
-- Principes généraux d'écriture:
--------------------------------------------------------------------------------------------------
-- Nommage des objets
--    Les objets créés sont préfixés par un trigramme représentant un domaine conceptuel
--    tables: <PREFIXE>_<NomTable>
--    attributs: nomAttribut
--        un nom d'identifiant finit par 'Id'
--        un attribut de lien porte le même nom que l'attribut de la table de référence
--        un attribut de lien de récurence s'appelle 'parentId'
--    type: tout en majuscules
--------------------------------------------------------------------------------------------------
-- Toutes les tables contenant des objets fonctionnels ou des liens entre ceux-ci doivent dériver
-- de la table ABS_Tracability
-- Les données de création sont remplies à la création de l'objet.
-- Les données de modification sont initialisées (à la création) avec les données de modification
-- et modifiées à chaque mise à jour.
-- L'attribut comments est relatif au cycle de vie de l'objet. Pour commenter la nature de l'objet
-- il est impératif de définir un autre attribut (ex: description).
--================================================================================================
-- Domaines conceptuels
--    ABS: objets abstraits destinés uniquement à être dérivés
--    ACT: gestion des acteurs (individus)
--    APP: gestion des applications
--    ENV: gestion des environnements d'hébergement
--    FCT: gestion des fonctionnalités (capacités et urbanisation)
--    ORG: gestion de l'organisation
--    PRJ: gestion des projets
--    PTF: gestion des portefeuilles
--    REF: objets de référence utilisables pour tous les autres domaines
--================================================================================================

create table if not exists ABS_Tracability (
	createdBy varchar(200) NOT NULL, -- filled at object creation
	createdAt timestamp NOT NULL DEFAULT now(),
	updatedBy varchar(200) NOT NULL, -- at object creation, its equal to createdBy
	updatedAt timestamp NOT NULL DEFAULT now(),
	comments text NULL
);

--------------------------------------------------------------------------------------------------
-- Table REF_Sensitivity
--------------------------------------------------------------------------------------------------
-- This table is used by APP_Application about hosting requirements
-- Open Question: should it be applied to application or hosting environments
--------------------------------------------------------------------------------------------------

create table if not exists REF_Sensitivity (
	sensitivityCode varchar(2) PRIMARY KEY,
	label varchar(200) NOT NULL
);

insert into REF_Sensitivity (sensitivityCode, label) values ('S1', 'Standard');
insert into REF_Sensitivity (sensitivityCode, label) values ('S2', 'Sensible');
insert into REF_Sensitivity (sensitivityCode, label) values ('S3', 'Essentiel');
insert into REF_Sensitivity (sensitivityCode, label) values ('S4', 'Importance vitale');

--------------------------------------------------------------------------------------------------
-- Table APP_Status
--------------------------------------------------------------------------------------------------
-- This table is used by APP_Application about application statuses.
-- Warning: this status is not the implementation one, but it is related
--------------------------------------------------------------------------------------------------

create table if not exists APP_Status (
	applicationStatusCode varchar(3) PRIMARY KEY,
	label varchar(100) NOT NULL
);

insert into APP_Status(applicationStatusCode, label) values ('BLD', 'En construction');
insert into APP_Status(applicationStatusCode, label) values ('PRD', 'En production');
insert into APP_Status(applicationStatusCode, label) values ('RTR', 'Retirée du service');
insert into APP_Status(applicationStatusCode, label) values ('DCS', 'Décommissionnée');

--------------------------------------------------------------------------------------------------
-- Table APP_Type
--------------------------------------------------------------------------------------------------
-- This table is used by APP_Application about application typology.
--------------------------------------------------------------------------------------------------

create table if not exists APP_Type (
	applicationTypeCode varchar(5) PRIMARY KEY,
	label varchar(100) NOT NULL
);

insert into APP_Type (applicationTypeCode, label) values ('WBEXT', 'Site de communication Internet');
insert into APP_Type (applicationTypeCode, label) values ('WBINT', 'Site de communication Intranet');
insert into APP_Type (applicationTypeCode, label) values ('SVBUS', 'Service métier');
insert into APP_Type (applicationTypeCode, label) values ('SVTRA', 'Service transverse');
insert into APP_Type (applicationTypeCode, label) values ('SVSCL', 'Service socle');

--------------------------------------------------------------------------------------------------
-- Table APP_IdType
--------------------------------------------------------------------------------------------------
-- This table is used by APP_ApplicationId to segregate Id typology.
-- we designed this to be able to store different id types per application
--------------------------------------------------------------------------------------------------

create table if not exists APP_IdType (
	applicationIdTypeCode varchar(5) PRIMARY KEY,
	label varchar(100) NOT NULL
);

insert into APP_IdType (applicationIdTypeCode, label) values ('PAI', 'identifiant application MIOM');
insert into APP_IdType (applicationIdTypeCode, label) values ('CANL1', 'identifiant Référentiel CANEL1');


--------------------------------------------------------------------------------------------------
-- Table ORG_organisationUnit
--------------------------------------------------------------------------------------------------
-- This table defines organisation units to be associated with actors. It is a recurrent object
-- to be able to get an organisation tree.
-- We initialise it with ministers or top organisations.
--------------------------------------------------------------------------------------------------

create table if not exists ORG_organisationUnit (
	organisationUnitId uuid NOT NULL DEFAULT gen_random_uuid() primary key,
	parentId uuid NULL references ORG_organisationUnit(organisationUnitId),
	organisationCode varchar(5) NOT NULL,
	label text NOT NULL,
	description text NULL
) inherits(ABS_Tracability);

insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MI', 'Ministère de l''intérieur et des outre-mer', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MJ', 'Ministère de la justice', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MA', 'Ministère des armées', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MAE', 'Ministère de l''Europe et des affaires étrangères', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MEN', 'Ministère de l''éducation nationale', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MTE', 'Ministère de la transition écologique', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MEF', 'Ministère de l''économie et des finances', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MC', 'Ministère de la Cuture', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MT', 'Ministère du Travail', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MAG', 'Ministère de l''Agriculture', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MS', 'Ministère de la Santé et de la Prévention', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MES', 'Ministère de l''Enseignement supérieur et de la Recherche', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MSA', 'Ministère des Solidarités, de l''Autonomie et des Personnes handicapées', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MTFP', 'Ministère de la Transformation et de la Fonction publiques', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('MSP', 'Ministère des Sports', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');
insert into ORG_organisationUnit (organisationCode, label, createdBy, createdAt, updatedBy,  updatedAt, comments) values ('PM', 'Premier Ministre', 'Initialisation', now(), 'Initialisation', now(), 'Base creation');

--------------------------------------------------------------------------------------------------
-- Table APP_Application
--------------------------------------------------------------------------------------------------
-- This table stores application objects.
-- this is a recurent object. It means that we don't split application systems, applications or
-- components.
--------------------------------------------------------------------------------------------------

create table if not exists APP_Application (
	applicationId uuid NOT NULL DEFAULT gen_random_uuid() primary key,
	parentId uuid NULL references APP_Application(applicationId),
	longName varchar(100) NOT NULL,
	description text NULL,
	status varchar(3) NOT NULL references APP_Status(applicationStatusCode),
	organisationUnitId uuid NOT NULL references ORG_organisationUnit(organisationUnitId),
	sensitivity varchar(2) NOT NULL references REF_Sensitivity(sensitivityCode),
	appType varchar(5) NOT NULL references APP_Type(applicationTypeCode)
) inherits (ABS_Tracability);

create unique index I_Application on APP_Application (longName, organisationUnitId) nulls not distinct;

--------------------------------------------------------------------------------------------------
-- Table APP_ApplicationId
--------------------------------------------------------------------------------------------------
-- This table stores application identifiers.
--------------------------------------------------------------------------------------------------

create table if not exists APP_ApplicationId (
	applicationId uuid NOT NULL references APP_Application(applicationId),
	applicationIdTypeCode varchar(5) NOT NULL references APP_IdType(applicationIdTypeCode),
	shortCode varchar(20) NOT NULL,
	longCode varchar(200) null,
	primary key (applicationId, applicationIdTypeCode)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table ACT_ActorCodeType
--------------------------------------------------------------------------------------------------
-- This table defines codes family associated to actor
--------------------------------------------------------------------------------------------------

create table if not exists ACT_ActorCodeType (
	actorCodeType varchar(5) PRIMARY KEY,
	label varchar(100) NOT NULL
);

insert into ACT_ActorCodeType (actorCodeType, label) values ('RIO', 'Référentiel des acteurs MIOM');
--------------------------------------------------------------------------------------------------
-- Table ACT_Actor
--------------------------------------------------------------------------------------------------
-- This table defines individual actors.
-- Open Question: the reference to Organisation Unit is optional. Is it relevant ?
--------------------------------------------------------------------------------------------------

create table if not exists ACT_Actor (
	actorId uuid NOT NULL DEFAULT gen_random_uuid() primary key,
	name varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	organisationUnitId uuid NULL references ORG_organisationUnit(organisationUnitId),
	validationDate date NOT NULL
) inherits (ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table ACT_ActorCode
--------------------------------------------------------------------------------------------------
-- This table stores actor's codes from external repositories.
--------------------------------------------------------------------------------------------------

create table if not exists ACT_ActorCode (
	actorId uuid NOT NULL references ACT_Actor(actorId),
	actorCodeType varchar(5) NOT NULL references ACT_ActorCodeType (actorCodeType),
	actorCode varchar(100) NOT NULL,
	primary key (actorid, actorCodeType)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table ORG_RoleType
--------------------------------------------------------------------------------------------------
-- This table defines different roles for actors within application.
-- It is designed to associate actors with applications.
-- Defined into ORG package to prepare reuse with projects or portfolio definitions
--------------------------------------------------------------------------------------------------

create table if not exists ORG_RoleType (
	roleId varchar(5) PRIMARY KEY,
	label varchar(200) NOT NULL
);

insert into ORG_RoleType (roleId, label) values ('CDP', 'Chef de Projet/Product Owner');
insert into ORG_RoleType (roleId, label) values ('MOA', 'MOA/Business Owner');
insert into ORG_RoleType (roleId, label) values ('ASOL', 'Architecte Solution');
insert into ORG_RoleType (roleId, label) values ('AINF', 'Architecte Infra');
insert into ORG_RoleType (roleId, label) values ('MOE', 'MOE');
insert into ORG_RoleType (roleId, label) values ('RPP', 'Resp Production');
insert into ORG_RoleType (roleId, label) values ('SUPT', 'Support');
insert into ORG_RoleType (roleId, label) values ('RSSI', 'RSSI');
insert into ORG_RoleType (roleId, label) values ('SOUSC', 'Souscripteur');

--------------------------------------------------------------------------------------------------
-- Table PRJ_ApplicationRole
--------------------------------------------------------------------------------------------------
-- This table associates applications with actors or organisation with a specific role.
-- we must be able to associate an organisation unit without a physical actor. But when an actor
-- is defined, his organisation unit is also associated here.
-- Open Question: this table belongs to PRJ package, but is not associated with any project.
--------------------------------------------------------------------------------------------------

create table if not exists PRJ_ApplicationRole (
	applicationId uuid NOT NULL references APP_Application(applicationId),
	actorId uuid NULL references ACT_Actor(actorId),
	organisationUnitId uuid NOT NULL references ORG_organisationUnit(organisationUnitId),
	roleId varchar(5) NOT NULL references ORG_RoleType (roleId),
	validationDate date NOT NULL
) inherits(ABS_Tracability);

create unique index I_ApplicationRole on PRJ_ApplicationRole (applicationId, actorId, organisationUnitId, roleId) nulls not distinct;

--------------------------------------------------------------------------------------------------
-- Table APP_FlowType
--------------------------------------------------------------------------------------------------
-- This table defines flow typology
--------------------------------------------------------------------------------------------------

create table if not exists APP_FlowType (
	flowTypeId varchar(5) PRIMARY KEY,
	label varchar(200) NOT NULL
);

insert into APP_FlowType (flowTypeId, label) values ('API-R', 'API REST');
insert into APP_FlowType (flowTypeId, label) values ('WBSVC', 'Web Service');
insert into APP_FlowType (flowTypeId, label) values ('FTP', 'File Transfer Protocol');
insert into APP_FlowType (flowTypeId, label) values ('SFTP', 'Secured File Transfer Protocol');
insert into APP_FlowType (flowTypeId, label) values ('ODBC', 'Object DataBase Connect');
insert into APP_FlowType (flowTypeId, label) values ('JDBC', 'Java DataBase Connect');

--------------------------------------------------------------------------------------------------
-- Table APP_FlowProtocol
--------------------------------------------------------------------------------------------------
-- This table defines flow protocol offer
--------------------------------------------------------------------------------------------------

create table if not exists APP_FlowProtocol (
	flowProtocolId varchar(5) PRIMARY KEY,
	label varchar(200) NOT NULL
);

insert into APP_FlowProtocol (flowProtocolId, label) values ('TCP', 'Transmission Control Protocol');
insert into APP_FlowProtocol (flowProtocolId, label) values ('HTTP', 'HyperText Transport Protocol');
insert into APP_FlowProtocol (flowProtocolId, label) values ('HTTPS', 'HyperText Transport Protocol Secured');

--------------------------------------------------------------------------------------------------
-- Table APP_FlowPeriod
--------------------------------------------------------------------------------------------------
-- This table defines flow periodicity.
-- It is simplified regarding standard usages in other AE tools, for ability to fill in and use.
--------------------------------------------------------------------------------------------------

create table if not exists APP_FlowPeriod (
	flowPeriodId varchar(5) PRIMARY KEY,
	label varchar(200)
);

insert into APP_FlowPeriod(flowPeriodId, label) values ('PRD', 'Scheduled Transfer');
insert into APP_FlowPeriod(flowPeriodId, label) values ('RQT', 'On Request Transfer');

--------------------------------------------------------------------------------------------------
-- Type APP_DATA_FLOW_ORIENT
--------------------------------------------------------------------------------------------------
-- This type defines an ENUM for flow orientation. Considering the low volatility for this object,
-- we just use a type.
--------------------------------------------------------------------------------------------------

create TYPE APP_DATA_FLOW_ORIENT as ENUM ('push', 'pull', 'bi-directional');
create TYPE APP_FLOW_STATUS as ENUM ('actif', 'inactif');

--------------------------------------------------------------------------------------------------
-- Table APP_Flow
--------------------------------------------------------------------------------------------------
-- This table defines flows between an application and another one or an organisation.
-- The source initializes the technical connection. There is an additional attribute
-- (flowDataOrientation) for the information flow.
--------------------------------------------------------------------------------------------------

create table if not exists APP_Flow (
	flowId uuid NOT NULL DEFAULT gen_random_uuid() primary key,
	-- A flow targets either another application or an organisation
	-- so both following attributes must follow requirements:
	-- If an application is targeted, the organisation is filled with the application owner
	-- If an organisation is targeted (unknown target application), the organisation is filled, but the application still empty
	applicationSourceId uuid NULL references APP_Application(applicationId),
	organisationUnitSourceId uuid NULL references ORG_organisationUnit(organisationUnitId),
	applicationTargetId uuid NULL references APP_Application(applicationId),
	organisationUnitTargetId uuid NULL references ORG_organisationUnit(organisationUnitId),
	middleware text NULL, -- here for DAG compliance
	flowTypeId varchar(5) NULL references APP_FlowType (flowTypeId),
	flowProtocolId varchar(5) NULL references APP_FlowProtocol (flowProtocolId),
	flowPeriodId varchar(5) NULL references APP_FlowPeriod (flowPeriodId),
	flowDataOrientation APP_DATA_FLOW_ORIENT NOT NULL,
	ports varchar(200) NULL
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table APP_FlowData
--------------------------------------------------------------------------------------------------
-- This table associates data with flows.
-- It is supposed to reference data from an external repository, but it must also support a lack
-- of such a tool.
--------------------------------------------------------------------------------------------------

create table if not exists APP_FlowData (
	flowId uuid NOT NULL references APP_Flow (flowId),
	-- the dataId must be provided by the data repository
	-- but if this repository is missing, we can use a data shortname as dataId
	dataId varchar(255) NOT NULL,
	-- in the case of a data repository, this description ois a replication of the repository one
	dataDescription text NULL,
	dataUrl text NULL,
	primary key (flowId, dataId)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Types ENV_TYPE, ENV_PROTECTION, ENV_STATUS
--------------------------------------------------------------------------------------------------
-- Those types defines reference data with low volatility.
-- Open Question:
--    - relation between protection and sensitivity is not clear.
--    - types could be reviewed, so better defined in a table instead of type ?
--------------------------------------------------------------------------------------------------

create TYPE ENV_TYPE as ENUM ('Kubernetes', 'OpenStack', 'VSX', 'Poste de travail', 'Autre');
create TYPE ENV_PROTECTION as ENUM ('S1', 'S2', 'S3', 'S4');
create TYPE ENV_STATUS as ENUM ('En construction', 'Actif', 'Inactif');

--------------------------------------------------------------------------------------------------
-- Table ENV_Environment
--------------------------------------------------------------------------------------------------
-- This table defines hosting environments.
-- the concept of environment is an homogeneous hosting unit, so it is associated with hosting
-- organisation procedures.
-- It could be a cluster, a bay, room, site, ...
-- Open Question: this object is defined flat. It is not designed to document the hosting
-- structure
--------------------------------------------------------------------------------------------------

create table if not exists ENV_Environment (
	environmentId uuid NOT NULL DEFAULT gen_random_uuid() primary key,
	label varchar(200) NOT NULL,
	organisation text NOT NULL,
	environmentType ENV_TYPE NOT NULL DEFAULT 'Kubernetes',
	environmentProtection ENV_PROTECTION NOT NULL DEFAULT 'S1',
	environmentStatus ENV_STATUS NOT NULL DEFAULT 'Actif'
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table APP_InstanceRole
--------------------------------------------------------------------------------------------------
-- This table defines a reference of instance roles
--------------------------------------------------------------------------------------------------

create table if not exists APP_InstanceRole (
	instanceRole	char(1) PRIMARY KEY,
	label text NOT NULL
);

insert into APP_InstanceRole (instanceRole, label) values ('C', 'Consultation');
insert into APP_InstanceRole (instanceRole, label) values ('D', 'Développement');
insert into APP_InstanceRole (instanceRole, label) values ('E', 'Production');
insert into APP_InstanceRole (instanceRole, label) values ('F', 'Formation');
insert into APP_InstanceRole (instanceRole, label) values ('I', 'Intégration');
insert into APP_InstanceRole (instanceRole, label) values ('J', 'Formation Développement');
insert into APP_InstanceRole (instanceRole, label) values ('K', 'Homologation');
insert into APP_InstanceRole (instanceRole, label) values ('L', 'Livraison');
insert into APP_InstanceRole (instanceRole, label) values ('M', 'Métrologie');
insert into APP_InstanceRole (instanceRole, label) values ('P', 'Pré-production');
insert into APP_InstanceRole (instanceRole, label) values ('Q', 'Qualification');
insert into APP_InstanceRole (instanceRole, label) values ('R', 'Référentiel');
insert into APP_InstanceRole (instanceRole, label) values ('S', 'Source');
insert into APP_InstanceRole (instanceRole, label) values ('T', 'Qualification technique');
insert into APP_InstanceRole (instanceRole, label) values ('V', 'Validation');

--------------------------------------------------------------------------------------------------
-- Table APP_InstanceStatus
--------------------------------------------------------------------------------------------------
-- This table defines a reference of instance statuses. It is splited from application statuses.
-- Not sure it is relevant.
-- Coherence between instance status and application one is defined through business requirements
--------------------------------------------------------------------------------------------------

create table if not exists APP_InstanceStatus (
	instanceStatus varchar(3) PRIMARY KEY,
	label text NOT NULL
);

insert into APP_InstanceStatus (instanceStatus, label) values ('CRS', 'Construction');
insert into APP_InstanceStatus (instanceStatus, label) values ('PRD', 'Production');
insert into APP_InstanceStatus (instanceStatus, label) values ('RSV', 'Retrait de service');
insert into APP_InstanceStatus (instanceStatus, label) values ('DCS', 'Décommissionnée');

--------------------------------------------------------------------------------------------------
-- Table APP_Instance
--------------------------------------------------------------------------------------------------
-- This table defines an instance of application.
--------------------------------------------------------------------------------------------------

create table if not exists APP_Instance (
	environmentId uuid NOT NULL references ENV_Environment (environmentId),
	applicationId uuid NOT NULL references APP_Application(applicationId),
	instanceRole varchar(1) NULL references APP_InstanceRole(instanceRole) DEFAULT 'E',
	instanceStatus varchar(3) NOT NULL references APP_InstanceStatus(instanceStatus) DEFAULT 'PRD',
	tenant text NULL,
	FIP text NULL,
	URL text NULL,
	deploymentDate date	NULL 
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table APP_InterfaceType
--------------------------------------------------------------------------------------------------
-- This table defines types reference for interfaces.
--------------------------------------------------------------------------------------------------

create table if not exists APP_InterfaceType (
	interfaceTypeId varchar(5) NOT NULL primary key,
	description text NULL
);

insert into APP_InterfaceType (interfaceTypeId, description) values ('API-R', 'Application Programming Interface RESTfull');
insert into APP_InterfaceType (interfaceTypeId, description) values ('FILE', 'Data provided through a file to be transfered');

--------------------------------------------------------------------------------------------------
-- Table APP_Interface
--------------------------------------------------------------------------------------------------
-- This table defines interface points.
-- Considering that an interface could engineer an application or just a dataset, so the
-- application is optional.
-- The applicationDistribution is the middleware used for distribution.
--------------------------------------------------------------------------------------------------

create table if not exists APP_Interface (
	interfaceId uuid NOT NULL DEFAULT gen_random_uuid() primary key,
	interfaceTypeId varchar(5) NOT NULL references APP_InterfaceType(interfaceTypeId),
	applicationDataSource uuid NULL references APP_Application (applicationId), -- defines the application providing exposed data
	applicationDistribution uuid NULL references APP_Application (applicationId) -- defines the application exposing the interface (ex: APIGW)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table FCT_Capability
--------------------------------------------------------------------------------------------------
-- This table defines business capabilities.
-- It allows to define usages.
--------------------------------------------------------------------------------------------------

create table if not exists FCT_Capability (
	capabilityId uuid NOT NULL DEFAULT gen_random_uuid() primary key,
	parentId uuid NULL references FCT_Capability (capabilityId),
	label text NOT NULL,
	description text NULL
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table FCT_CapabilityRealisation
--------------------------------------------------------------------------------------------------
-- This table associates application and capability.
--------------------------------------------------------------------------------------------------

create table if not exists FCT_CapabilityRealisation (
	applicationId uuid NOT NULL references APP_Application(applicationId),
	capabilityId uuid NOT NULL references FCT_Capability(capabilityId),
	description text NULL,
	primary key (applicationId, capabilityId)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table FCT_UrbanZone
--------------------------------------------------------------------------------------------------
-- This table urban zones to document a standard Ground Organsiation Plan for Information System.
--------------------------------------------------------------------------------------------------

create table if not exists FCT_UrbanZone (
	urbanZoneId uuid NOT NULL DEFAULT gen_random_uuid() primary key,
	parentId uuid NULL references FCT_UrbanZone (urbanZoneId),
	label text NOT NULL,
	description text NULL
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table FCT_UrbanZoneResponsability
--------------------------------------------------------------------------------------------------
-- This table associates urban zones with organisation units and roles.
-- It reflects a derivated usage of the ground organisation plan, but quite popular.
--------------------------------------------------------------------------------------------------

create table if not exists FCT_UrbanZoneResponsability (
	urbanZoneId uuid NULL references FCT_UrbanZone (urbanZoneId),
	organisationUnitId uuid NOT NULL references ORG_organisationUnit(organisationUnitId),
	roleId varchar(5) NOT NULL references ORG_RoleType(roleId),
	description text NULL,
	primary key (urbanZoneId, organisationUnitId, roleId)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table FCT_UrbanZoneApplication
--------------------------------------------------------------------------------------------------
-- This table associates urban zones with applications.
-- In despite of Urbanization Guidelines, an application can be associated with several zones.
--------------------------------------------------------------------------------------------------

create table if not exists FCT_UrbanZoneApplication (
	urbanZoneId uuid NULL references FCT_UrbanZone (urbanZoneId),
	applicationId uuid NOT NULL references APP_Application(applicationId),
	primary key (urbanZoneId, applicationId)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table PRJ_Project
--------------------------------------------------------------------------------------------------
-- This table defines projects.
-- A project is an prganisational object which gather resources to achieve a goal. In our concept,
-- this goal is a project initial build or majot evolution. But we ould also define a project for
-- application maintenance.
--------------------------------------------------------------------------------------------------

create table if not exists PRJ_Project (
	projectId uuid NOT NULL DEFAULT gen_random_uuid() primary key,
	label text NOT NULL,
	description text NULL,
	parentId uuid NULL references PRJ_Project(projectId)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Type PRJ_APP_TYPE
--------------------------------------------------------------------------------------------------
-- This type references types of association between application and project.
-- Ths is defined to consider an application as a contributing resource (Contributing) or a
-- support of project goal (Managed)
--------------------------------------------------------------------------------------------------

create TYPE PRJ_APP_TYPE as ENUM ('Contributing', 'Managed');

--------------------------------------------------------------------------------------------------
-- Table PRJ_ProjectApplication
--------------------------------------------------------------------------------------------------
-- This table associates applications with projects.
--------------------------------------------------------------------------------------------------

create table if not exists PRJ_ProjectApplication (
	projectId uuid NULL references PRJ_Project (projectId),
	applicationId uuid NOT NULL references APP_Application(applicationId),
	applicationRole PRJ_APP_TYPE NOT NULL DEFAULT 'Managed',
	primary key (projectId, applicationId)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table PRJ_ProjectResponsability
--------------------------------------------------------------------------------------------------
-- This table associates projects with actors and/or organisation units for a responsability.
--------------------------------------------------------------------------------------------------

create table if not exists PRJ_ProjectResponsability (
	projectId uuid NULL references PRJ_Project (projectId),
	-- If the actorId is filled, the orgUnit is constrained with the actor's one
	-- else the orgUnit is only referencing the ORG_organisation table
	actorId uuid NULL references ACT_Actor(actorId),
	organisationUnitId uuid NOT NULL references ORG_organisationUnit(organisationUnitId),
	roleId varchar(5) NOT NULL references ORG_RoleType(roleId),
	description text NULL
) inherits(ABS_Tracability);

create unique index I_ProjectResponsability on PRJ_ProjectResponsability (projectId, actorId, organisationUnitId, roleId) NULLS DISTINCT;

--------------------------------------------------------------------------------------------------
-- Table PTF_Portfolio
--------------------------------------------------------------------------------------------------
-- This table defines portfolio objects.
--------------------------------------------------------------------------------------------------

create table if not exists PTF_Portfolio (
	portfolioId uuid NOT NULL DEFAULT gen_random_uuid() primary key,
	label text NOT NULL,
	description text NULL,
	parentId uuid NULL references PTF_Portfolio(portfolioId)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table PTF_PortfolioApplication
--------------------------------------------------------------------------------------------------
-- This table associates portfolio and applications.
-- Basically, a portfolio should gather projects, which are related with applications....
-- So this table is a shortcut regarding projects organisation maturity.
--------------------------------------------------------------------------------------------------

create table if not exists PTF_PortfolioApplication (
	portfolioId uuid NULL references PTF_Portfolio (portfolioId),
	applicationId uuid NOT NULL references APP_Application(applicationId),
	primary key (portfolioId, applicationId)
) inherits(ABS_Tracability);

--------------------------------------------------------------------------------------------------
-- Table PTF_PortfolioResponsability
--------------------------------------------------------------------------------------------------
-- This table associates portfolio and actors/organisation with roles.
--------------------------------------------------------------------------------------------------

create table if not exists PTF_PortfolioResponsability (
	portfolioId uuid NULL references PTF_Portfolio (portfolioId),
	-- If the actorId is filled, the orgUnit is constrained with the actor's one
	-- else the orgUnit is only referencing the ORG_organisation table
	actorId uuid NULL references ACT_Actor(actorId),
	organisationUnitId uuid NOT NULL references ORG_organisationUnit(organisationUnitId),
	roleId varchar(5) NOT NULL references ORG_RoleType(roleId),
	desription text NULL
) inherits(ABS_Tracability);

create unique index I_PortfolioResponsability on PTF_PortfolioResponsability (portfolioId, actorId, organisationUnitId, roleId) NULLS DISTINCT;

--------------------------------------------------------------------------------------------------
-- Table APP_ComplianceType
--------------------------------------------------------------------------------------------------
-- This table defines compliance types associated with applications.
--------------------------------------------------------------------------------------------------

create table if not exists APP_ComplianceType (
	complianceType varchar(5) PRIMARY KEY,
	description text NULL,
	referenceURL text NULL
);

insert into APP_ComplianceType (complianceType, description, referenceURL) values ('SSI', 'Homologation de sécurité', 'http://dnum.minint.fr/index.php/la-s-s-i/homologation/guide-homologation');
insert into APP_ComplianceType (complianceType, description, referenceURL) values ('RGAA', 'Référentiel Général d''Accessibilité des Administrations', 'https://accessibilite.numerique.gouv.fr/');
insert into APP_ComplianceType (complianceType, description, referenceURL) values ('RGPD', 'Réglement Général sur la Protection des Données', 'https://www.consilium.europa.eu/fr/policies/data-protection/data-protection-regulation/');

--------------------------------------------------------------------------------------------------
-- Type APP_COMPLIANCE_LEVEL
--------------------------------------------------------------------------------------------------
-- This table defines level of compliance. This could look a bit simplified for some compliance
-- programs, but must apply to all.
-- Open Question: add of 'Obsolète' status, in case of lack of validity date.
--------------------------------------------------------------------------------------------------

create type APP_COMPLIANCE_LEVEL as ENUM ('Dispensée', 'Non passée', 'Partielle', 'Complète', 'Obsolète');

create table if not exists APP_Compliance (
	applicationId uuid NOT NULL references APP_Application(applicationId),
	complianceType varchar(5) NOT NULL references APP_ComplianceType (complianceType),
	complianceLevel APP_COMPLIANCE_LEVEL NOT NULL DEFAULT('Non passée'),
	decisionDate date NULL,
	validityDate date NULL,
	auditDate date NULL,
	description text NULL,
	primary key (applicationId, complianceType)
) inherits (ABS_Tracability);

