

class MockData{
  static dynamic getSocialMediaListData = [
    {
      "id":1,
      "icon":"facebook",
      "title":"Facebook account",
      "error":{
        "errorType":"INVALID_DIMENSIONS",
        "messages":[
          "image is small",
          "image invalid",
        ],
        "validConstraints":{
          "minHeight":100,
          "maxHeight":200,
          "minWidth":100,
          "maxWidth":200
        },
      }
    },
    {
      "id":2,
      "icon":"instagram",
      "title":"Instagram account",
      "uploadUrl": "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
    }
  ];
}