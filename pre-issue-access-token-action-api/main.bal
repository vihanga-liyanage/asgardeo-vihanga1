import ballerina/http;
import ballerina/log;

service /tokenService on new http:Listener(8080) {

    resource function post processToken(http:Caller caller, http:Request req) returns error? {
        // Parse the JSON request payload
        json requestBody = check req.getJsonPayload();
        
        // Log the received request
        log:printInfo("Received request: " + requestBody.toJsonString());

        // Construct the response
        json responseBody = {
            "actionStatus": "SUCCESS",
            "operations": [
                {
                    "op": "replace",
                    "path": "/accessToken/claims/customAttribute",
                    "value": ["foo", "bar"]
                }
            ]
        };

        // Send the response
        check caller->respond(responseBody);
    }
}
