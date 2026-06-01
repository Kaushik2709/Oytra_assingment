# Automation & QA Assessment

This repository contains a completed automation and QA assessment with three deliverables:

- A QA bug report for the demo.realworld.io application
- An n8n workflow that creates a GitHub trending repositories brief
- A bonus n8n workflow that monitors uptime and sends alerts

## Project Summary

**Task 1: QA Bug Report**
The report documents issues found while testing the Conduit demo application, including functional, security, and user experience concerns. The main deliverable is [Task1_QA_Report.md](Task1_QA_Report.md).

**Task 2: GitHub Brief Workflow**
This n8n workflow fetches trending JavaScript repositories from GitHub, prepares a short summary, and is designed to send the result to Discord. The workflow file is [task2/Task2_Workflow.json](task2/Task2_Workflow.json).

**Bonus: Uptime Monitor**
This workflow checks a website on a schedule, measures response health, and can notify a Discord channel if downtime is detected. The workflow file is [bonus/Bonus_UptimeMonitor.json](bonus/Bonus_UptimeMonitor.json).

## How to Use

Import the n8n workflow JSON files into your n8n instance and configure the required credentials such as GitHub, Discord, and Google Sheets where needed.

To generate the PDF version of the QA report, run the script in the task1 folder.
