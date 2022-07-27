global class GA104006PhotoMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{'+
                         '}'
            );
            response.setStatusCode(200);
            return response; 
    }
}