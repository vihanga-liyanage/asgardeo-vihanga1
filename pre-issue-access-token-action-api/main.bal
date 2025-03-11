import ballerina/http;
import ballerina/log;

service /tokenService on new http:Listener(8080) {

    resource function post processToken(http:Caller caller, http:Request req) returns error? {
        // Parse the JSON request payload
        json requestBody = check req.getJsonPayload();
        
        // Log the received request
        log:printInfo("Received request: " + requestBody.toJsonString());

        // Extract clientId from the request
        json|error clientId = requestBody.event.request.clientId;

        // Default response
        json responseBody = { "actionStatus": "SUCCESS" };

        // If clientId matches, include allowedOperations
        if clientId is string && clientId == "pChqfVSuiZpLBneFG39hP1LTfOMa" {
            responseBody = {
                "actionStatus": "SUCCESS",
                "operations": [
                    {
                        "op": "add",
                        "path": "/accessToken/claims/-",
                        "value": {
                            "name": "entity_id",
                            "value": [
                                "SYSTEM_ONBOARDING_BACKEND",
                                "SYSTEM_EVENTS_PUBLISHER",
                                "ESTATE_OWNER_ADMIN",
                                "VERIFONE_ADMIN"
                            ]
                        }
                    },
                    {
                        "op": "add",
                        "path": "/accessToken/claims/-",
                        "value": {
                            "name": "roles",
                            "value": "76e84daa-c954-4c6a-8f7f-09758c078669"
                        }
                    }
                ]
            };
        }

        // Create an HTTP response object with status 200
        http:Response response = new;
        response.statusCode = http:STATUS_OK; // 200 OK
        response.setPayload(responseBody);

        // Send the response
        check caller->respond(response);
    }
}
