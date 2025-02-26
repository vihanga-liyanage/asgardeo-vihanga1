import ballerina/http;
import ballerina/log;

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
     resource function post risk(@http:Payload RiskRequest req) returns RiskResponse|error? {

          string ip = req.ip;
          log:printInfo("Calling Geo location service for IP: " + ip);
          http:Client ipGeolocation = check new ("https://api.ipgeolocation.io");
          ipGeolocationResp geoResponse = check ipGeolocation->get(string `/ipgeo?apiKey=${geoApiKey}&ip=${ip}&fields=country_code2`);

          log:printInfo("Recevied response: " + geoResponse.toBalString());
          
          RiskResponse resp = {
               // hasRisk is true if the country code of the IP address is not the specified country code.
               hasRisk: geoResponse.country_code2 != "LK"
          };
          return resp;
     }
}
