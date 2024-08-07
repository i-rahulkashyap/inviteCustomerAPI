# Customer Invitation API

This API allows you to invite customers within a specified distance (100 km) from a given office location. Customers' data is provided via a text file, and the Haversine formula is used to calculate the distance between the office and each customer's location.

## Features

- Upload a text file with customer data.
- Calculate the distance between the office and each customer using the Haversine formula.
- Return a list of customers within 100 km of the office.

## Endpoints

### POST /api/v1/customers/invite

Invites customers within 100 km of the office based on the uploaded file.

#### Request

- **URL:** `/api/v1/customers/invite`
- **Method:** `POST`
- **Params:**
  - `file` (required): A text file containing customer data.

#### Response

- **Status:** `200 OK`
- **Content-Type:** `application/json`
- **Body:**
  ```json
  [
      {
          "user_id": 25,
          "name": "Pratik"
      },
      {
          "user_id": 32,
          "name": "Manish"
      }
  ]
