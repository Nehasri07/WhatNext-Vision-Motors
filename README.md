# WhatNext Vision Motors
### Shaping the Future of Mobility with Innovation and Excellence

## Project Overview
WhatNext Vision Motors is a Salesforce CRM application developed to manage vehicle inventory, dealers, customers, vehicle orders, test drives, and service requests. It uses Salesforce automation to simplify order processing, customer communication, and service management.

## Objectives
- Maintain vehicle, dealer, and customer records.
- Manage vehicle orders and validate stock availability.
- Automatically process eligible pending orders using Batch Apex.
- Send email reminders for scheduled test drives.
- Notify dealers when customers submit service requests.
- Update service request status after dealer confirmation.
- Generate reports and dashboards for vehicle inventory monitoring.

## Technologies Used
- Salesforce Developer Edition
- Salesforce Flow Builder
- Apex Classes and Triggers
- Batch Apex and Scheduled Apex
- Custom Objects and Lookup Relationships
- Salesforce Reports and Dashboards

## Modules Implemented

### 1. Vehicle Management
Maintains vehicle details, models, stock quantities, prices, dealers, and availability status.

### 2. Dealer Management
Stores dealer information, including location, phone number, and email address.

### 3. Customer Management
Maintains customer details and supports their vehicle orders, test drives, and service requests.

### 4. Vehicle Order Management
Validates stock availability before an order can be confirmed. Batch Apex processes pending orders when stock is available and updates the remaining vehicle stock.

### 5. Test Drive Reminder
A record-triggered Flow with a scheduled path sends an email reminder one day before a scheduled test drive.

### 6. Service Request Management
When a service request is submitted, a Flow retrieves the associated vehicle and dealer and sends an email notification to the dealer. After confirmation, another Flow updates the request status to **In Progress**.

### 7. Reports and Dashboard
A vehicle stock report summarizes vehicle models, stock quantities, prices, statuses, and dealers. The dashboard provides a centralized view of inventory information.

## Apex Components
- **VehicleOrderTrigger:** Invokes the trigger handler before vehicle order records are inserted or updated.
- **VehicleOrderTriggerHandler:** Validates stock availability for orders being confirmed.
- **VehicleOrderBatch:** Processes pending orders, confirms eligible orders, and reduces stock quantities.
- **VehicleOrderBatchScheduler:** Schedules the batch process when configured.

## Screenshots
Add screenshots of the following:
- Vehicle inventory records
- Vehicle order confirmation and stock validation
- Apex classes and trigger
- Test drive reminder email
- Service request notification email
- Service request confirmation and status update
- Vehicle stock report
- WhatNext Vision Motors dashboard

Store screenshots in the `screenshots/` folder and insert them into this section using Markdown image links.

## Project Documentation
**Complete Documentation:** [View the Project Documentation PDF](docs/WhatNext_Vision_Motors_Documentation.pdf)

Make sure the PDF is uploaded to the `docs` folder using the same filename as the link above.

## Conclusion
WhatNext Vision Motors demonstrates the use of Salesforce CRM, Apex programming, and Flow Builder to manage vehicle inventory, automate order processing, schedule test drive reminders, and improve dealer communication and service request tracking.
---

## Project Documentation

[View Complete Project Documentation (PDF)](WhatsNext_Vision_Motors_Salesforce_Developer_Project_Documentation.pdf)
