

class UploadDocumentMockData{
  static dynamic data = [
    //success
    {
      "id":1,
      "publication_id":2
    },
    //success with social media notes
    {
      "id":1,
      "publication_id":2,
      "notes":["this file is not valid for facebook"]
    },
    //failed with error
    {
      "error":"error happen when uploading document"
    },
    //failed with errors
    {
      "errors":["error happen when uploading document"]
    },
    //Not accepted cases
    //success with error or errors
    {
      "id":1,
      "publication_id":2,
      "error":"xxx"
    },
    {
      "id":1,
      "publication_id":2,
      "errors":["xxx"]
    },
    {
      "id":1,
      "publication_id":2,
      "errors":["xxx"],
      "error":"xxx"
    },
    //success with bad types
    {
      "id":"1",
      "publication_id":2
    },
    //failed with bad types
    {
      "errors":"xxx"
    },
    //failed with success params
    {
      "id":1,
      "publication_id":2,
      "errors":["xxx"]
    },
    //failed with success params
    {
      "notes":["xxx"],
      "errors":["xxx"]
    }
  ];

  static dynamic uploadDocumentForPublication = [
    {
      "status": "OK",
      "id": 114,
      "publication_id": 159,
      "data": {
        "picture": [
          {
            "type": "original",
            "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/document/114/1000028157.png"
          },
          {
            "type": "small",
            "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/document/pictures/114/small/1000028157.png"
          },
          {
            "type": "medium",
            "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/document/pictures/114/medium/1000028157.png"
          },
          {
            "type": "thumb",
            "url": "https://bridge.ewebsolutionskech-dev.com/customers/socialnetwork/manager/download/document/pictures/114/thumb/1000028157.png"
          }
        ]
      },
      "warnings": {
        "is_rotation_required": true,
        "networks": [
          {
            "engine": "Facebook",
            "id": "1",
            "name":"Facebook for business",
            "is_resized_required": false,
            "is_undersized": false,
            "is_ratio_undersized": false,
            "ratio": "1",
            "messages":[
              "Facebook publication message"
            ]
          },
          {
            "engine": "Instagram",
            "name":"Instagram for business",
            "id": "1",
            "is_resized_required": false,
            "is_undersized": false,
            "is_ratio_undersized": false,
            "ratio": "1",
            "messages":[
              "Facebook publication message"
            ]
          },
          {
            "engine": "Linkedin",
            "id": "1",
            "name":"Linkedin for business",
            "is_resized_required": false,
            "is_undersized": false,
            "is_ratio_undersized": false,
            "ratio": "1",
            "messages":[
              "Facebook publication message"
            ]
          },
          {
            "engine": "Linkedin",
            "id": "1",
            "name":"Linkedin for business 2",
            "is_resized_required": false,
            "is_undersized": false,
            "is_ratio_undersized": false,
            "ratio": "1",
            "messages":[
              "Facebook publication message"
            ]
          }
        ],
        "real_ratio": 1,
        "height": 1080,
        "width": 1080,
        "messages":[
          "global message"
        ]
      }
    }
  ];

}