# Madrid Housing Price Prediction – End-to-End ML Pipeline (Google Cloud)

## 📌 Project Overview

This project implements an end-to-end Machine Learning pipeline to predict housing prices in Madrid using Google Cloud Platform.

The goal was not only to train a model, but to design and execute a production-style workflow using BigQuery, Vertex AI, Cloud Storage and IAM configuration.

---

## 🏗 Architecture

Data Flow:

1. Raw CSV uploaded to Google Cloud Storage
2. Data loaded into BigQuery
3. Feature preparation in BigQuery
4. Model training using Vertex AI AutoML (Tabular)
5. Model evaluation
6. Batch prediction exported to Cloud Storage

Technologies used:

- BigQuery
- Vertex AI (AutoML Tabular)
- Cloud Storage
- IAM & Service Accounts
- Batch Prediction
- SQL

---

## 📊 Dataset

Dataset: Madrid Housing Prices  
Features:

- rooms
- m2
- elevator
- garage
- neighborhood
- district
- house_type

Target variable:

- price

---

## 🤖 Model Training

Model type: Regression  
Training method: Vertex AI AutoML Tabular  
Region: us-central1  

Evaluation Metrics:

- MAE: 98,893
- MAPE: 17.35%
- RMSE: 222,112
- RMSLE: 0.219
- R²: 0.904

The model explains approximately 90% of the variance in housing prices.

---

## 🔍 Batch Prediction

Batch inference was executed using:

- Input: CSV stored in Cloud Storage
- Output: Predictions exported to Cloud Storage
- Predicted column: predicted_price

---

## ⚙️ Engineering Challenges Solved

- BigQuery permission errors (403 Access Denied)
- IAM role configuration for service accounts
- Cloud Storage access policies
- Batch inference output formatting
- Dataset regional configuration mismatch

---

## 📈 What This Project Demonstrates

- End-to-end ML workflow in GCP
- Data engineering fundamentals
- Cloud IAM management
- BigQuery SQL usage
- Model deployment and batch prediction
- Debugging real cloud infrastructure issues

---

## 🚀 Future Improvements

- Feature engineering pipeline automation
- CI/CD for model retraining
- API endpoint deployment
- Monitoring & drift detection

---

## 👤 Author

Rafa Onieva  
Data Engineer / Machine Learning Engineer  
