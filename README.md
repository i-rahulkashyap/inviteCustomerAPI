# Customer Invitation API

This API allows you to invite customers within a specified distance (100 km) from a given office location. Customers' data is provided via a text file, and the Haversine formula is used to calculate the distance between the office and each customer's location.

## Features

- Upload a text file with customer data.
- Calculate the distance between the office and each customer using the Haversine formula.
- Return a list of customers within 100 km of the office.

# API Documentation

## Endpoint: Process Customer Data

### Description
This endpoint processes a file containing customer data and returns a list of customers sorted by user_id who are within 100km of the office.

### Request Details
- **Method**: POST
- **URL**: `/api/v1/customers/invite`
- **Content-Type**: multipart/form-data

### Input
The request should include a file upload with the customer data in JSON format. 
- **Parameter Name**: file
- **File Format**: Text file containing JSON objects, one per line

#### Example `customers.txt` content:
{"user_id": 1, "name": "Vivaan Sharma", "latitude": "-68.850431", "longitude": "-35.814792"}
{"user_id": 25, "name": "Pratik", "latitude": "19.059507", "longitude": "72.851108"}

### Output
A JSON array of customer objects, each containing `user_id` and `name`, sorted by `user_id`.

#### Example Response:
```json
[
  {
    "user_id": 25,
    "name": "Pratik"
  }
]
```

## Error Responses
* **400 Bad Request**: If the file is missing or the file format is incorrect.
* **500 Internal Server Error**: If there is an error processing the file.

Example Error Response:

```json
{
  "error": "File is missing or invalid format"
}
```

## Implementation Notes

* The service reads the file, parses each line as a JSON object, and filters customers based on their distance from the office.
* The office coordinates are assumed to be fixed and known.
* The service sorts the filtered customers by `user_id` before returning the result.


