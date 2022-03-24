CREATE DATABASE ETL_NDS

GO
USE ETL_NDS

GO

CREATE TABLE Source
(
	SourceID int identity(1,1),
	Name varchar(100),
	CONSTRAINT PK_S PRIMARY KEY(SourceID)
)

SET IDENTITY_INSERT [dbo].[Source] ON
GO
INSERT INTO Source (SourceId, Name) VALUES (1, 'Accidents-Casualties-Vehicles-Codebook');
INSERT INTO Source (SourceId, Name) VALUES (2, 'Postcodes-PCD_OA_LSOA_MSOA_LAD_AUG21_UK_LU');
SET IDENTITY_INSERT [dbo].[Source] OFF
GO

CREATE TABLE TimeOfDay 
(
	TimeOfDayIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_TOD PRIMARY KEY(TimeOfDayIndex)
)

CREATE TABLE Gender 
(
	GenderIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_G PRIMARY KEY(GenderIndex)
)

CREATE TABLE AgeBand 
(
	AgeBandIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_AB PRIMARY KEY(AgeBandIndex)
)

CREATE TABLE AgeGroup
(
	AgeGroupIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_AG PRIMARY KEY(AgeGroupIndex)
)

CREATE TABLE CasualtySeverity 
(
	CasualtySeverityIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_CS PRIMARY KEY(CasualtySeverityIndex)
)

CREATE TABLE CasualtyType 
(
	CasualtyTypeIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_CT PRIMARY KEY(CasualtyTypeIndex)
)

CREATE TABLE AccidentSeverity 
(
	AccidentSeverityIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_AS PRIMARY KEY(AccidentSeverityIndex)
)

CREATE TABLE TownCity 
(
	TownCityIndex int identity(1,1),
	Postcode varchar(10),
	lsoa varchar(10),
	CityName varchar(50),
	County int,
	SourceID int,
	[latitude] [varchar](50),
	[longitude] [varchar](50),
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_TC PRIMARY KEY(TownCityIndex)
)

CREATE TABLE County 
(
	CountyIndex int identity(1,1),
	CountyName varchar(50),
	Region int,
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_C PRIMARY KEY(CountyIndex)
)

CREATE TABLE Region 
(
	RegionIndex int identity(1,1),
	RegionCode varchar(10),
	RegionName varchar(50),
	Country int,
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_R PRIMARY KEY(RegionIndex)
)

CREATE TABLE Country
(
	CountryIndex int identity(1,1),
	CountryCode varchar(10),
	CountryName varchar(20),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_CY PRIMARY KEY(CountryIndex)
)

CREATE TABLE LocalAuthorityDistrict
(
	LADIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_LAD PRIMARY KEY(LADIndex)
)

CREATE TABLE UrbanOrRuralArea
(
	UrbanOrRuralIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_UORA PRIMARY KEY(UrbanOrRuralIndex)
)

CREATE TABLE BuiltUpRoad
(
	BuiltUpRoadIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_BUR PRIMARY KEY(BuiltUpRoadIndex)
)

CREATE TABLE RoadType
(
	RoadTypeIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_RT PRIMARY KEY(RoadTypeIndex)
)

CREATE TABLE VehicleType
(
	VehicleTypeIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_VT PRIMARY KEY(VehicleTypeIndex)
)

CREATE TABLE JourneyPurpose
(
	JourneyPurposeIndex int identity(1,1),
	Code int,
	Label varchar(100),
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_JP PRIMARY KEY(JourneyPurposeIndex)
)

CREATE TABLE Vehicles
(
	VehicleIndex int identity(1,1),
	AccidentID int,
	VehicleType int,
	JourneyPurpose int,
	SourceID int,
	VehicleReference int,
	CreatedAt datetime,
	UpdatedAt datetime
	CONSTRAINT PK_V PRIMARY KEY(VehicleIndex)
)

CREATE TABLE Accidents
(
	AccidentID int identity(1,1),
	AccidentIndex varchar(50),
	NumberOfVehicles int,
	NumberOfCasualties int,
	Time time,
	TimeOfDay int,
	Date Date,
	AccidentSeverity int,
	CityCode int,
	RoadType int,
	BuiltUpRoad int,
	UrbanOrRuralArea int,
	LAD int,
	Longitude float,
	Latitude float,
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime,
	CONSTRAINT PK_A PRIMARY KEY(AccidentID)
)

CREATE TABLE Casualties
(
	CasualtyIndex int identity(1,1),
	AccidentID int,
	VehicleReference int,
	CasualtyReference int,
	SexOfCasualty int,
	AgeOfCasualty int,
	AgeGroupOfCasualty int,
	AgeBandOfCasualty int,
	CasualtySeverity int,
	CasualtyType int,
	SourceID int,
	CreatedAt datetime,
	UpdatedAt datetime,
	CONSTRAINT PK_CST PRIMARY KEY(CasualtyIndex)
)

GO

