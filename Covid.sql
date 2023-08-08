--Select location, date, total_cases, new_cases, total_deaths, population
--From CovidDeaths
--Where continent is not null
--Order by 1,2

--Select *
--From CovidDeaths
--Where continent is not null
--Order by 1,2

-- Total Cases vs Total Deaths

--Select location, date, total_cases, total_deaths, cast(total_deaths as float)/cast(total_cases as float)*100 as DeathPercentage	
--From CovidDeaths
--Where location like '%desh' and Where continent is not null 
--Order by 1,2

-- Total Cases vs Population

--Select location, date, total_cases, population, cast(total_cases as float)/cast(population as float)*100 as CovidRatio	
--From CovidDeaths
--Where location like '%desh'
--Order by 1,2

-- Countries with Highest Infection Rate compared to Population

--Select location, population, MAX(total_cases) as InfectionCount, MAX((cast(total_cases as float)/(cast(population as float))))*100 as HighestInfectedRatio	
--From CovidDeaths
--Group by population, location
--Order by HighestRatio desc

-- Countries with Highest Death Count per population

--Select location, MAX(cast(total_deaths as INT)) as DeathCount
--From CovidDeaths
--Where continent is not null
--Group by location
--Order by DeathCount desc

-- Continent with Highest Death Count per population

--Select continent, MAX(cast(total_deaths as INT)) as DeathCount
--From CovidDeaths
--Where continent is not null
--Group by continent
--Order by DeathCount desc

-- Continents with Highest Death Count

--Select continent, location, MAX(cast(total_deaths as INT)) as DeathCount
--From CovidDeaths
--Where continent is not null
--Group by continent, location
--Order by DeathCount desc

-- Global Numbers

--Select date, Sum(new_cases) as TotalCases, Sum(new_deaths) as TotalDeaths, Sum(new_deaths)/Sum(new_cases)*100 as DeathPercentage
--From CovidDeaths
--where continent is not null
--Group by date
--Order by 1

--UPDATE 
--CovidDeaths
--SET new_cases= NULL 
--WHERE new_cases = 0;

--UPDATE 
--CovidDeaths
--SET new_deaths= NULL 
--WHERE new_deaths = 0;


--Select new_cases,new_deaths
--From CovidDeaths

--Select Sum(new_cases) as TotalCases, Sum(new_deaths) as TotalDeaths, Sum(new_deaths)/Sum(new_cases)*100 as DeathPercentage
--From CovidDeaths
--where continent is not null
--Order by 1,2

-- Total Population vs Vaccinations

--Select death.continent, death.location, death.date, death.population, vac.new_vaccinations, 
-- SUM(convert(float,vac.new_vaccinations)) OVER (Partition by death.location Order by death.location, death.date ROWS UNBOUNDED PRECEDING) as SumVaccinated
--From CovidDeaths death
--Join CovidVaccinated vac
--	ON death.date = vac.date
--	and death.location = vac.location
--where death.continent is not null
--order by 2,3

-- TEMP Table

--Drop table if exists #PercentagePopulationVaccinated
--Create  Table #PercentagePopulationVaccinated
--(
--continent nvarchar(255),
--location nvarchar(255),
--date datetime,
--population numeric,
--new_vaccinations numeric,
--sumVaccinated numeric
--)

--Insert into #PercentagePopulationVaccinated
--Select death.continent, death.location, death.date, death.population, vac.new_vaccinations, 
-- SUM(convert(float,vac.new_vaccinations)) OVER (Partition by death.location Order by death.location, death.date ROWS UNBOUNDED PRECEDING) as SumVaccinated
--From CovidDeaths death
--Join CovidVaccinated vac
--	ON death.date = vac.date
--	and death.location = vac.location
--where death.continent is not null
--order by 2,3

--Select *, (sumVaccinated/Population)*100 as Percentage
--From #PercentagePopulationVaccinated

-- Creating Views

Create View PercentagePopulationVaccinated as
Select death.continent, death.location, death.date, death.population, vac.new_vaccinations, 
 SUM(convert(float,vac.new_vaccinations)) OVER (Partition by death.location Order by death.location, death.date ROWS UNBOUNDED PRECEDING) as SumVaccinated
From CovidDeaths death
Join CovidVaccinated vac
	ON death.date = vac.date
	and death.location = vac.location
where death.continent is not null
--order by 2,3