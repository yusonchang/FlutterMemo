使用FCM接收通知測試

發送Notification到FCM
http:
curl -X POST  https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -H "Authorization:key=FCM的ServerKey" -d '{ "notification": {    "title": "postman",    "body": "hello postman",	"text": "Text"  },  "to" : "接收Token"}'

httpv1：
curl -X POST -H "Authorization:Bearer FCMAccessToken" -H "Content-Type: application/json" -d '{"message":{  "notification": {    "title": "FCM Message",    "body": "This is an FCM Message",  },  "token": "接收Token"  }}' https://fcm.googleapis.com/v1/projects/scottishhousedemo/messages:send
