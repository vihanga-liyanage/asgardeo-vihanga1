import ballerina/http;
import ballerina/log;

service /tokenService on new http:Listener(8080) {

    resource function post processToken(http:Caller caller, http:Request req) returns error? {
        // Parse the JSON request payload
        json requestBody = check req.getJsonPayload();
        
        // Log the received request
        log:printInfo("Received request: " + requestBody.toJsonString());

        // Default response
        json responseBody = {
            "actionStatus": "SUCCESS",
            "operations": [
                {
                    "op": "add",
                    "path": "/accessToken/claims/-",
                    "value": {
                        "name": "roles",
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
                        "name": "entity_id",
                        "value": "76e84daa-c954-4c6a-8f7f-09758c078669"
                    }
                }
            ]
        };

        // Create an HTTP response object with status 200
        http:Response response = new;
        response.statusCode = http:STATUS_OK; // 200 OK
        response.setPayload(responseBody);

        // Send the response
        check caller->respond(response);
    }
}
