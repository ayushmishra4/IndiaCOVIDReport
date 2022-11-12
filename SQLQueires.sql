--Total death vs Total cases
Select top 1 Location,date,population, total_cases,total_deaths,(total_cases/population)*100 as InfectedPercentage, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where location like 'India'
and continent is not null
order by date desc

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
Select top 1 Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From CovidDeaths
Where location like 'India'
order by date desc

--Vaccination Report

create view Vaccine as
Select top 1 dea.location,dea.date,dea.population,vac.people_vaccinated,vac.total_vaccinations,vac.people_fully_vaccinated,vac.total_boosters
from CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
and dea.location like 'India' 
order by date desc

select * from Vaccine


--Population VS Vaccination

select location,(people_vaccinated/population)*100 as ratio
from Vaccine

--Population Fully Vaccinated
select location,convert(float,(people_fully_vaccinated)/convert(float,people_vaccinated))
from Vaccine

--Popuplation vs Doses
create view Doses as
select location,population,people_vaccinated,Convert(bigint,people_vaccinated)-convert(bigint,(people_fully_vaccinated)) as SingleDose, 
convert(bigint,people_fully_vaccinated)-convert(bigint,total_boosters) as DoubleDose, 
total_boosters as BoosterDose
from Vaccine

select * from Doses

-- Single Dose Percentage
select location, (cast(SingleDose as float) / cast(people_vaccinated as float)) *100
from Doses

-- Double Dose Percentage
select location, (cast(DoubleDose as float) / cast(people_vaccinated as float)) *100
from Doses

-- Booster Dose Percentage
select location, (cast(BoosterDose as float) / cast(people_vaccinated as float)) *100
from Doses

-- Percentage ratio for Doses
select location, (cast(SingleDose as float) / cast(people_vaccinated as float)) *100 as one,(cast(DoubleDose as float) / cast(people_vaccinated as float)) *100 as two, (cast(BoosterDose as float) / cast(people_vaccinated as float)) *100 as three
from Doses

select * from CovidDeaths;

