# DMart ETL Project

A beginner-friendly retail data engineering project using Snowflake, dbt Core, and Power BI.

## Architecture

```text
CSV files -> Snowflake RAW_DATA -> dbt Bronze -> dbt Silver -> dbt Gold -> Power BI
```

- **Bronze:** raw pass-through views in `DMART_ETL.BRONZE`
- **Silver:** cleaned and typed views in `DMART_ETL.SILVER`
- **Gold:** analytical tables in `DMART_ETL.GOLD`
- **Power BI:** dashboard built from `FACT_SALES`, `DIM_STORE`, `DIM_PRODUCT`, and `DIM_CALENDAR`

## Project Contents

- `DMartETL_DBT/dmart_ETL_project/`: dbt project
- `Raw files/`: sample CSV source files
- `PowerBI Dashboard/`: Power BI report
- `YOUTUBE_PROJECT_SCRIPT.txt`: video explanation script
- `Project Steps.txt`: project workflow notes

## Run dbt

Use a Python environment with dbt Core and the Snowflake adapter installed. Run commands from the directory containing `dbt_project.yml`:

```powershell
cd "D:\Study\DMart ETL"
.\.venv\Scripts\Activate.ps1
cd ".\DMartETL_DBT\dmart_ETL_project"
dbt debug
dbt build
```

The Snowflake profile is stored outside this repository at `~/.dbt/profiles.yml`. Do not commit passwords or other credentials.

## Power BI

Connect Power BI to database `DMART_ETL`, schema `GOLD`, and load the four star-schema tables listed above. See `DMartETL_DBT/dmart_ETL_project/POWER_BI_GUIDE.md` for relationships, measures, and dashboard visuals.
