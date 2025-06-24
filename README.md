Swedish Motor Insurance – Risk Segmentation Case Study

Analyze regional claim data, quantify risk, and recommend premium multipliers for smarter pricing decisions.

1. Project Snapshot



Details

Goal

Identify geographic zones with elevated claim frequency, severity, and loss cost to inform data‑driven premium adjustments.

Dataset

Swedish Motor Insurance portfolio (zone‑level & policy‑level aggregates).

Tech Stack

SAS (data wrangling) • Tableau (dashboards) • Markdown / Word / PowerPoint (reporting & stakeholder comms).

Key Deliverables

Clean dataset · SAS code · Tableau dashboard & workbook · PDF report · Slide deck.

2. Business Questions

Which zones incur the highest average cost per policy?

Where are claims most frequent?

Which zones combine high frequency and high severity (worst‑case risk)?

What premium multipliers align pricing with zone‑level risk?

How can visual analytics improve underwriting decisions?

3. Repository Layout

/Motor_Insurance/
├── data/
│   ├── raw/
│   │   └── SwedishMotorInsurance.csv          # Original source data
│   └── cleaned/
│       └── zone_kpis.csv                      # Zone‑level risk metrics
├── scripts/
│   └── swedish_insurance.sas                  # End‑to‑end SAS program
├── visuals/
│   ├── charts/                                # PNG exports used in report & slides
│   │   ├── avgcostperpolicyzone.png
│   │   ├── CumulativeLossByZone.png
│   │   ├── FrequencyvsSeverity.png
│   │   ├── premium_multiplerzone.png
│   │   └── insurance_dashboard.png            # Thumbnail of Tableau dash
│   └── tableau/
│       └── SwedishMotorInsurance.twb          # Tableau workbook
├── documents/
│   └── Swedish Motor Insurance Analysis.pdf   # Formal write‑up
├── slides/
│   └── Swedish_Motors_Insurance.pptx          # Stakeholder slide deck
└── README.md                                  # You are here


4. Interactive Dashboard

A live synopsis of risk metrics is published on Tableau Public:

Swedish Motor Insurance – Risk Dashboard [text](https://public.tableau.com/app/profile/bryce.smith4541/viz/SwedishMotorInsurance/SwedishMotorInsuranceAnalysis)

(opens in a new tab)

5. Methodology in Brief

Data Wrangling (SAS) – Imported raw policy & claim counts, calculated loss cost (TotalCost ÷ Policies), applied IQR to flag outliers.

Risk Segmentation – Clustered zones via k‑means on frequency & severity → L/M/H risk tiers.

Premium Multiplier Logic – Graduated factor (1.00×, 1.15×, 1.35×) balances rate adequacy vs. competitiveness.

Visualization (Tableau) – Interactive heatmaps & scatter to pinpoint pricing pain points and illustrate ROI of repricing.

6. Key Insights

Zone 5 & Zone 8 show 30‑40 % higher loss cost than portfolio average → justify a 1.35× premium multiplier.

Zone 2 exhibits high claim frequency but moderate severity – target loss‑mitigation programs before steep rate hikes.

Portfolio‑wide repricing with recommended multipliers improves expected loss ratio by +6.2 pp.

7. Author

Bryce Smith – Data & Operations Analyst brycesmithx@gmail.com  •  [LinkedIn](https://www.linkedin.com/in/bryce-smith-b76583109/)

For questions or collaboration inquiries, please open an issue or reach out on LinkedIn.