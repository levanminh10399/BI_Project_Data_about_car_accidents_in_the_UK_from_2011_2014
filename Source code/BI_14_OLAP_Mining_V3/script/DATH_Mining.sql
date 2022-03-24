use ETL_DDS_V2
go

create table dm_accident_severity 
( VehicleIndex int
, VehicleType varchar(100)
, JourneyPurpose varchar(100)
, BuiltUpRoad varchar(100)
, TimeOfDay varchar(100)
, UrbanOrRuralArea varchar(100)
, RoadType varchar(100)
, AccidentSeverity varchar(100)
, constraint pk_dm_accident_severity 
  primary key clustered (VehicleIndex)
);


truncate table dm_accident_severity
insert into dm_accident_severity
select distinct
		fv.VehicleIndex as VehicleIndex,
		dvt.VehicleTypeLabel as VehicleType,
		djp.JourneyPurposeLabel as JourneyPurpose,
		dbur.BuiltUpRoadLabel as BuiltUpRoad,
		dtod.TimeOfDayLabel as TimeOfDay,
		dur.UrbanOrRuralLabel as UrbanOrRuralArea,
		drt.RoadTypeLabel as RoadType,
		das.AccidentSeverityLabel as AccidentSeverity
from FactCasualties fc
	join FactVehicles fv on fc.VehicleIndex = fv.VehicleIndex
		join DimVehicleType dvt on fv.VehicleTypeIndex = dvt.VehicleTypeIndex
		join DimJourneyPurpose djp on fv.JourneyPurposeIndex = djp.JourneyPurposeIndex
		join DimBuiltUpRoad dbur on fv.BuiltUpRoadIndex = dbur.BuiltUpRoadIndex
	join FactAccidents fa on fc.AccidentID = fa.AccidentID
		join DimAccidentSeverity das on fa.AccidentSeverityIndex = das.AccidentSeverityIndex
		join DimTimeOfDay dtod on fa.TimeOfDayIndex = dtod.TimeOfDayIndex
		join DimUrbanRural dur on fa.UrbanOrRuralAreaIndex = dur.UrbanRuralIndex
		join DimRoadType drt on fa.RoadTypeIndex = drt.RoadTypeIndex
