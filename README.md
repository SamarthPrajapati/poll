# poll system 

This Flutter project implements features for creating polls and displaying them in a list with infinite scrolling. It integrates with a provided API for authentication and fetching poll data.

## Poll Creation Feature with API Integration
Description  
Authentication: Implement a login feature for user authentication. Obtain the token necessary for accessing the API upon successful authentication.  
Poll Creation: Create a poll interface based on the provided Figma design. Integrate with the API for creating polls. Handle errors and display appropriate notifications to the user.  
API Integration Details  
URL: https://dev.stance.live/api/polls  
HTTP Method: POST  
Response Format: JSON with 'code' and 'reason' keys  
Authentication Details  
Import the provided Postman collection and environment file.  
Use the generated token for API calls in the format: Headers = {"Authorization": "Token <your generated token>"}  
## Infinite Scroll Polls List Feature  
Description  
Implement infinite scroll functionality for the polls list screen. Load new polls as the user scrolls down.  
Display each poll item with relevant details like question and options.  
API Integration Details  
URL: https://dev.stance.live/api/polls  
HTTP Method: GET  
Response Format: JSON with 'code' and 'reason' keys  
Authentication Details  
Use the same token obtained during Task 1 authentication.  
