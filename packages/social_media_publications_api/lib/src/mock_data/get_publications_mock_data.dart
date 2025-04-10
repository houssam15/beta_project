class GetPublicationsMockData {
  static dynamic success = {
    "status":"OK",
    "items":[
      {
        "id": "439",
        "dated_at": "2025-04-04 17:44:00",
        "created_at": "2025-04-04 17:43:54",
        "title": "aaaa",
        "description": "aaqa",
        "state": "inprogress",
        "status": "UPLOAD",
        "document": {
          "id": "394",
          "height": 500,
          "width": 500,
          "extension": "jpg",
          "size": 56294,
          "duration": 0,
          "file": {
            "picture": [
              {
                "type": "original",
                "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/document/394/1000028686.jpg"
              },
              {
                "type": "small",
                "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/document/pictures/394/small/1000028686.jpg"
              },
              {
                "type": "medium",
                "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/document/pictures/394/medium/1000028686.jpg"
              },
              {
                "type": "thumb",
                "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/document/pictures/394/thumb/1000028686.jpg"
              }
            ]
          }
        },
        "documents": [
          {
            "id": "18",
            "height": 500,
            "width": 500,
            "extension": "jpg",
            "size": 56294,
            "duration": 0,
            "account": {
              "id": "1",
              "name": "Facebook-ouath3",
              "page": "123254577",
              "engine": "Facebook"
            },
            "is_valid": false,
            "file": {
              "picture": [
                {
                  "type": "original",
                  "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/publication/document/18/1000028686.jpg"
                },
                {
                  "type": "small",
                  "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/publication/document/pictures/18/small/1000028686.jpg"
                },
                {
                  "type": "medium",
                  "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/publication/document/pictures/18/medium/1000028686.jpg"
                },
                {
                  "type": "thumb",
                  "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/publication/document/pictures/18/thumb/1000028686.jpg"
                }
              ]
            }
          },
          {
            "id": "19",
            "height": 5200,
            "width": 5040,
            "extension": "png",
            "size": 562794,
            "duration": 5000,
            "account": {
              "id": "2",
              "name": "Facebook-ouath3",
              "page": "123254577",
              "engine": "Instagram"
            },
            "is_valid": true,
            "file": {
              "picture": [
                {
                  "type": "original",
                  "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/publication/document/18/1000028686.jpg"
                },
                {
                  "type": "small",
                  "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/publication/document/pictures/18/small/1000028686.jpg"
                },
                {
                  "type": "medium",
                  "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/publication/document/pictures/18/medium/1000028686.jpg"
                },
                {
                  "type": "thumb",
                  "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/publication/document/pictures/18/thumb/1000028686.jpg"
                }
              ]
            }
          }
        ]
      },
    ]
  };


  static dynamic failed = {
    "status":"OK",
    "errors":{
      "param 1":"param 1 is invalid"
    }
  };
}