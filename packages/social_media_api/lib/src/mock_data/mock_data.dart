

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


  static dynamic getConstraintsMockData = [
    {
      "status": "OK",
      "networks": [
        {
          "id": "1",
          "name": "Facebook - oauth3+app",
          "engine": "Facebook",
          "properties": {
            "picture": {
              "formats": [
                "jpeg",
                "bmp",
                "png",
                "gif",
                "tiff"
              ],
              "min_size": 1048576,
              "max_size": 4194304,
              "properties": [
                {
                  "name": "landscape",
                  "width_min": 1200,
                  "height_min": 630,
                  "width_max": 2048,
                  "height_max": 1149,
                  "ratio": "1.91:1"
                },
                {
                  "name": "square",
                  "width_min": 1080,
                  "height_min": 1080,
                  "width_max": 2048,
                  "height_max": 2048,
                  "ratio": "1:1"
                },
                {
                  "name": "portrait",
                  "width_min": 1080,
                  "height_min": 1350,
                  "width_max": 2048,
                  "height_max": 3076,
                  "ratio": "4:5"
                }
              ]
            },
            "video": {
              "height_min": 1350,
              "width_min": 1080,
              "formats": [
                "mp4",
                "gif",
                "mov"
              ],
              "properties": [
                {
                  "width_min": 1080,
                  "height_min": 1080,
                  "width_max": 2048,
                  "height_max": 2048,
                  "ratio": "1:1"
                },
                {
                  "width_min": 1080,
                  "height_min": 800,
                  "width_max": 2048,
                  "height_max": 1149,
                  "ratio": "1.91:1"
                },
                {
                  "width_min": 1080,
                  "height_min": 1350,
                  "width_max": 2048,
                  "height_max": 3076,
                  "ratio": "4:5"
                }
              ],
              "duration_min": 0,
              "duration_max": 60,
              "max_rate": 30
            }
          }
        },
        {
          "id": "2",
          "name": "Instagram-eweb",
          "engine": "Instagram",
          "properties": {
            "picture": {
              "formats": [
                "jpeg",
                "bmp",
                "png",
                "gif",
                "tiff"
              ],
              "min_size": 1048576,
              "max_size": 4194304,
              "properties": [
                {
                  "name": "landscape",
                  "width_min": 1200,
                  "height_min": 630,
                  "width_max": 2048,
                  "height_max": 1149,
                  "ratio": "1.91:1"
                },
                {
                  "name": "square",
                  "width_min": 1080,
                  "height_min": 1080,
                  "width_max": 2048,
                  "height_max": 2048,
                  "ratio": "1:1"
                },
                {
                  "name": "portrait",
                  "width_min": 1080,
                  "height_min": 1350,
                  "width_max": 2048,
                  "height_max": 3076,
                  "ratio": "4:5"
                }
              ]
            },
            "video": {
              "height_min": 1350,
              "width_min": 1080,
              "formats": [
                "mp4",
                "gif",
                "mov"
              ],
              "properties": [
                {
                  "width_min": 1080,
                  "height_min": 1080,
                  "width_max": 2048,
                  "height_max": 2048,
                  "ratio": "1:1"
                },
                {
                  "width_min": 1080,
                  "height_min": 800,
                  "width_max": 2048,
                  "height_max": 1149,
                  "ratio": "1.91:1"
                },
                {
                  "width_min": 1080,
                  "height_min": 1350,
                  "width_max": 2048,
                  "height_max": 3076,
                  "ratio": "4:5"
                }
              ],
              "duration_min": 0,
              "duration_max": 60,
              "max_rate": 30
            }
          }
        },
        {
          "id": "3",
          "name": "LinkedIn-houssam",
          "engine": "LinkedIn",
          "properties": {
            "picture": {
              "formats": [
                "jpeg",
                "bmp",
                "png",
                "gif",
                "tiff"
              ],
              "min_size": 1048576,
              "max_size": 4194304,
              "properties": [
                {
                  "name": "landscape",
                  "width_min": 1200,
                  "height_min": 630,
                  "width_max": 2048,
                  "height_max": 1149,
                  "ratio": "1.91:1"
                },
                {
                  "name": "square",
                  "width_min": 1080,
                  "height_min": 1080,
                  "width_max": 2048,
                  "height_max": 2048,
                  "ratio": "1:1"
                },
                {
                  "name": "portrait",
                  "width_min": 1080,
                  "height_min": 1350,
                  "width_max": 2048,
                  "height_max": 3076,
                  "ratio": "4:5"
                }
              ]
            },
            "video": {
              "height_min": 1350,
              "width_min": 1080,
              "formats": [
                "mp4",
                "gif",
                "mov"
              ],
              "properties": [
                {
                  "width_min": 1080,
                  "height_min": 1080,
                  "width_max": 2048,
                  "height_max": 2048,
                  "ratio": "1:1"
                },
                {
                  "width_min": 1080,
                  "height_min": 800,
                  "width_max": 2048,
                  "height_max": 1149,
                  "ratio": "1.91:1"
                },
                {
                  "width_min": 1080,
                  "height_min": 1350,
                  "width_max": 2048,
                  "height_max": 3076,
                  "ratio": "4:5"
                }
              ],
              "duration_min": 0,
              "duration_max": 60,
              "max_rate": 30
            }
          }
        }
      ],
      "constraints": {
        "picture": {
          "formats": [
            "jpeg",
            "bmp",
            "png",
            "gif",
            "tiff",
            "jpg"
          ],
          "min_size": 10240,//10.24 KB
          "max_size": 4194304,//4.194304 MB
          "properties": [
            {
              "width_min": 1080,
              "height_min": 1080,
              "width_max": 2048,
              "height_max": 2048,
              "ratio": "1:1"
            },
            {
              "width_min": 1080,
              "height_min": 800,
              "width_max": 2048,
              "height_max": 1149,
              "ratio": "1.91:1"
            },
            {
              "width_min": 1080,
              "height_min": 1350,
              "width_max": 2048,
              "height_max": 3076,
              "ratio": "4:5"
            }
          ]
        },
        "video": {
          "formats": [
            "mp4",
            "gif",
            "mov"
          ]
        }
      },
    }
  ];


  static dynamic updateDocument = [
    {
      "status":"OK",
      "errors":{
        "xx":"xx is wrong"
      }
    },
    {
      "status":"OK",
      "error":"xxdsdgrgf"
    }
  ];
}