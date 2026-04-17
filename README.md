# Delivery Operations Analytics Dashboard

An end-to-end analytics project built using **SQL** and **Power BI** to evaluate delivery operations performance.  
The project focuses on **delivery success rate, return behavior, SLA breach, city-level performance, and delivery-man performance** through structured querying and dashboarding.

---

## Project Overview

This project analyzes a delivery operations dataset to answer key business questions around fulfillment quality and operational efficiency. The analysis is divided into two parts:

- **SQL Analysis** for KPI calculation and business-question solving
- **Power BI Dashboard** for visual monitoring and decision support

The goal is to simulate a real-world operational analytics workflow for a logistics or delivery business.

---

## Objectives

- Measure overall **delivery success rate**
- Calculate **daily average return ratio**
- Detect **SLA-breached orders**
- Identify **repeat customers** within a recent time window
- Detect **registered city vs. delivery city mismatch**
- Rank top-performing delivery men by city
- Identify **high-risk delivery men**
- Analyze **city change cases** from order logs
- Build dashboard pages for:
  - Operations overview
  - City performance
  - Delivery-man performance

---

## Tools Used

- **SQL**
- **PostgreSQL**
- **Power BI**
- **Excel / CSV**
- **GitHub**

---

## SQL Analysis

The SQL part of this project answers the following business questions:

1. **Overall Delivery Success Rate**
2. **Daily Average Return Ratio**
3. **SLA Breached Orders**
4. **Multiple Deliveries to the Same Customer**
5. **Registered City vs. Delivery City Mismatch**
6. **Top 3 Delivery Men per Delivery City**
7. **Delivery Men with Tenure > 30 Days and Return Ratio > 20%**
8. **City Change Cases from Order Logs**

### Key SQL Concepts Used
- `JOIN`
- `GROUP BY`
- `CASE WHEN`
- `CTE`
- `ROW_NUMBER()`
- `DATE_PART`
- `EXTRACT(EPOCH FROM ...)`
- conditional KPI logic
- ranking and filtering

---

## Dashboard Pages

## Page 1 — Operations Overview

**Included visuals:**
- KPI cards:
  - Total Orders
  - Delivery Success Rate %
  - Return Rate %
  - SLA Breach Orders
  - SLA Breach %
- Status Mix by Delivery City
- SLA Breach Orders by Delivery City
- Orders Trend by Delivery Date

**Purpose:**  
Provides a high-level view of order volume, delivery performance, return behavior, and SLA compliance.

---

## Page 2 — City Performance

**Included visuals:**
- KPI cards:
  - Best Success Rate
  - Worst Success Rate
  - Highest Volume
  - Highest SLA Breach
- Success Rate vs SLA Breach by Delivery City
- City Performance Summary Table

**Purpose:**  
Compares delivery performance across cities using success rate, order volume, and SLA breach metrics.

---

## Page 3 — Delivery Man Performance

**Included visuals:**
- KPI cards:
  - Total Delivery Men
  - High-Risk Riders
  - Top Performer
  - Highest Return Ratio
- Top 10 by Deliveries
- Avg Return Ratio by Working Area
- High-Risk Delivery Men Table

**Purpose:**  
Evaluates delivery-man performance and highlights high-risk riders, top performers, and return behavior by working area.

---

## KPI Definitions

- **Delivery Success Rate %** = Delivered Orders / Total Orders
- **Return Rate %** = Returned Orders / Total Orders
- **Lost Orders** = Orders where `order_status = 'Lost'`
- **SLA Breach Orders** = Orders that exceeded the allowed delivery time
- **SLA Breach %** = SLA Breach Orders / Total Orders
- **High-Risk Riders** = Delivery men with:
  - tenure > 30 days
  - return ratio > 20%

---

## SLA Logic

The following SLA rules were applied:

- **Same-city delivery SLA = 24 hours**
- **Outside-city delivery SLA = 48 hours**

An order is marked as **SLA breached** if its delivery aging exceeds the applicable SLA.

---

## Assumptions

- `pickup_city` and `delivery_city` are treated as the primary city-level dimensions.
- Tenure is calculated relative to the **maximum delivery date** in the dataset.
- Return ratio is calculated as:

  `returned_orders / total_orders`

- City mismatch is identified by comparing the delivery city with the city extracted from the registered address.
- The project uses a structured operational dataset representing orders, customers, delivery men, and order logs.

---