--Khoa ngoai bang Gender
ALTER TABLE Gender
ADD CONSTRAINT FK_G_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang AgeBand
ALTER TABLE AgeBand
ADD CONSTRAINT FK_AB_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang CasualtySeverity
ALTER TABLE CasualtySeverity
ADD CONSTRAINT FK_CS_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang CasualtyType
ALTER TABLE CasualtyType
ADD CONSTRAINT FK_CT_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang AccidentSeverity
ALTER TABLE AccidentSeverity
ADD CONSTRAINT FK_AS_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang TownCity
ALTER TABLE TownCity
ADD CONSTRAINT FK_TC_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

ALTER TABLE TownCity
ADD CONSTRAINT FK_TC_C
FOREIGN KEY(County)
REFERENCES County(CountyIndex)

--Khoa ngoai bang County
ALTER TABLE County
ADD CONSTRAINT FK_S_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

ALTER TABLE County
ADD CONSTRAINT FK_S_R
FOREIGN KEY(Region)
REFERENCES Region(RegionIndex)

--Khoa ngoai bang Region
ALTER TABLE Region
ADD CONSTRAINT FK_R_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

ALTER TABLE Region
ADD CONSTRAINT FK_R_CY
FOREIGN KEY(Country)
REFERENCES Country(CountryIndex)

--Khoa ngoai bang Country
ALTER TABLE Country
ADD CONSTRAINT FK_CY_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang LocalAuthorityDistrict
ALTER TABLE LocalAuthorityDistrict
ADD CONSTRAINT FK_LAD_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang UrbanOrRuralArea
ALTER TABLE UrbanOrRuralArea
ADD CONSTRAINT FK_UORA_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang RoadType
ALTER TABLE RoadType
ADD CONSTRAINT FK_RT_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang VehicleType
ALTER TABLE VehicleType
ADD CONSTRAINT FK_VT_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang JourneyPurpose
ALTER TABLE JourneyPurpose
ADD CONSTRAINT FK_JP_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

--Khoa ngoai bang Accidents
ALTER TABLE Accidents
ADD CONSTRAINT FK_A_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

ALTER TABLE Accidents
ADD CONSTRAINT FK_A_AS
FOREIGN KEY(AccidentSeverity)
REFERENCES AccidentSeverity(AccidentSeverityIndex)

ALTER TABLE Accidents
ADD CONSTRAINT FK_A_TC
FOREIGN KEY(CityCode)
REFERENCES TownCity(TownCityIndex)

ALTER TABLE Accidents
ADD CONSTRAINT FK_A_RT
FOREIGN KEY(RoadType)
REFERENCES RoadType(RoadTypeIndex)

ALTER TABLE Accidents
ADD CONSTRAINT FK_A_BUR
FOREIGN KEY(BuiltUpRoad)
REFERENCES BuiltUpRoad(BuiltUpRoadIndex)

ALTER TABLE Accidents
ADD CONSTRAINT FK_A_UORA
FOREIGN KEY(UrbanOrRuralArea)
REFERENCES UrbanOrRuralArea(UrbanOrRuralIndex)

ALTER TABLE Accidents
ADD CONSTRAINT FK_A_LAD
FOREIGN KEY(LAD)
REFERENCES LocalAuthorityDistrict(LADIndex)

ALTER TABLE Accidents
ADD CONSTRAINT FK_A_TOD
FOREIGN KEY(TimeOfDay)
REFERENCES TimeOfDay(TimeOfDayIndex)

--Khoa ngoai bang Casualties
ALTER TABLE Casualties
ADD CONSTRAINT FK_CST_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)

ALTER TABLE Casualties
ADD CONSTRAINT FK_CST_A
FOREIGN KEY(AccidentID)
REFERENCES Accidents(AccidentID)

ALTER TABLE Casualties
ADD CONSTRAINT FK_CST_G
FOREIGN KEY(SexOfCasualty)
REFERENCES Gender(GenderIndex)

ALTER TABLE Casualties
ADD CONSTRAINT FK_CST_AG
FOREIGN KEY(AgeGroupOfCasualty)
REFERENCES AgeGroup(AgeGroupIndex)

ALTER TABLE Casualties
ADD CONSTRAINT FK_CST_AB
FOREIGN KEY(AgeBandOfCasualty)
REFERENCES AgeBand(AgeBandIndex)

ALTER TABLE Casualties
ADD CONSTRAINT FK_CST_CS
FOREIGN KEY(CasualtySeverity)
REFERENCES CasualtySeverity(CasualtySeverityIndex)

ALTER TABLE Casualties
ADD CONSTRAINT FK_CST_CT
FOREIGN KEY(CasualtyType)
REFERENCES CasualtyType(CasualtyTypeIndex)

--Khoa ngoai bang Vehicles
ALTER TABLE Vehicles
ADD CONSTRAINT FK_V_VT
FOREIGN KEY(VehicleType)
REFERENCES VehicleType(VehicleTypeIndex)

ALTER TABLE Vehicles
ADD CONSTRAINT FK_V_A
FOREIGN KEY(AccidentID)
REFERENCES Accidents(AccidentID)

ALTER TABLE Vehicles
ADD CONSTRAINT FK_V_JP
FOREIGN KEY(JourneyPurpose)
REFERENCES JourneyPurpose(JourneyPurposeIndex)

ALTER TABLE Vehicles
ADD CONSTRAINT FK_V_S
FOREIGN KEY(SourceID)
REFERENCES Source(SourceID)