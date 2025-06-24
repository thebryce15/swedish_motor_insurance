# Swedish Motor Insurance — Risk Segmentation Case Study

> **TL;DR**  Targeted zone surcharges lift expected loss ratio by **+6 pp** while preserving competitive rates for low‑risk drivers.

## 1. Why This Matters

- **65 % of loss** comes from just *two* zones — pricing was subsidising poor risks.
- Quantifies zone‑level risk and delivers an **actionable premium matrix** regulators can understand.
- Frees capital for profitable growth and sharpens underwriting focus.

## 2. My Role

**Sole Analyst** — Data wrangling (SAS) · Statistical modelling · Tableau storytelling · Executive comms.

## 3. Results at a Glance

| KPI                 | Before  | After (Indicated) | Δ       |
| ------------------- | ------- | ----------------- | ------- |
| Expected Loss Ratio | 72.4 %  | **66.2 %**        | –6.2 pp |
| Combined Ratio      | 104.7 % | **99.1 %**        | –5.6 pp |

## 4. Deliverables

- `` — Cleaned dataset ready for modelling
- `` — End‑to‑end SAS program
- **Interactive Dashboard ↗** (Tableau Public) https://public.tableau.com/views/SwedishMotorInsurance/SwedishMotorInsuranceAnalysis?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link
- 12‑slide executive deck & 5‑page PDF report (see `/documents` & `/slides`)

## 5. Approach

1. **Ingest & Clean** — Validate raw portfolio file, engineer KPI fields (frequency, severity, cost).
2. **Segment** — K‑means cluster on frequency & severity to flag High / Medium / Low risk zones.
3. **Price** — Apply graduated multipliers (1.00×, 1.15×, 1.35×) to align premium with exposure.
4. **Visualise & Storytell** — Interactive heatmaps + Pareto showing 80 % of loss in 3 zones.

## 6. Repository Map

```text
Motor_Insurance/
├── data/
│   ├── raw/                   # Source file
│   └── cleaned/               # Engineered KPIs
├── scripts/                   # SAS program
├── visuals/                   # Chart exports & Tableau dash
├── documents/                 # Formal write‑up
├── slides/                    # Exec deck
└── README.md
```

## 7. Contact

Bryce Smith · Data & Operations Analyst\
[brycesmithx@gmail.com](mailto\:brycesmithx@gmail.com)   |   [LinkedIn](https://www.linkedin.com/in/bryce-smith-b76583109/)

---

*Built with SAS · Tableau · Markdown.*

