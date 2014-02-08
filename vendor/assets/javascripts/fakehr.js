(function(){
  // Extends FakeXMLHttpRequest to register each new
  // request with fakehr
  function FakeRequest(){
    FakeXMLHttpRequest.call(this);
    fakehr.addRequest(this);
  }
  FakeRequest.prototype = FakeXMLHttpRequest.prototype;

  // reference the native XMLHttpRequest object so
  // it can be restored lated
  var nativeRequest = window.XMLHttpRequest;

  var fakehr = {
    addRequest: function(r){
      this.requests.push(r);
    },
    start: function(){
      this.requests = this.requests ||[];
      window.XMLHttpRequest = FakeRequest;
    },
    stop: function(){
      window.XMLHttpRequest = nativeRequest;
    },
    clear: function(){
      var requests = this.requests;
      // removes the objects from the original array
      // just in case someone is referencing it.
      // the removed requests will never get a response.
      while (requests.length > 0) {
        requests.pop();
      }
    },
    reset: function(){
      this.stop();
      this.clear();
    },
    match: function(method, url, readyState){
      if (readyState === undefined) { readyState = 1;}

      var requests = this.requests;
      for (var i = requests.length - 1; i >= 0; i--) {
        var request = requests[i];
        if(request.method.toLowerCase() === method.toLowerCase() && request.url === url && request.readyState === readyState) {
          return request;
        }
      };
    }
  }

  window.fakehr = fakehr;
})();
