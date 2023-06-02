Select *
From CovidAnalysis..CovidDeaths_Current
Where continent is null
order by 3, 4 desc

--Create new table of just Vaccine information from CovidDeaths_Current

SELECT iso_code, continent, location, date, new_tests, total_tests, total_tests_per_thousand, new_tests_per_thousand, new_tests_smoothed,
new_tests_smoothed_per_thousand, positive_rate, tests_per_case, tests_units, total_vaccinations, people_vaccinated, people_fully_vaccinated, new_vaccinations,
new_vaccinations_smoothed, total_vaccinations_per_hundred, people_fully_vaccinated_per_hundred, new_vaccinations_smoothed_per_million, stringency_index, population_density,
median_age, aged_65_older,aged_70_older, gdp_per_capita, extreme_poverty,cardiovasc_death_rate,diabetes_prevalence, female_smokers, male_smokers, handwashing_facilities, hospital_beds_per_thousand,
life_expectancy, human_development_index
INTO CovidAnalysis..CovidVaccine_Info
FROM CovidAnalysis..CovidDeaths_Current

Select location, date, total_cases, new_cases, total_deaths, population
From CovidAnalysis..CovidDeaths_Current
Order By 1,  2

Select location, date, total_cases, new_cases, total_deaths, population
From CovidAnalysis..CovidDeaths_Current
Where location like '%states%'
Order By 1,  2

--Looking at likelihood of dying if contracted in chosen country, starting with latest date 
--(5/31/2023 at time of project) 
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercent
From CovidAnalysis..CovidDeaths_Current
Where location = 'United States'
Order By 2 desc

--What Percentage of population contracted COVID
Select location, date, population, total_cases, (total_cases/population)*100 as CasePercentage
From CovidAnalysis..CovidDeaths_Current
Where Location = 'United States'
Order By 1, 2

--What percantage of those that contracted COVID were fatal
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as percentFatal
From CovidAnalysis..CovidDeaths_Current
Where location = 'United States'
Order by 1,2 desc

--Looking at countries that have had the highest infection rate compared to population
Select continent, population, Max(total_cases) as highestInfectionCount, 
MAX((total_cases/population))*100 as PercentPopulationInfect
From CovidAnalysis..CovidDeaths_Current
Group By continent, population
Order by PercentPopulationInfect desc

--The numbers above didn't quite make sense, so I attempted the below code
Select location, population, Max(total_cases) as highestInfectionCount, 
MAX((total_cases/population))*100 as PercentPopulationInfect
From CovidAnalysis..CovidDeaths_Current
Where continent is not null
Group By location, population
Order by PercentPopulationInfect desc

--Looking at countries with highest death count per population
Select location, population, MAX(total_deaths) as total_death_count
From CovidAnalysis..CovidDeaths_Current
Group By location, population
Order by total_death_count desc

--The above query showed locations such as 'World' and 'High income', changed the code to get rid of locations
Select location, population, MAX(total_deaths) as total_death_count
From CovidAnalysis..CovidDeaths_Current
Where continent is not null
Group By location, population
Order by total_death_count desc

Select location, population, MAX(total_deaths) as total_death_count, (MAX(total_deaths)/population)*100 as Death_percent
From CovidAnalysis..CovidDeaths_Current
Where continent is not null
Group By location, population
Order by Death_percent desc
