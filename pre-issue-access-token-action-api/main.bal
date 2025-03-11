import ballerina/http;

type RiskResponse record {
     boolean hasRisk;
};

type RiskRequest record {
     string ip;
};

type ipGeolocationResp record {
     string ip;
     string country_code2;
};

final string geoApiKey = "9220f0511ace4b29882e08ccdefc2b4d";

service / on new http:Listener(8090) {
    resource function post addClaim(@http:Payload req) returns any {

        any resp = {
            "actionStatus": "SUCCESS",
            "operations": [
                {
                "op": "add",
                "path": "/accessToken/claims/-",
                "value": {
                    "name": "customSID",
                    "value": "12345"
                }
                }
            ]
        };
        return resp;
    }
}