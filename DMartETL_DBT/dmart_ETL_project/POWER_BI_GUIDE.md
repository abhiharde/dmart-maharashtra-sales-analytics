# Power BI Setup

## 1. Refresh the Gold layer

Run dbt from the project directory before refreshing Power BI:

```powershell
cd "D:\Study\DMart ETL\DMartETL_DBT\dmart_ETL_project"
dbt build --select gold
```

The Gold objects are created in:

```text
DMART_ETL.GOLD
```

## 2. Connect Power BI to Snowflake

1. Open Power BI Desktop.
2. Select **Home > Get data > Snowflake**.
3. Enter the Snowflake account/server value from your dbt `profiles.yml`.
4. Select **Import** for a simple beginner-friendly model.
5. Select:
   - Database: `DMART_ETL`
   - Schema: `GOLD`
   - Tables: `FACT_SALES`, `DIM_STORE`, `DIM_PRODUCT`, `DIM_CALENDAR`
6. Do not load `OBT_SALES` or `KPI_SALES` into the report unless you need them for investigation. The report should use the star schema.

Use a secure Snowflake authentication method. Never commit or share the Snowflake password.

## 3. Create relationships

In **Model view**, create these one-to-many relationships:

| Dimension | Column | Fact | Column | Cross-filter |
|---|---|---|---|---|
| `DIM_STORE` | `STORE_ID` | `FACT_SALES` | `STORE_ID` | Single |
| `DIM_PRODUCT` | `PRODUCT_ID` | `FACT_SALES` | `PRODUCT_ID` | Single |
| `DIM_CALENDAR` | `DATE_ID` | `FACT_SALES` | `DATE_ID` | Single |

The dimension side must be `1`; the `FACT_SALES` side must be `*`.

Mark `DIM_CALENDAR[CALENDAR_DATE]` as the date column if Power BI asks for a date table. Use `DIM_CALENDAR[CALENDAR_DATE]` for date slicers and chart axes.

## 4. Add measures

Create these measures in `FACT_SALES`:

```DAX
Total Revenue = SUM(FACT_SALES[REVENUE])

Total Quantity = SUM(FACT_SALES[QUANTITY])

Total Transactions = DISTINCTCOUNT(FACT_SALES[TRANSACTION_ID])

Average Basket Size = DIVIDE([Total Revenue], [Total Transactions])

Average Selling Price = DIVIDE([Total Revenue], [Total Quantity])

Total Discount = SUM(FACT_SALES[DISCOUNT])

Total GST = SUM(FACT_SALES[GST_AMOUNT])

Return Transactions =
CALCULATE(
    [Total Transactions],
    FACT_SALES[IS_RETURN] = TRUE()
)

Return Rate = DIVIDE([Return Transactions], [Total Transactions])
```

Format revenue, discount, GST, and average measures as currency. Format Return Rate as a percentage.

## 5. Build one report page

Use one report page named **Sales Overview**:

- Top cards: `Total Revenue`, `Total Transactions`, `Total Quantity`, `Average Basket Size`, `Return Rate`
- Line chart: `DIM_CALENDAR[CALENDAR_DATE]` by `Total Revenue`
- Clustered bar chart: `DIM_STORE[STORE_NAME]` by `Total Revenue`, sorted descending
- Treemap: `DIM_PRODUCT[CATEGORY]` and `DIM_PRODUCT[SUBCATEGORY]` by `Total Revenue`
- Column chart: `DIM_CALENDAR[SEASON]` by `Total Revenue`
- Donut chart: `FACT_SALES[PAYMENT_MODE]` by `Total Transactions`
- Table: store name, city, total revenue, transactions, quantity
- Slicers: calendar date, state, store type, category, sales channel, payment mode

Keep dimensions on axes and measures in Values. This allows filters to flow from the dimensions into `FACT_SALES`.

## 6. Refresh order

1. Run `dbt build --select gold`.
2. In Power BI, select **Refresh**.
3. Check the relationship icons in Model view.
4. Confirm that changing a slicer changes all charts.
